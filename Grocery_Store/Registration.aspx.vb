Imports System.Data.SqlClient

Partial Class Registration
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(sender As Object, e As EventArgs) Handles Me.Load
        If Not IsPostBack Then
            Dim role As String = Request.QueryString("role")
            If role Is Nothing Then
                lblMessage.Text = "Error: No role provided in query string."
                btnRegister.Enabled = False
            Else
                lblRole.Text = "Registering as: " & role
                ViewState("Role") = role ' Store role in ViewState for use on postback
            End If
        End If
    End Sub

    Protected Sub btnRegister_Click(sender As Object, e As EventArgs)
        Dim role As String = ViewState("Role").ToString()
        Dim Fname As String = FirstName.Text.Trim()
        Dim Lname As String = lastName.Text.Trim()
        Dim username As String = txtUsername.Text.Trim()
        Dim password As String = txtPassword.Text.Trim()
        Dim address As String = txtAddress.Text.Trim()
        Dim customerId As Integer = 0

        Dim conStr As String = "workstation id=Grocery_store.mssql.somee.com;packet size=4096;user id=wajeeha2004_SQLLogin_1;pwd=z1xo3teh8f;data source=Grocery_store.mssql.somee.com;persist security info=False;initial catalog=Grocery_store;TrustServerCertificate=True"
        Using con As New SqlConnection(conStr)
            con.Open()
            Dim query As String = ""

            If role = "Customer" Then
                Dim getMaxIdQuery As String = "SELECT ISNULL(MAX(Customer_ID), 0) FROM Customer"
                Using cmdMaxId As New SqlCommand(getMaxIdQuery, con)
                    customerId = Convert.ToInt32(cmdMaxId.ExecuteScalar()) + 1
                End Using
                query = "INSERT INTO Customer (Customer_ID, First_Name, Last_Name, Cust_UserName, Cust_password, Cust_address) VALUES (@Cust_ID, @FName, @LName, @Username, @Password, @Address)"
            Else
                lblMessage.Text = "Invalid role."
                Exit Sub
            End If

            Using cmd As New SqlCommand(query, con)
                cmd.Parameters.AddWithValue("@Cust_ID", customerId)
                cmd.Parameters.AddWithValue("@FName", Fname)
                cmd.Parameters.AddWithValue("@LName", Lname)
                cmd.Parameters.AddWithValue("@Username", username)
                cmd.Parameters.AddWithValue("@Password", password) ' Storing plain text password
                cmd.Parameters.AddWithValue("@Address", address)

                Try
                    cmd.ExecuteNonQuery()
                    lblMessage.ForeColor = Drawing.Color.Green
                    lblMessage.Text = "Registration successful! You can now log in."
                Catch ex As Exception
                    lblMessage.Text = "Error: " & ex.Message
                End Try
            End Using
        End Using
    End Sub
End Class