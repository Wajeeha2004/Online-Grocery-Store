Imports System.Data
Imports System.Data.SqlClient

Partial Class Checkout
    Inherits System.Web.UI.Page

    Private connectionString As String = "workstation id=Grocery_store.mssql.somee.com;packet size=4096;user id=wajeeha2004_SQLLogin_1;pwd=z1xo3teh8f;data source=Grocery_store.mssql.somee.com;persist security info=False;initial catalog=Grocery_store;TrustServerCertificate=True"

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As EventArgs) Handles Me.Load
        If Session("UserID") Is Nothing Then
            Response.Redirect("User_Login.aspx")
            Return
        End If

        If Not IsPostBack Then
            LoadCartItems()
            CalculateTotal()
            LoadUserAddress()
        End If
    End Sub

    Private Sub LoadUserAddress()
        Dim userId As Integer = Convert.ToInt32(Session("UserID"))

        Using conn As New SqlConnection(connectionString)
            Dim cmd As New SqlCommand("SELECT Cust_Address FROM Customer WHERE Customer_ID = @CustomerID", conn)
            cmd.Parameters.AddWithValue("@CustomerID", userId)

            conn.Open()
            Dim result = cmd.ExecuteScalar()
            If result IsNot Nothing AndAlso Not IsDBNull(result) Then
                txtShippingAddress.Text = result.ToString()
            End If
        End Using
    End Sub

    Private Sub LoadCartItems()
        Dim userId As Integer = Convert.ToInt32(Session("UserID"))

        Using conn As New SqlConnection(connectionString)
            Dim cmd As New SqlCommand("SELECT p.Prod_Name, p.Price, c.Quantity, (p.Price * c.Quantity) AS Subtotal " &
                                  "FROM Cart c INNER JOIN Product p ON c.Product_ID = p.Product_ID " &
                                  "WHERE c.Customer_ID = @CustomerID", conn)
            cmd.Parameters.AddWithValue("@CustomerID", userId)

            Dim da As New SqlDataAdapter(cmd)
            Dim dt As New DataTable()
            da.Fill(dt)

            gvOrderItems.DataSource = dt
            gvOrderItems.DataBind()
        End Using
    End Sub

    Private Sub CalculateTotal()
        Dim userId As Integer = Convert.ToInt32(Session("UserID"))
        Dim subtotal As Decimal = 0

        Using conn As New SqlConnection(connectionString)
            Dim cmd As New SqlCommand("SELECT SUM(p.Price * c.Quantity) AS Total " &
                                  "FROM Cart c INNER JOIN Product p ON c.Product_ID = p.Product_ID " &
                                  "WHERE c.Customer_ID = @CustomerID", conn)
            cmd.Parameters.AddWithValue("@CustomerID", userId)

            conn.Open()
            Dim result = cmd.ExecuteScalar()
            If result IsNot Nothing AndAlso Not IsDBNull(result) Then
                subtotal = Convert.ToDecimal(result)
            End If
        End Using

        lblSubtotal.Text = String.Format("Rs. {0:N2}", subtotal)
        lblTotal.Text = lblSubtotal.Text
    End Sub

    Protected Sub btnPlaceOrder_Click(sender As Object, e As EventArgs) Handles btnPlaceOrder.Click
        If Not Page.IsValid Then Exit Sub

        Dim userId As Integer = Convert.ToInt32(Session("UserID"))

        Using conn As New SqlConnection(connectionString)
            conn.Open()
            Dim transaction As SqlTransaction = conn.BeginTransaction()

            Try
                ' 1. Create Billing Info
                Dim billingId As Integer = Convert.ToInt32(New SqlCommand("SELECT ISNULL(MAX(Billing_ID), 0) + 1 FROM Billing_info", conn, transaction).ExecuteScalar())

                Dim billingCmd As New SqlCommand("INSERT INTO Billing_info (Billing_ID, Bill_Date, Customer_ID) VALUES (@BillingID, GETDATE(), @CustomerID)", conn, transaction)
                billingCmd.Parameters.AddWithValue("@BillingID", billingId)
                billingCmd.Parameters.AddWithValue("@CustomerID", userId)
                billingCmd.ExecuteNonQuery()

                ' 2. Create Address record if different from customer address
                Dim customerAddress As String = ""
                Dim getAddressCmd As New SqlCommand("SELECT Cust_Address FROM Customer WHERE Customer_ID = @CustomerID", conn, transaction)
                getAddressCmd.Parameters.AddWithValue("@CustomerID", userId)
                customerAddress = getAddressCmd.ExecuteScalar().ToString()

                If Not txtShippingAddress.Text.Trim().Equals(customerAddress.Trim(), StringComparison.OrdinalIgnoreCase) Then
                    Dim addressId As Integer = Convert.ToInt32(New SqlCommand("SELECT ISNULL(MAX(Address_ID), 0) + 1 FROM Address", conn, transaction).ExecuteScalar())

                    Dim addressCmd As New SqlCommand("INSERT INTO Address (Address_ID, Customer_ID, Bill_Address) VALUES (@AddressID, @CustomerID, @Address)", conn, transaction)
                    addressCmd.Parameters.AddWithValue("@AddressID", addressId)
                    addressCmd.Parameters.AddWithValue("@CustomerID", userId)
                    addressCmd.Parameters.AddWithValue("@Address", txtShippingAddress.Text.Trim())
                    addressCmd.ExecuteNonQuery()
                End If

                ' 3. Create Order
                Dim orderId As Integer = Convert.ToInt32(New SqlCommand("SELECT ISNULL(MAX(Order_ID), 0) + 1 FROM [Customer_Order]", conn, transaction).ExecuteScalar())

                Dim orderCmd As New SqlCommand("INSERT INTO [Customer_Order] (Order_ID, Order_Date, Customer_ID, Shipping_Method, Billing_ID) VALUES (@OrderID, GETDATE(), @CustomerID, @ShippingMethod, @BillingID)", conn, transaction)
                orderCmd.Parameters.AddWithValue("@OrderID", orderId)
                orderCmd.Parameters.AddWithValue("@CustomerID", userId)
                orderCmd.Parameters.AddWithValue("@ShippingMethod", ddlShippingMethod.SelectedValue)
                orderCmd.Parameters.AddWithValue("@BillingID", billingId)
                orderCmd.ExecuteNonQuery()

                ' 4. Process Order Details
                Dim cartItems As New DataTable()
                Dim getCartCmd As New SqlCommand("SELECT c.Product_ID, c.Quantity, p.Price, p.Quantity AS AvailableQty FROM Cart c INNER JOIN Product p ON c.Product_ID = p.Product_ID WHERE c.Customer_ID = @CustomerID", conn, transaction)
                getCartCmd.Parameters.AddWithValue("@CustomerID", userId)

                Using da As New SqlDataAdapter(getCartCmd)
                    da.Fill(cartItems)
                End Using

                For Each row As DataRow In cartItems.Rows
                    Dim productId As Integer = Convert.ToInt32(row("Product_ID"))
                    Dim quantity As Integer = Convert.ToInt32(row("Quantity"))
                    Dim availableQty As Integer = Convert.ToInt32(row("AvailableQty"))
                    Dim price As Decimal = Convert.ToDecimal(row("Price"))

                    If quantity > availableQty Then
                        Throw New Exception(String.Format("Not enough stock for product ID {0}. Available: {1}, Requested: {2}", productId, availableQty, quantity))
                    End If

                    ' Insert Order Details
                    Dim orderDetailsId As Integer = Convert.ToInt32(New SqlCommand("SELECT ISNULL(MAX(Order_Details_ID), 0) + 1 FROM Order_Details", conn, transaction).ExecuteScalar())

                    Dim orderDetailsCmd As New SqlCommand("INSERT INTO Order_Details (Order_Details_ID, Product_ID, Order_ID, Quantity) VALUES (@OrderDetailsID, @ProductID, @OrderID, @Quantity)", conn, transaction)
                    orderDetailsCmd.Parameters.AddWithValue("@OrderDetailsID", orderDetailsId)
                    orderDetailsCmd.Parameters.AddWithValue("@ProductID", productId)
                    orderDetailsCmd.Parameters.AddWithValue("@OrderID", orderId)
                    orderDetailsCmd.Parameters.AddWithValue("@Quantity", quantity)
                    orderDetailsCmd.ExecuteNonQuery()

                    ' Update Product Inventory
                    Dim updateProductCmd As New SqlCommand("UPDATE Product SET Quantity = Quantity - @Quantity WHERE Product_ID = @ProductID", conn, transaction)
                    updateProductCmd.Parameters.AddWithValue("@Quantity", quantity)
                    updateProductCmd.Parameters.AddWithValue("@ProductID", productId)
                    updateProductCmd.ExecuteNonQuery()
                Next

                ' 5. Clear the cart
                Dim clearCartCmd As New SqlCommand("DELETE FROM Cart WHERE Customer_ID = @CustomerID", conn, transaction)
                clearCartCmd.Parameters.AddWithValue("@CustomerID", userId)
                clearCartCmd.ExecuteNonQuery()

                transaction.Commit()

                ' Display success message
                lblMessage.CssClass = "success-message message"
                lblMessage.Text = String.Format("Order placed successfully! Order ID: {0}", orderId)
                lblMessage.Visible = True

                ' Clear the UI
                gvOrderItems.DataSource = Nothing
                gvOrderItems.DataBind()
                lblSubtotal.Text = "Rs. 0.00"
                lblTotal.Text = "Rs. 0.00"
                btnPlaceOrder.Enabled = False

            Catch ex As Exception
                transaction.Rollback()
                lblMessage.CssClass = "error-message message"
                lblMessage.Text = "An error occurred while placing the order: " & ex.Message
                lblMessage.Visible = True
            End Try
        End Using
    End Sub
End Class