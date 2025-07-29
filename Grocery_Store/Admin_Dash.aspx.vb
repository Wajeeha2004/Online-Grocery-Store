Imports System.Data
Imports System.Data.SqlClient

Partial Class Admin_Dash
    Inherits System.Web.UI.Page
    Private connectionString As String = "workstation id=Grocery_store.mssql.somee.com;packet size=4096;user id=wajeeha2004_SQLLogin_1;pwd=z1xo3teh8f;data source=Grocery_store.mssql.somee.com;persist security info=False;initial catalog=Grocery_store;TrustServerCertificate=True"
    Private admin_id As Integer

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Session("Admin_ID") Is Nothing Then
            Response.Redirect("Admin_Login.aspx")
            Return
        End If

        admin_id = Convert.ToInt32(Session("Admin_ID"))

        If Not IsPostBack Then
            ' Optionally load something here on first page load
        End If
    End Sub
    Protected Sub btnManageCategory_Click(sender As Object, e As EventArgs)
        pnlCategory.Visible = True
        pnlSuppliers.Visible = False
        pnlCustomers.Visible = False
        pnlProducts.Visible = False
        pnlOrders.Visible = False
    End Sub
    Protected Sub btnManageSuppliers_Click(sender As Object, e As EventArgs)
        pnlCategory.Visible = False
        pnlSuppliers.Visible = True
        pnlCustomers.Visible = False
        pnlProducts.Visible = False
        pnlOrders.Visible = False
    End Sub

    Protected Sub btnManageCustomers_Click(sender As Object, e As EventArgs)
        pnlCategory.Visible = False
        pnlSuppliers.Visible = False
        pnlCustomers.Visible = True
        pnlProducts.Visible = False
        pnlOrders.Visible = False
    End Sub

    Protected Sub btnManageProducts_Click(sender As Object, e As EventArgs)
        pnlCategory.Visible = False
        pnlSuppliers.Visible = False
        pnlCustomers.Visible = False
        pnlProducts.Visible = True
        pnlOrders.Visible = False
    End Sub

    Protected Sub btnTrackOrders_Click(sender As Object, e As EventArgs)
        pnlCategory.Visible = False
        pnlSuppliers.Visible = False
        pnlCustomers.Visible = False
        pnlProducts.Visible = False
        pnlOrders.Visible = True
    End Sub


    Protected Sub btnViewCategory_Click(sender As Object, e As EventArgs)
        ViewCategories()
    End Sub

    ' Category Management
    Protected Sub btnAddCategory_Click(sender As Object, e As EventArgs)
        AddCategory(txtCatName.Text, txtCatDesc.Text, txtAdminID.Text)
    End Sub

    Protected Sub AddCategory(name As String, desc As String, adminId As String)
        ' Fix: Retrieve max category_ID correctly
        Dim maxID As Integer = 0
        Using conn As New SqlConnection(connectionString)
            Dim cmd As New SqlCommand("SELECT ISNULL(MAX(Category_ID), 0) FROM Category", conn)
            conn.Open()
            maxID = Convert.ToInt32(cmd.ExecuteScalar())
        End Using
        Dim category_id As Integer = maxID + 1

        Using conn As New SqlConnection(connectionString)
            Dim cmd As New SqlCommand("INSERT INTO Category (Category_ID, Cat_Name, Cat_description, Admin_ID) VALUES (@category_id, @Name, @Description, @AdminID)", conn)
            cmd.Parameters.AddWithValue("@category_id", category_id)
            cmd.Parameters.AddWithValue("@Name", name)
            cmd.Parameters.AddWithValue("@Description", desc)
            cmd.Parameters.AddWithValue("@AdminID", adminId)
            conn.Open()
            cmd.ExecuteNonQuery()
        End Using
        ViewCategories()
    End Sub

    ' View Categories
    Protected Sub ViewCategories()
        Using conn As New SqlConnection(connectionString)
            Dim cmd As New SqlCommand("SELECT * FROM Category", conn)
            Dim da As New SqlDataAdapter(cmd)
            Dim dt As New DataTable()
            da.Fill(dt)
            gvCategories.DataSource = dt
            gvCategories.DataBind()
        End Using
    End Sub

    ' Supplier Management
    Protected Sub btnAddSuppliers_Click(sender As Object, e As EventArgs)
        AddSupplier(txtSuppUser.Text, txtSuppName.Text, txtSuppAddress.Text)
    End Sub

    Protected Sub AddSupplier(username As String, name As String, address As String)
        ' Fix: Retrieve max supplier_ID correctly
        Dim maxID As Integer = 0
        Using conn As New SqlConnection(connectionString)
            Dim cmd As New SqlCommand("SELECT ISNULL(MAX(Supplier_ID), 0) FROM Supplier", conn)
            conn.Open()
            maxID = Convert.ToInt32(cmd.ExecuteScalar())
        End Using
        Dim supplierID As Integer = maxID + 1

        Using conn As New SqlConnection(connectionString)
            Dim cmd As New SqlCommand("INSERT INTO Supplier (Supplier_ID, Supp_Username, Supp_Name, Supp_Address) VALUES (@supplierid, @Username, @Name, @Address)", conn)
            cmd.Parameters.AddWithValue("@supplierid", supplierID)
            cmd.Parameters.AddWithValue("@Username", username)
            cmd.Parameters.AddWithValue("@Name", name)
            cmd.Parameters.AddWithValue("@Address", address)
            conn.Open()
            cmd.ExecuteNonQuery()
        End Using
        ViewSuppliers()
    End Sub

    ' View Suppliers
    Protected Sub ViewSuppliers()
        Using conn As New SqlConnection(connectionString)
            Dim cmd As New SqlCommand("SELECT * FROM Supplier", conn)
            Dim da As New SqlDataAdapter(cmd)
            Dim dt As New DataTable()
            da.Fill(dt)
            gvSuppliers.DataSource = dt
            gvSuppliers.DataBind()
        End Using
    End Sub

    ' Delete Category
    Protected Sub btnDeleteCategory_Click(sender As Object, e As EventArgs)
        Dim categoryId As Integer
        If Integer.TryParse(txtCatID.Text, categoryId) Then
            Dim conn As New SqlConnection("YourConnectionString")
            Dim cmdProducts As New SqlCommand("DELETE FROM Products WHERE CategoryID = @CategoryID", conn)
            Dim cmdCategory As New SqlCommand("DELETE FROM Categories WHERE CategoryID = @CategoryID", conn)

            cmdProducts.Parameters.AddWithValue("@CategoryID", categoryId)
            cmdCategory.Parameters.AddWithValue("@CategoryID", categoryId)

            conn.Open()
            cmdProducts.ExecuteNonQuery()
            cmdCategory.ExecuteNonQuery()
            conn.Close()
        End If
    End Sub


    ' Delete Supplier
    Protected Sub btnDeleteSupplier_Click(sender As Object, e As EventArgs)
        DeleteSupplier(txtSuppID.Text)
    End Sub

    Protected Sub DeleteSupplier(supplierId As String)
        Using conn As New SqlConnection(connectionString)
            Dim cmd As New SqlCommand("DELETE FROM Supplier WHERE Supplier_ID = @ID", conn)
            cmd.Parameters.AddWithValue("@ID", supplierId)
            conn.Open()
            cmd.ExecuteNonQuery()
        End Using
        ViewSuppliers()
    End Sub

    ' Product Management
    Protected Sub ViewProducts()
        Using conn As New SqlConnection(connectionString)
            Dim cmd As New SqlCommand("SELECT * FROM Product", conn)
            Dim da As New SqlDataAdapter(cmd)
            Dim dt As New DataTable()
            da.Fill(dt)
            gvProducts.DataSource = dt
            gvProducts.DataBind()
        End Using
    End Sub

    ' Customer Management
    Protected Sub ViewCustomers()
        Using conn As New SqlConnection(connectionString)
            Dim cmd As New SqlCommand("SELECT * FROM Customer", conn)
            Dim da As New SqlDataAdapter(cmd)
            Dim dt As New DataTable()
            da.Fill(dt)
            gvCustomers.DataSource = dt
            gvCustomers.DataBind()
        End Using
    End Sub

    ' Order Tracking
    Protected Sub ViewOrders()
        Using conn As New SqlConnection(connectionString)
            Dim cmd As New SqlCommand("SELECT * FROM Customer_Order", conn)
            Dim da As New SqlDataAdapter(cmd)
            Dim dt As New DataTable()
            da.Fill(dt)
            gvOrders.DataSource = dt
            gvOrders.DataBind()
        End Using
    End Sub
End Class
