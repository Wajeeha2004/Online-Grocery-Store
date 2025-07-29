<%@ Page Language="VB" AutoEventWireup="false" CodeFile="Supplier_Dash.aspx.vb" Inherits="Supplier_Dash" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Supplier Dashboard</title>
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
            transition: background-color 0.3s ease;
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
        .panel input[type="text"], .panel input[type="number"] {
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
            transition: background-color 0.3s ease;
        }
        .panel button:hover {
            background-color: #2ecc71;
        }
        .gridview-container {
            margin-top: 20px;
            overflow-x: auto;
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
        .message {
            margin: 10px 0;
            padding: 10px;
            border-radius: 5px;
        }
        .success {
            background-color: #d4edda;
            color: #155724;
        }
        .error {
            background-color: #f8d7da;
            color: #721c24;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="header">
            <h1>Supplier Dashboard</h1>
            <asp:Label ID="lblWelcome" runat="server" Text=""></asp:Label>
        </div>

        <!-- Main Control Buttons -->
        <div>
            <asp:Button ID="btnAddProduct" runat="server" Text="Add Product" OnClick="btnAddProduct_Click" CssClass="main-btn" />
            <asp:Button ID="btnDeleteProduct" runat="server" Text="Delete Product" OnClick="btnDeleteProduct_Click" CssClass="main-btn" />
            <asp:Button ID="btnUpdateProduct" runat="server" Text="Update Product" OnClick="btnUpdateProduct_Click" CssClass="main-btn" />
            <asp:Button ID="btnViewProducts" runat="server" Text="Your Products" OnClick="btnViewProducts_Click" CssClass="main-btn" />
            <asp:Button ID="btnViewOrders" runat="server" Text="Product Orders" OnClick="btnViewOrders_Click" CssClass="main-btn" />
        </div>

        <hr />

        <!-- Add Product Panel -->
        <asp:Panel ID="pnlAddProduct" runat="server" Visible="False" CssClass="panel">
            <h2>Add New Product</h2>
            <asp:TextBox ID="txtProdName" runat="server" Placeholder="Product Name" CssClass="panel-input"></asp:TextBox>
            <asp:TextBox ID="txtProdDesc" runat="server" Placeholder="Product Description" CssClass="panel-input" TextMode="MultiLine" Rows="3"></asp:TextBox>
            <asp:TextBox ID="txtCategoryID" runat="server" Placeholder="Category ID" CssClass="panel-input"></asp:TextBox>
            <asp:TextBox ID="txtPrice" runat="server" Placeholder="Price" CssClass="panel-input" TextMode="Number" step="0.01"></asp:TextBox>
            <asp:TextBox ID="txtQuantity" runat="server" Placeholder="Quantity" CssClass="panel-input" TextMode="Number"></asp:TextBox>
            <asp:Button ID="btnSubmitProduct" runat="server" Text="Add Product" OnClick="btnSubmitProduct_Click" CssClass="panel-btn" />
            <asp:Label ID="lblAddProductMessage" runat="server" CssClass="message"></asp:Label>
             <div class="gridview-container">
                 <asp:GridView ID="gvCategories" runat="server" AutoGenerateColumns="True" />
                 </div>
        </asp:Panel>

        <!-- Delete Product Panel -->
        <asp:Panel ID="pnlDeleteProduct" runat="server" Visible="False" CssClass="panel">
            <h2>Delete Product</h2>
            <asp:TextBox ID="txtDeleteProdID" runat="server" Placeholder="Product ID to Delete" CssClass="panel-input"></asp:TextBox>
            <asp:Button ID="btnConfirmDelete" runat="server" Text="Delete Product" OnClick="btnConfirmDelete_Click" CssClass="panel-btn" />
            <asp:Label ID="lblDeleteMessage" runat="server" CssClass="message"></asp:Label>
            <h3>Your Products (for reference)</h3>
            <div class="gridview-container">
                <asp:GridView ID="gvSupplierProducts" runat="server" AutoGenerateColumns="True" />
            </div>
        </asp:Panel>

        <!-- Update Product Panel -->
        <asp:Panel ID="pnlUpdateProduct" runat="server" Visible="False" CssClass="panel">
            <h2>Update Product</h2>
            <asp:TextBox ID="txtUpdateProdID" runat="server" Placeholder="Product ID to Update" CssClass="panel-input"></asp:TextBox>
            <asp:Button ID="btnLoadProduct" runat="server" Text="Load Product Details" OnClick="btnLoadProduct_Click" CssClass="panel-btn" />
            
            <asp:Panel ID="pnlProductDetails" runat="server" Visible="False">
                <asp:TextBox ID="txtUpdateName" runat="server" Placeholder="Product Name" CssClass="panel-input"></asp:TextBox>
                <asp:TextBox ID="txtUpdateDesc" runat="server" Placeholder="Product Description" CssClass="panel-input" TextMode="MultiLine" Rows="3"></asp:TextBox>
                <asp:TextBox ID="txtUpdateCategory" runat="server" Placeholder="Category ID" CssClass="panel-input"></asp:TextBox>
                <asp:TextBox ID="txtUpdatePrice" runat="server" Placeholder="Price" CssClass="panel-input" TextMode="Number" step="0.01"></asp:TextBox>
                <asp:TextBox ID="txtUpdateQuantity" runat="server" Placeholder="Quantity" CssClass="panel-input" TextMode="Number"></asp:TextBox>
                <asp:Button ID="btnUpdateProductDetails" runat="server" Text="Update Product" OnClick="btnUpdateProductDetails_Click" CssClass="panel-btn" />
            </asp:Panel>
            <asp:Label ID="lblUpdateMessage" runat="server" CssClass="message"></asp:Label>
            <h3>Your Products</h3>
            <div class="gridview-container">
                <asp:GridView ID="gvProductsForUpdate" runat="server" AutoGenerateColumns="True" />
            </div>
        </asp:Panel>

        <!-- View Products Panel -->
        <asp:Panel ID="pnlViewProducts" runat="server" Visible="False" CssClass="panel">
            <h2>Your Products</h2>
            <div class="gridview-container">
                <asp:GridView ID="gvYourProducts" runat="server" AutoGenerateColumns="True" />
            </div>
        </asp:Panel>

        <!-- View Orders Panel -->
        <asp:Panel ID="pnlViewOrders" runat="server" Visible="False" CssClass="panel">
            <h2>Orders for Your Products</h2>
            <div class="gridview-container">
                <asp:GridView ID="gvProductOrders" runat="server" AutoGenerateColumns="True" />
            </div>
        </asp:Panel>

    </form>
</body>
</html>