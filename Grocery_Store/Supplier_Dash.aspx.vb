Imports System.Data
Imports System.Data.SqlClient

Partial Class Supplier_Dash
    Inherits System.Web.UI.Page

    Public connectionString As String = "workstation id=Grocery_store.mssql.somee.com;packet size=4096;user id=wajeeha2004_SQLLogin_1;pwd=z1xo3teh8f;data source=Grocery_store.mssql.somee.com;persist security info=False;initial catalog=Grocery_store;TrustServerCertificate=True"
    Private supplierID As Integer

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Session("SupplierID") Is Nothing Then
            Response.Redirect("Supplier_Login.aspx")
            Return
        End If

        supplierID = Convert.ToInt32(Session("SupplierID"))

        If Not IsPostBack Then
            ' Optionally load something here on first page load
        End If
    End Sub

    ' Utility to show one panel at a time
    Private Sub ShowOnlyPanel(panelToShow As Panel)
        pnlAddProduct.Visible = False
        pnlDeleteProduct.Visible = False
        pnlUpdateProduct.Visible = False
        pnlViewProducts.Visible = False
        pnlViewOrders.Visible = False

        panelToShow.Visible = True
    End Sub

    ' Event handlers for navigation
    Protected Sub btnAddProduct_Click(sender As Object, e As EventArgs) Handles btnAddProduct.Click
        ShowOnlyPanel(pnlAddProduct)
        LoadCategories()
    End Sub

    Protected Sub btnDeleteProduct_Click(sender As Object, e As EventArgs) Handles btnDeleteProduct.Click
        ShowOnlyPanel(pnlDeleteProduct)
        ViewSupplierProducts(gvSupplierProducts)
    End Sub

    Protected Sub btnUpdateProduct_Click(sender As Object, e As EventArgs) Handles btnUpdateProduct.Click
        ShowOnlyPanel(pnlUpdateProduct)
        ViewSupplierProducts(gvProductsForUpdate)
    End Sub

    Protected Sub btnViewProducts_Click(sender As Object, e As EventArgs) Handles btnViewProducts.Click
        ShowOnlyPanel(pnlViewProducts)
        ViewSupplierProducts(gvYourProducts)
    End Sub

    Protected Sub btnViewOrders_Click(sender As Object, e As EventArgs) Handles btnViewOrders.Click
        ShowOnlyPanel(pnlViewOrders)
        ViewProductOrders()
    End Sub

    ' Load Categories (to dropdown or grid)
    Private Sub LoadCategories()
        Using conn As New SqlConnection(connectionString)
            Dim cmd As New SqlCommand("SELECT Category_ID, Cat_Name FROM Category", conn)
            Dim da As New SqlDataAdapter(cmd)
            Dim dt As New DataTable()
            da.Fill(dt)
            gvCategories.DataSource = dt
            gvCategories.DataBind()
        End Using
    End Sub

    ' Add Product
    Protected Sub btnSubmitProduct_Click(sender As Object, e As EventArgs) Handles btnSubmitProduct.Click
        Try
            Dim productID As Integer

            Using conn As New SqlConnection(connectionString)
                Dim cmd As New SqlCommand("SELECT ISNULL(MAX(Product_ID), 0) + 1 FROM Product", conn)
                conn.Open()
                productID = Convert.ToInt32(cmd.ExecuteScalar())
            End Using

            Using conn As New SqlConnection(connectionString)
                Dim cmd As New SqlCommand("INSERT INTO Product (Product_ID, Prod_Name, Prod_Description, Category_ID, Supplier_ID, Price, Quantity) " &
                                          "VALUES (@ProductID, @Name, @Description, @CategoryID, @SupplierID, @Price, @Quantity)", conn)

                cmd.Parameters.AddWithValue("@ProductID", productID)
                cmd.Parameters.AddWithValue("@Name", txtProdName.Text)
                cmd.Parameters.AddWithValue("@Description", txtProdDesc.Text)
                cmd.Parameters.AddWithValue("@CategoryID", Convert.ToInt32(txtCategoryID.Text))
                cmd.Parameters.AddWithValue("@SupplierID", supplierID)
                cmd.Parameters.AddWithValue("@Price", Convert.ToDecimal(txtPrice.Text))
                cmd.Parameters.AddWithValue("@Quantity", Convert.ToInt32(txtQuantity.Text))

                conn.Open()
                cmd.ExecuteNonQuery()
            End Using

            lblAddProductMessage.Text = "Product added successfully!"
            lblAddProductMessage.CssClass = "message success"

        Catch ex As Exception
            lblAddProductMessage.Text = "Error: " & ex.Message
            lblAddProductMessage.CssClass = "message error"
        End Try
    End Sub

    ' Delete Product
    Protected Sub btnConfirmDelete_Click(sender As Object, e As EventArgs) Handles btnConfirmDelete.Click
        Dim productID As Integer
        If Not Integer.TryParse(txtDeleteProdID.Text, productID) Then
            lblDeleteMessage.Text = "Invalid Product ID"
            Return
        End If

        Using conn As New SqlConnection(connectionString)
            conn.Open()

            Dim checkCmd As New SqlCommand("SELECT COUNT(*) FROM Product WHERE Product_ID = @ProductID AND Supplier_ID = @SupplierID", conn)
            checkCmd.Parameters.AddWithValue("@ProductID", productID)
            checkCmd.Parameters.AddWithValue("@SupplierID", supplierID)

            If Convert.ToInt32(checkCmd.ExecuteScalar()) = 0 Then
                lblDeleteMessage.Text = "Product not found or not yours"
                Return
            End If

            Dim delCmd As New SqlCommand("DELETE FROM Product WHERE Product_ID = @ProductID", conn)
            delCmd.Parameters.AddWithValue("@ProductID", productID)
            delCmd.ExecuteNonQuery()

            lblDeleteMessage.Text = "Product deleted!"
            ViewSupplierProducts(gvSupplierProducts)
        End Using
    End Sub

    ' Load Product for Update
    Protected Sub btnLoadProduct_Click(sender As Object, e As EventArgs) Handles btnLoadProduct.Click
        Dim productID As Integer
        If Not Integer.TryParse(txtUpdateProdID.Text, productID) Then
            lblUpdateMessage.Text = "Invalid Product ID"
            Return
        End If

        Using conn As New SqlConnection(connectionString)
            Dim cmd As New SqlCommand("SELECT * FROM Product WHERE Product_ID = @ProductID AND Supplier_ID = @SupplierID", conn)
            cmd.Parameters.AddWithValue("@ProductID", productID)
            cmd.Parameters.AddWithValue("@SupplierID", supplierID)

            conn.Open()
            Dim reader As SqlDataReader = cmd.ExecuteReader()

            If reader.Read() Then
                txtUpdateName.Text = reader("Prod_Name").ToString()
                txtUpdateDesc.Text = reader("Prod_Description").ToString()
                txtUpdateCategory.Text = reader("Category_ID").ToString()
                txtUpdatePrice.Text = reader("Price").ToString()
                txtUpdateQuantity.Text = reader("Quantity").ToString()
                pnlProductDetails.Visible = True
            Else
                lblUpdateMessage.Text = "Product not found"
                pnlProductDetails.Visible = False
            End If
        End Using
    End Sub

    ' Update Product
    Protected Sub btnUpdateProductDetails_Click(sender As Object, e As EventArgs) Handles btnUpdateProductDetails.Click
        Dim productID As Integer
        If Not Integer.TryParse(txtUpdateProdID.Text, productID) Then
            lblUpdateMessage.Text = "Invalid Product ID"
            Return
        End If

        Using conn As New SqlConnection(connectionString)
            Dim cmd As New SqlCommand("UPDATE Product SET Prod_Name=@Name, Prod_Description=@Description, Category_ID=@CategoryID, Price=@Price, Quantity=@Quantity WHERE Product_ID=@ProductID AND Supplier_ID=@SupplierID", conn)

            cmd.Parameters.AddWithValue("@ProductID", productID)
            cmd.Parameters.AddWithValue("@SupplierID", supplierID)
            cmd.Parameters.AddWithValue("@Name", txtUpdateName.Text)
            cmd.Parameters.AddWithValue("@Description", txtUpdateDesc.Text)
            cmd.Parameters.AddWithValue("@CategoryID", Convert.ToInt32(txtUpdateCategory.Text))
            cmd.Parameters.AddWithValue("@Price", Convert.ToDecimal(txtUpdatePrice.Text))
            cmd.Parameters.AddWithValue("@Quantity", Convert.ToInt32(txtUpdateQuantity.Text))

            conn.Open()
            Dim rowsAffected As Integer = cmd.ExecuteNonQuery()

            If rowsAffected > 0 Then
                lblUpdateMessage.Text = "Product updated!"
                pnlProductDetails.Visible = False
                ViewSupplierProducts(gvProductsForUpdate)
            Else
                lblUpdateMessage.Text = "Update failed!"
            End If
        End Using
    End Sub

    ' View Products
    Private Sub ViewSupplierProducts(gridView As GridView)
        Try
            Using conn As New SqlConnection(connectionString)
                Dim cmd As New SqlCommand("SELECT p.Product_ID, p.Prod_Name, p.Prod_Description, c.Cat_Name AS Category, p.Price, p.Quantity FROM Product p JOIN Category c ON p.Category_ID = c.Category_ID WHERE p.Supplier_ID = @SupplierID", conn)
                cmd.Parameters.AddWithValue("@SupplierID", supplierID)

                Dim da As New SqlDataAdapter(cmd)
                Dim dt As New DataTable()
                da.Fill(dt)

                gridView.DataSource = dt
                gridView.DataBind()
            End Using
        Catch ex As Exception
            ' Handle or log error if needed
        End Try
    End Sub

    ' View Orders (Dummy)
    Private Sub ViewProductOrders()
        ' Add logic here to fetch and bind order data
    End Sub
End Class
