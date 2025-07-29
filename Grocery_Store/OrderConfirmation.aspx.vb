Imports System.Data
Imports System.Data.SqlClient

Partial Class OrderConfirmation
    Inherits System.Web.UI.Page

    Private connectionString As String = "workstation id=Grocery_store.mssql.somee.com;packet size=4096;user id=wajeeha2004_SQLLogin_1;pwd=z1xo3teh8f;data source=Grocery_store.mssql.somee.com;persist security info=False;initial catalog=Grocery_store;TrustServerCertificate=True"

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Session("UserID") Is Nothing Then
            Response.Redirect("User_Login.aspx")
            Return
        End If

        If Not IsPostBack Then
            If Session("OrderID") Is Nothing Then
                Response.Redirect("User_Dash.aspx")
            Else
                DisplayOrderConfirmation(Convert.ToInt32(Session("OrderID")))
                Session.Remove("OrderID")
            End If
        End If
    End Sub

    Private Sub DisplayOrderConfirmation(orderId As Integer)
        Dim userId As Integer = Convert.ToInt32(Session("UserID"))

        Using conn As New SqlConnection(connectionString)
            ' Get order summary
            Dim cmd As New SqlCommand("SELECT o.Order_ID, o.Order_Date, o.Shipping_Method, a.Bill_Address " &
                                     "FROM [Customer_Order] o " &
                                     "JOIN Billing_info b ON o.Billing_ID = b.Billing_ID " &
                                     "JOIN Address a ON b.Customer_ID = a.Customer_ID " &
                                     "WHERE o.Order_ID = @OrderID AND o.Customer_ID = @CustomerID", conn)
            cmd.Parameters.AddWithValue("@OrderID", orderId)
            cmd.Parameters.AddWithValue("@CustomerID", userId)

            conn.Open()
            Dim reader As SqlDataReader = cmd.ExecuteReader()

            If reader.Read() Then
                lblOrderId.Text = reader("Order_ID").ToString()
                lblOrderDate.Text = Convert.ToDateTime(reader("Order_Date")).ToString("MMMM dd, yyyy")
                lblShippingAddress.Text = reader("Bill_Address").ToString()
                lblShippingMethod.Text = reader("Shipping_Method").ToString()
            End If
            reader.Close()

            ' Get order items
            Dim itemsCmd As New SqlCommand("SELECT p.Prod_Name, od.Price, od.Quantity, (od.Price * od.Quantity) AS Subtotal " &
                                          "FROM Order_Details od " &
                                          "JOIN Product p ON od.Product_ID = p.Product_ID " &
                                          "WHERE od.Order_ID = @OrderID", conn)
            itemsCmd.Parameters.AddWithValue("@OrderID", orderId)

            Dim da As New SqlDataAdapter(itemsCmd)
            Dim dt As New DataTable()
            da.Fill(dt)

            gvOrderItems.DataSource = dt
            gvOrderItems.DataBind()

            ' Calculate total
            Dim totalCmd As New SqlCommand("SELECT SUM(Price * Quantity) AS Total FROM Order_Details WHERE Order_ID = @OrderID", conn)
            totalCmd.Parameters.AddWithValue("@OrderID", orderId)

            Dim total As Decimal = Convert.ToDecimal(totalCmd.ExecuteScalar())
            lblTotal.Text = String.Format("Rs. {0:N2}", total)
        End Using
    End Sub

    Protected Sub btnContinueShopping_Click(sender As Object, e As EventArgs)
        Response.Redirect("User_Dash.aspx")
    End Sub
End Class