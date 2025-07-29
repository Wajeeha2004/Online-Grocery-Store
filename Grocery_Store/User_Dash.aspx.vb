Imports System.Data.SqlClient

Partial Class User_Dash
    Inherits System.Web.UI.Page

    Private connStr As String = "workstation id=Grocery_store.mssql.somee.com;packet size=4096;user id=wajeeha2004_SQLLogin_1;pwd=z1xo3teh8f;data source=Grocery_store.mssql.somee.com;persist security info=False;initial catalog=Grocery_store;TrustServerCertificate=True"

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Session("UserID") Is Nothing Then
            Response.Redirect("User_Login.aspx")
            Return
        End If

        If Not IsPostBack Then
            LoadProducts()
            LoadUserProfile()
        End If
    End Sub

    Private Sub LoadProducts(Optional searchTerm As String = "")
        Dim query As String = "SELECT Product_ID, Prod_Name, Price, Image, Quantity FROM Product WHERE Quantity > 0"

        If Not String.IsNullOrEmpty(searchTerm) Then
            query &= " AND Prod_Name LIKE @SearchTerm"
        End If

        Using conn As New SqlConnection(connStr)
            Using cmd As New SqlCommand(query, conn)
                If Not String.IsNullOrEmpty(searchTerm) Then
                    cmd.Parameters.AddWithValue("@SearchTerm", "%" & searchTerm & "%")
                End If

                conn.Open()
                Dim reader = cmd.ExecuteReader()
                Dim html As New StringBuilder()

                If reader.HasRows Then
                    While reader.Read()
                        html.Append("<div class='product-card'>")
                        html.Append("<img src='" & If(IsDBNull(reader("Image")), "https://via.placeholder.com/200", reader("Image").ToString()) & "' />")
                        html.Append("<h3>" & reader("Prod_Name").ToString() & "</h3>")
                        html.Append("<p>Price: Rs. " & reader("Price").ToString() & "</p>")
                        html.Append("<a href='AddToCart.aspx?ProductID=" & reader("Product_ID").ToString() & "' class='btn'>Add to Cart</a>")
                        html.Append("</div>")
                    End While
                Else
                    html.Append("<p>No products found</p>")
                End If

                ProductPanel.InnerHtml = html.ToString()
            End Using
        End Using
    End Sub

    Private Sub LoadUserProfile()
        Dim userId As Integer = CInt(Session("UserID"))

        Using conn As New SqlConnection(connStr)
            Dim cmd As New SqlCommand("SELECT First_Name, Last_Name FROM Customer WHERE Customer_ID = @UserID", conn)
            cmd.Parameters.AddWithValue("@UserID", userId)

            conn.Open()
            Dim reader = cmd.ExecuteReader()
            If reader.Read() Then
                lblWelcome.Text = "Welcome, " & reader("First_Name").ToString() & " " & reader("Last_Name").ToString()
            End If
        End Using
    End Sub

    Protected Sub btnSearch_Click(sender As Object, e As EventArgs) Handles btnSearch.Click
        LoadProducts(txtSearch.Text.Trim())
    End Sub

    Protected Sub btnViewCart_Click(sender As Object, e As EventArgs) Handles btnViewCart.Click
        Response.Redirect("Cart.aspx")
    End Sub
    Protected Sub btnViewOrders_Click(sender As Object, e As EventArgs) Handles btnViewCart.Click
        Response.Redirect("OrderHistory.aspx")
    End Sub

    Protected Sub btnLogout_Click(sender As Object, e As EventArgs) Handles btnLogout.Click
        Session.Abandon()
        Response.Redirect("User_Login.aspx")
    End Sub
End Class
