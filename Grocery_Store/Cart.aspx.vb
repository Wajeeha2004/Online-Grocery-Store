Imports System.Data
Imports System.Data.SqlClient

Partial Class Cart
    Inherits System.Web.UI.Page

    Private connStr As String = "workstation id=Grocery_store.mssql.somee.com;packet size=4096;user id=wajeeha2004_SQLLogin_1;pwd=z1xo3teh8f;data source=Grocery_store.mssql.somee.com;persist security info=False;initial catalog=Grocery_store;TrustServerCertificate=True"

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Session("UserID") Is Nothing Then
            Response.Redirect("User_Login.aspx")
            Return
        End If

        If Not IsPostBack Then
            BindCartItems()
        End If
    End Sub

    Private Sub BindCartItems()
        Dim userId As Integer = CInt(Session("UserID"))

        Using conn As New SqlConnection(connStr)
            Dim cmd As New SqlCommand("SELECT c.Cart_ID, p.Prod_Name, p.Price, c.Quantity, (p.Price * c.Quantity) AS Subtotal " &
                                     "FROM Cart c INNER JOIN Product p ON c.Product_ID = p.Product_ID " &
                                     "WHERE c.Customer_ID = @UserId", conn)
            cmd.Parameters.AddWithValue("@UserId", userId)

            Dim da As New SqlDataAdapter(cmd)
            Dim dt As New DataTable()
            da.Fill(dt)

            If dt.Rows.Count > 0 Then
                gvCart.DataSource = dt
                gvCart.DataBind()
                CalculateTotal()
                pnlEmptyCart.Visible = False
            Else
                pnlEmptyCart.Visible = True
            End If
        End Using
    End Sub

    Protected Sub gvCart_RowCommand(sender As Object, e As GridViewCommandEventArgs)
        If e.CommandName = "Update" Then
            Dim rowIndex As Integer = Convert.ToInt32(e.CommandArgument)
            Dim row As GridViewRow = gvCart.Rows(rowIndex)
            Dim txtQuantity As TextBox = CType(row.FindControl("txtQuantity"), TextBox)
            Dim cartId As Integer = Convert.ToInt32(gvCart.DataKeys(row.RowIndex).Value)

            Dim newQuantity As Integer
            If Integer.TryParse(txtQuantity.Text, newQuantity) AndAlso newQuantity > 0 Then
                UpdateCartItem(cartId, newQuantity)
                lblMessage.Text = "Quantity updated successfully."
                lblMessage.CssClass = "success-message"
            Else
                lblMessage.Text = "Please enter a valid quantity."
                lblMessage.CssClass = "error-message"
            End If
            lblMessage.Visible = True
            BindCartItems()
        End If
    End Sub

    Protected Sub gvCart_RowDeleting(sender As Object, e As GridViewDeleteEventArgs)
        Dim cartId As Integer = Convert.ToInt32(gvCart.DataKeys(e.RowIndex).Value)
        RemoveFromCart(cartId)
        BindCartItems()
    End Sub

    Private Sub RemoveFromCart(cartId As Integer)
        Using conn As New SqlConnection(connStr)
            Dim cmd As New SqlCommand("DELETE FROM Cart WHERE Cart_ID = @CartId", conn)
            cmd.Parameters.AddWithValue("@CartId", cartId)
            conn.Open()
            cmd.ExecuteNonQuery()
        End Using
    End Sub

    Private Sub UpdateCartItem(cartId As Integer, quantity As Integer)
        Using conn As New SqlConnection(connStr)
            Dim cmd As New SqlCommand("UPDATE Cart SET Quantity = @Quantity WHERE Cart_ID = @CartId", conn)
            cmd.Parameters.AddWithValue("@Quantity", quantity)
            cmd.Parameters.AddWithValue("@CartId", cartId)
            conn.Open()
            cmd.ExecuteNonQuery()
        End Using
    End Sub

    Private Sub CalculateTotal()
        Dim userId As Integer = CInt(Session("UserID"))
        Dim total As Decimal = 0

        Using conn As New SqlConnection(connStr)
            Dim cmd As New SqlCommand("SELECT SUM(p.Price * c.Quantity) FROM Cart c INNER JOIN Product p ON c.Product_ID = p.Product_ID WHERE c.Customer_ID = @UserId", conn)
            cmd.Parameters.AddWithValue("@UserId", userId)
            conn.Open()

            Dim result = cmd.ExecuteScalar()
            If result IsNot DBNull.Value Then
                total = CDec(result)
            End If
        End Using

        lblTotal.Text = "Total: Rs. " & total.ToString("N2")

    End Sub

    Protected Sub btnCheckout_Click(sender As Object, e As EventArgs) Handles btnCheckout.Click
        If gvCart.Rows.Count > 0 Then
            Response.Redirect("Checkout.aspx")
        Else
            lblMessage.Text = "Your cart is empty"
            lblMessage.CssClass = "error-message"
            lblMessage.Visible = True
        End If
    End Sub

    Protected Sub btnContinueShopping_Click(sender As Object, e As EventArgs) Handles btnContinueShopping.Click
        Response.Redirect("User_Dash.aspx")
    End Sub
End Class