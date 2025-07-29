Imports System.Data.SqlClient

Partial Class AddToCart
    Inherits System.Web.UI.Page

    Private connStr As String = "workstation id=Grocery_store.mssql.somee.com;packet size=4096;user id=wajeeha2004_SQLLogin_1;pwd=z1xo3teh8f;data source=Grocery_store.mssql.somee.com;persist security info=False;initial catalog=Grocery_store;TrustServerCertificate=True"

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Session("UserID") Is Nothing Then
            Response.Redirect("User_Login.aspx")
            Return
        End If

        If Not IsPostBack AndAlso Request.QueryString("ProductID") IsNot Nothing Then
            Dim productId As Integer
            If Integer.TryParse(Request.QueryString("ProductID"), productId) Then
                AddToCart(productId)
            End If
        End If
        Response.Redirect("Cart.aspx")
    End Sub

    Private Sub AddToCart(productId As Integer)
        Dim userId As Integer = CInt(Session("UserID"))

        Using conn As New SqlConnection(connStr)
            conn.Open()

            ' Check if item already in cart
            Dim checkCmd As New SqlCommand("SELECT Quantity FROM Cart WHERE Customer_ID=@UserId AND Product_ID=@ProductId", conn)
            checkCmd.Parameters.AddWithValue("@UserId", userId)
            checkCmd.Parameters.AddWithValue("@ProductId", productId)

            Dim existingQty As Object = checkCmd.ExecuteScalar()

            If existingQty IsNot Nothing Then
                ' Update quantity
                Dim updateCmd As New SqlCommand("UPDATE Cart SET Quantity=Quantity+1 WHERE Customer_ID=@UserId AND Product_ID=@ProductId", conn)
                updateCmd.Parameters.AddWithValue("@UserId", userId)
                updateCmd.Parameters.AddWithValue("@ProductId", productId)
                updateCmd.ExecuteNonQuery()
            Else
                ' Add new item
                ' Get max Cart_ID
                Dim getMaxCmd As New SqlCommand("SELECT ISNULL(MAX(Cart_ID), 0) FROM Cart", conn)
                Dim maxId As Integer = Convert.ToInt32(getMaxCmd.ExecuteScalar())
                Dim newCartId As Integer = maxId + 1

                ' Insert with new Cart_ID
                Dim insertCmd As New SqlCommand("INSERT INTO Cart (Cart_ID, Customer_ID, Product_ID, Quantity) VALUES (@CartId, @UserId, @ProductId, 1)", conn)
                insertCmd.Parameters.AddWithValue("@CartId", newCartId)
                insertCmd.Parameters.AddWithValue("@UserId", userId)
                insertCmd.Parameters.AddWithValue("@ProductId", productId)
                insertCmd.ExecuteNonQuery()

            End If
        End Using

        Session("CartMessage") = "Item added to cart"
    End Sub
End Class