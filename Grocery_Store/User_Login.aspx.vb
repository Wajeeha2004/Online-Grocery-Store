Imports System.Data.SqlClient

Partial Class User_Login
    Inherits System.Web.UI.Page

    Protected Sub btnLogin_Click(sender As Object, e As EventArgs)
        Dim connectionString As String = "workstation id=Grocery_store.mssql.somee.com;packet size=4096;user id=wajeeha2004_SQLLogin_1;pwd=z1xo3teh8f;data source=Grocery_store.mssql.somee.com;persist security info=False;initial catalog=Grocery_store;TrustServerCertificate=True"

        Using con As New SqlConnection(connectionString)
            Try
                con.Open()

                ' Simple query to check username and plain text password
                Dim cmd As New SqlCommand("SELECT Customer_ID FROM Customer WHERE Cust_UserName = @username AND Cust_password = @password", con)
                cmd.Parameters.AddWithValue("@username", txtUser.Text.Trim())
                cmd.Parameters.AddWithValue("@password", txtPass.Text.Trim())

                Dim result As Object = cmd.ExecuteScalar()

                If result IsNot Nothing Then
                    Session("UserID") = result.ToString()
                    Response.Redirect("User_Dash.aspx")
                Else
                    lblMessage.Text = "Invalid username or password."
                End If

            Catch ex As Exception
                lblMessage.Text = "Error: " & ex.Message
            End Try
        End Using
    End Sub
End Class