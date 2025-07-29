Imports System.Data.SqlClient

Partial Class Supplier_Login
    Inherits System.Web.UI.Page

    Protected Sub btnLogin_Click(sender As Object, e As EventArgs)
        Dim connectionString As String = "workstation id=Grocery_store.mssql.somee.com;packet size=4096;user id=wajeeha2004_SQLLogin_1;pwd=z1xo3teh8f;data source=Grocery_store.mssql.somee.com;persist security info=False;initial catalog=Grocery_store;TrustServerCertificate=True"

        Using con As New SqlConnection(connectionString)
            Try
                con.Open()
                Dim cmd As New SqlCommand("SELECT Supplier_ID FROM Supplier WHERE Supp_Username = @username AND Supp_Name = @name", con)
                cmd.Parameters.AddWithValue("@username", txtUsername.Text.Trim())
                cmd.Parameters.AddWithValue("@name", Name.Text.Trim())

                Dim supplierIdObj As Object = cmd.ExecuteScalar()

                If supplierIdObj IsNot Nothing Then
                    Session("SupplierID") = supplierIdObj.ToString()
                    Response.Redirect("Supplier_Dash.aspx")
                Else
                    lblMessage.Text = "Invalid supplier login."
                End If

            Catch ex As Exception
                lblMessage.Text = "Error: " & ex.Message
            End Try
        End Using
    End Sub
End Class
