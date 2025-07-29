Imports System.Data
Imports System.Data.SqlClient

Partial Class Admin_Login
    Inherits System.Web.UI.Page

    Public connectionString As String = "workstation id=Grocery_store.mssql.somee.com;packet size=4096;user id=wajeeha2004_SQLLogin_1;pwd=z1xo3teh8f;data source=Grocery_store.mssql.somee.com;persist security info=False;initial catalog=Grocery_store;TrustServerCertificate=True"

    Protected Sub btnLogin_Click(sender As Object, e As EventArgs)
        ' Retrieve username and password from form
        Dim username As String = txtAdminName.Text
        Dim password As String = txtPassword.Text

        Using conn As New SqlConnection(connectionString)
            Dim cmd As New SqlCommand("SELECT Admin_ID FROM Admin WHERE Admin_Name = @username AND Admin_Password = @password", conn)
            cmd.Parameters.AddWithValue("@username", username)
            cmd.Parameters.AddWithValue("@password", password)

            conn.Open()
            Dim result = cmd.ExecuteScalar()

            If result IsNot Nothing Then
                ' Successful login
                Session("Admin_ID") = result.ToString()
                Response.Redirect("Admin_Dash.aspx") ' Redirect to dashboard
            Else
                lblMessage.Text = "Invalid login credentials!"
            End If
        End Using
    End Sub
End Class
