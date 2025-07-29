
Partial Class RoleSelect
    Inherits System.Web.UI.Page

    Protected Sub btnUser_Click(sender As Object, e As EventArgs) Handles btnUser.Click
        Response.Redirect("User_Login.aspx")
    End Sub

    Protected Sub btnSupplier_Click(sender As Object, e As EventArgs) Handles btnSupplier.Click
        Response.Redirect("Supplier_Login.aspx")
    End Sub

    Protected Sub btnAdmin_Click(sender As Object, e As EventArgs) Handles btnAdmin.Click
        Response.Redirect("Admin_Login.aspx")
    End Sub

End Class
