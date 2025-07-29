<%@ Page Language="VB" AutoEventWireup="false" CodeFile="User_Dash.aspx.vb" Inherits="User_Dash" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Grocery Store - User Dashboard</title>
    <style type="text/css">
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f8f9fa;
        }
        .header {
            background-color: #28a745;
            color: white;
            padding: 15px 0;
            box-shadow: 0 2px 5px rgba(0,0,0,0.1);
        }
        .container {
            width: 90%;
            max-width: 1200px;
            margin: 0 auto;
        }
        .header-content {
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        .logo {
            font-size: 24px;
            font-weight: bold;
        }
        .user-nav {
            display: flex;
            align-items: center;
            gap: 15px;
        }
        .btn-nav {
            padding: 8px 15px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 14px;
            transition: all 0.3s;
        }
        .btn-cart {
            background-color: #ffc107;
            color: #212529;
        }
        .btn-orders {
            background-color: #17a2b8;
            color: white;
        }
        .btn-logout {
            background-color: #dc3545;
            color: white;
        }
        .btn-nav:hover {
            opacity: 0.9;
            transform: translateY(-2px);
        }
        .user-profile {
            background-color: white;
            padding: 20px;
            border-radius: 5px;
            margin: 20px 0;
            box-shadow: 0 2px 5px rgba(0,0,0,0.1);
        }
        .profile-info {
            margin-bottom: 10px;
        }
        .search-container {
            margin: 20px 0;
            display: flex;
            gap: 10px;
        }
        .search-box {
            flex-grow: 1;
            padding: 10px;
            border: 1px solid #ced4da;
            border-radius: 4px;
            font-size: 16px;
        }
        .btn-search {
            padding: 10px 20px;
            background-color: #28a745;
            color: white;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 16px;
        }
        .products-container {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(250px, 1fr));
            gap: 20px;
            margin: 20px 0;
        }
        .product-card {
            background-color: white;
            border-radius: 5px;
            overflow: hidden;
            box-shadow: 0 2px 5px rgba(0,0,0,0.1);
            transition: all 0.3s;
        }
        .product-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 5px 15px rgba(0,0,0,0.1);
        }
        .product-card img {
            width: 100%;
            height: 180px;
            object-fit: cover;
        }
        .product-info {
            padding: 15px;
        }
        .product-info h3 {
            margin: 0 0 10px 0;
            color: #333;
            font-size: 18px;
        }
        .price {
            font-weight: bold;
            color: #28a745;
            font-size: 16px;
            margin: 5px 0;
        }
        .stock {
            color: #6c757d;
            font-size: 14px;
            margin: 5px 0;
        }
        .add-to-cart {
            width: 100%;
            padding: 10px;
            background-color: #28a745;
            color: white;
            border: none;
            cursor: pointer;
            font-size: 16px;
            transition: background-color 0.3s;
        }
        .add-to-cart:hover {
            background-color: #218838;
        }
        .out-of-stock {
            width: 100%;
            padding: 10px;
            background-color: #6c757d;
            color: white;
            border: none;
            cursor: not-allowed;
            font-size: 16px;
        }
        .no-products, .error-message {
            grid-column: 1 / -1;
            text-align: center;
            padding: 20px;
            background-color: white;
            border-radius: 5px;
            box-shadow: 0 2px 5px rgba(0,0,0,0.1);
        }
        .error-message {
            color: #dc3545;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="header">
            <div class="container header-content">
                <div class="logo">Grocery Store</div>
                <div class="user-nav">
                    <asp:Button ID="btnViewCart" runat="server" Text="View Cart" CssClass="btn-nav btn-cart" OnClick="btnViewCart_Click" />
                    <asp:Button ID="btnViewOrders" runat="server" Text="My Orders" CssClass="btn-nav btn-orders" OnClick="btnViewOrders_Click" />
                    <asp:Button ID="btnLogout" runat="server" Text="Logout" CssClass="btn-nav btn-logout" OnClick="btnLogout_Click" />
                </div>
            </div>
        </div>

        <div class="container">
            <div class="user-profile">
                <h2><asp:Label ID="lblWelcome" runat="server" Text="Welcome"></asp:Label></h2>
                <div class="profile-info">
                    <asp:Label ID="lblUsername" runat="server" Text=""></asp:Label>
                </div>
                <div class="profile-info">
                    <asp:Label ID="lblAddress" runat="server" Text=""></asp:Label>
                </div>
            </div>

            <div class="search-container">
                <asp:TextBox ID="txtSearch" runat="server" CssClass="search-box" placeholder="Search products..."></asp:TextBox>
                <asp:Button ID="btnSearch" runat="server" Text="Search" CssClass="btn-search" OnClick="btnSearch_Click" />
            </div>

            <div id="ProductPanel" runat="server" class="products-container">
                <!-- Products will be loaded here dynamically -->
            </div>
        </div>
    </form>
</body>
</html>