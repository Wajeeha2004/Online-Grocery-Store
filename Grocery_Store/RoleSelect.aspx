<%@ Page Language="VB" AutoEventWireup="false" CodeFile="RoleSelect.aspx.vb" Inherits="RoleSelect" %>

<!DOCTYPE html>
<html>
<head runat="server">
    <title>Role Selection</title>
    <style>
        body {
            background-image: url('https://static.vecteezy.com/system/resources/thumbnails/045/661/918/small_2x/empty-wooden-table-with-a-beautiful-grocery-store-background-featuring-aisles-of-colorful-products-ideal-for-food-marketing-and-promotions-photo.jpeg');
            background-size: cover;
            background-position: center;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            margin: 0;
            padding: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
        }
       
        #form1 {
            width: 100%;
            max-width: 480px; /* Optimal width */
            padding: 15px;
        }
        
        .container {
            text-align: center;
            padding: 25px 35px; /* Reduced vertical padding */
            background-color: rgba(255, 255, 255, 0.97);
            border-radius: 12px;
            box-shadow: 0 8px 25px rgba(0, 0, 0, 0.15);
            border: 1px solid rgba(255, 255, 255, 0.2);
            backdrop-filter: blur(2px);
        }
        
        .welcome-title {
            color: #2c3e50;
            margin: 0 0 5px 0;
            font-size: 22px;
            font-weight: 600;
        }
        
        .role-title {
            color: #5d5d5d;
            margin: 0 0 18px 0; /* Reduced margin */
            font-size: 15px;
            font-weight: 500;
        }
        
        .button {
            width: 100%;
            height: 42px; /* Slightly reduced height */
            font-size: 14px;
            margin: 8px 0; /* Reduced margin */
            border-radius: 8px;
            border: none;
            cursor: pointer;
            font-weight: 600;
            color: white;
            letter-spacing: 0.5px;
        }
        
        .button:hover {
            box-shadow: 0 5px 12px rgba(0, 0, 0, 0.15);
        }
        
        .btnUser {
            background: linear-gradient(135deg, #3a7ca5, #2c6082);
        }
        
        .btnSupplier {
            background: linear-gradient(135deg, #5d5d5d, #3d3d3d);
        }
        
        .btnAdmin {
            background: linear-gradient(135deg, #2e7d32, #1b5e20);
        }
        
        .logo {
            width: 50px;
            height: 50px;
            margin: 0 auto 15px auto; /* Reduced margin */
            background-color: rgba(248, 249, 250, 0.8);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            box-shadow: 0 3px 10px rgba(0, 0, 0, 0.1);
        }
        
        .logo i {
            font-size: 24px;
            color: #2e7d32;
        }
    </style>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
</head>
<body>
    <form id="form1" runat="server">
        <div class="container" style="display: flex; gap: 20px; justify-content: space-between; align-items: flex-start;">

    <!-- Left side: Credentials block -->
    <div style="flex: 1; text-align: left; font-size: 14px; color: #444; background: #f7f7f7; padding: 15px; border-radius: 10px; box-shadow: inset 0 0 5px #ddd; max-width: 45%;">
        <strong>Hardcoded Credentials:</strong>
        <ul style="list-style: none; padding-left: 0; margin-top: 12px; line-height: 1.6;">
            <li><strong>Admin:</strong> Username: <em>John Smith</em>, Password: <em>admin123</em></li>
            <li><strong>Supplier:</strong> Username: <em>freshfarm</em>, Name: <em>Fresh Farm Produce</em>, Password: <em>1234</em></li>
            <li><strong>Customer:</strong> Username: <em>wajeeha2004</em>, Password: <em>1234</em></li>
        </ul>
    </div>

    <!-- Right side: Existing content -->
    <div style="flex: 1; max-width: 45%; text-align: center;">
        <div class="logo">
            <i class="fas fa-shopping-basket"></i>
        </div>
        <h2 class="welcome-title">Welcome to Grocery Store</h2>
        <p class="role-title">Select your role to continue</p>
        
        <asp:Button ID="btnUser" runat="server" Text="Customer" CssClass="button btnUser" OnClick="btnUser_Click" />
        <asp:Button ID="btnSupplier" runat="server" Text="Supplier" CssClass="button btnSupplier" OnClick="btnSupplier_Click" />
        <asp:Button ID="btnAdmin" runat="server" Text="Admin" CssClass="button btnAdmin" OnClick="btnAdmin_Click" />
    </div>

</div>

    </form>
</body>
</html>