<%@ Page Language="VB" AutoEventWireup="false" CodeFile="Admin_Dash.aspx.vb" Inherits="Admin_Dash" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Admin Dashboard</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f9;
            margin: 0;
            padding: 0;
        }
        #form1 {
            max-width: 1200px;
            margin: 0 auto;
            padding: 20px;
        }
        .header {
            background-color: #2c3e50;
            color: white;
            padding: 20px;
            text-align: center;
            border-radius: 10px 10px 0 0;
        }
        .header h1 {
            margin: 0;
        }
        .main-btn {
            background-color: #3498db;
            color: white;
            padding: 10px 20px;
            border: none;
            border-radius: 5px;
            margin: 5px;
            cursor: pointer;
            font-size: 16px;
           
        }
        .main-btn:hover {
            background-color: #2980b9;
        }
        .panel {
            background-color: white;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            margin-top: 20px;
        }
        .panel h2 {
            color: #2c3e50;
            font-size: 20px;
            margin-bottom: 10px;
        }
        .panel input[type="text"] {
            width: 100%;
            padding: 10px;
            margin: 10px 0;
            border-radius: 5px;
            border: 1px solid #ddd;
        }
        .panel button {
            background-color: #27ae60;
            color: white;
            padding: 10px 20px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-size: 16px;
           
        }
        .panel button:hover {
            background-color: #2ecc71;
        }
        .gridview-container {
            margin-top: 20px;
        }
        .gridview-container table {
            width: 100%;
            border-collapse: collapse;
        }
        .gridview-container th, .gridview-container td {
            padding: 12px;
            text-align: left;
            border-bottom: 1px solid #ddd;
        }
        .gridview-container th {
            background-color: #ecf0f1;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="header">
            <h1>Admin Dashboard</h1>
        </div>

        <!-- Main Control Buttons -->
        <div>
            <asp:Button ID="btnManageCategory" runat="server" Text="Manage Categories" OnClick="btnManageCategory_Click" CssClass="main-btn" />
            <asp:Button ID="btnManageSuppliers" runat="server" Text="Manage Suppliers" OnClick="btnManageSuppliers_Click" CssClass="main-btn" />
            <asp:Button ID="btnManageCustomers" runat="server" Text="Manage Customers" OnClick="btnManageCustomers_Click" CssClass="main-btn" />
            <asp:Button ID="btnManageProducts" runat="server" Text="Manage Products" OnClick="btnManageProducts_Click" CssClass="main-btn" />
            <asp:Button ID="btnTrackOrders" runat="server" Text="Track Orders" OnClick="btnTrackOrders_Click" CssClass="main-btn" />
        </div>

        <hr />

        <!-- Categories Panel -->
        <asp:Panel ID="pnlCategory" runat="server" Visible="False" CssClass="panel">
            <h3>Manage Categories</h3>
            <h2>Add Category</h2>
            <asp:TextBox ID="txtCatName" runat="server" Placeholder="Category Name" CssClass="panel-input"></asp:TextBox>
            <asp:TextBox ID="txtCatDesc" runat="server" Placeholder="Category Description" CssClass="panel-input"></asp:TextBox>
            <asp:TextBox ID="txtAdminID" runat="server" Placeholder="Admin ID" CssClass="panel-input"></asp:TextBox>
            <asp:Button ID="btnAddCategory" runat="server" Text="Add Category" OnClick="btnAddCategory_Click" CssClass="panel-btn" />
            <h2>View Categories</h2>
            <asp:Button ID="btnViewCategory" runat="server" Text="View Categories" OnClick="btnViewCategory_Click" CssClass="panel-btn" />
            <div class="gridview-container">
                <asp:GridView ID="gvCategories" runat="server" AutoGenerateColumns="True" />
            </div>
            <h2>Delete Category</h2>
            <asp:TextBox ID="txtCatID" runat="server" Placeholder="Category ID" CssClass="panel-input"></asp:TextBox>
            <asp:Button ID="btnDeleteCategory" runat="server" Text="Delete Category" OnClick="btnDeleteCategory_Click" CssClass="panel-btn" />
            <asp:Label ID="lblCategoryMessage" runat="server"></asp:Label>
        </asp:Panel>

        <!-- Suppliers Panel -->
        <asp:Panel ID="pnlSuppliers" runat="server" Visible="False" CssClass="panel">
            <h3>Manage Suppliers</h3>
            <h2>Add Supplier</h2>
            <asp:TextBox ID="txtSuppUser" runat="server" Placeholder="Supplier Username" CssClass="panel-input"></asp:TextBox>
            <asp:TextBox ID="txtSuppName" runat="server" Placeholder="Supplier Name" CssClass="panel-input"></asp:TextBox>
            <asp:TextBox ID="txtSuppAddress" runat="server" Placeholder="Supplier Address" CssClass="panel-input"></asp:TextBox>
            <asp:Button ID="btnAddSupplier" runat="server" Text="Add Supplier" OnClick="btnAddSuppliers_Click" CssClass="panel-btn" />
            <h2>View Suppliers</h2>
            <asp:Button ID="btnViewSuppliers" runat="server" Text="View Suppliers" OnClick="ViewSuppliers" CssClass="panel-btn" />
            <div class="gridview-container">
                <asp:GridView ID="gvSuppliers" runat="server" AutoGenerateColumns="True" />
            </div>
            <h2>Delete Supplier</h2>
            <asp:TextBox ID="txtSuppID" runat="server" Placeholder="Supplier ID" CssClass="panel-input"></asp:TextBox>
            <asp:Button ID="btnDeleteSupplier" runat="server" Text="Delete Supplier" OnClick="btnDeleteSupplier_Click" CssClass="panel-btn" />
        </asp:Panel>

        <!-- Customers Panel -->
        <asp:Panel ID="pnlCustomers" runat="server" Visible="False" CssClass="panel">
            <h3>Manage Customers</h3>
            <h2>View Customers</h2>
            <asp:Button ID="btnViewCustomers" runat="server" Text="View Customers" OnClick="ViewCustomers" CssClass="panel-btn" />
            <div class="gridview-container">
                <asp:GridView ID="gvCustomers" runat="server" AutoGenerateColumns="True" />
            </div>
        </asp:Panel>

        <!-- Products Panel -->
        <asp:Panel ID="pnlProducts" runat="server" Visible="False" CssClass="panel">
            <h3>Manage Products</h3>
            <h2>View Products</h2>
            <asp:Button ID="btnViewProducts" runat="server" Text="View Products" OnClick="ViewProducts" CssClass="panel-btn" />
            <div class="gridview-container">
                <asp:GridView ID="gvProducts" runat="server" AutoGenerateColumns="True" />
            </div>
        </asp:Panel>

        <!-- Orders Panel -->
        <asp:Panel ID="pnlOrders" runat="server" Visible="False" CssClass="panel">
            <h3>Track Orders</h3>
            <asp:Button ID="btnViewOrders" runat="server" Text="View Orders" OnClick="ViewOrders" CssClass="panel-btn" />
            <div class="gridview-container">
                <asp:GridView ID="gvOrders" runat="server" AutoGenerateColumns="True" />
            </div>
        </asp:Panel>

    </form>
</body>
</html>
