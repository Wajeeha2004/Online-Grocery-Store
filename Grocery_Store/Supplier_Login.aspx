<%@ Page Language="VB" AutoEventWireup="false" CodeFile="Supplier_Login.aspx.vb" Inherits="Supplier_Login" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Supplier Login</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600&display=swap" rel="stylesheet" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" />
    <style>
          body {
       font-family: 'Poppins', sans-serif;
       display: flex;
       justify-content: center;
       align-items: center;
       min-height: 100vh;
       margin: 0;
       background-image: url('https://static.vecteezy.com/system/resources/thumbnails/045/661/918/small_2x/empty-wooden-table-with-a-beautiful-grocery-store-background-featuring-aisles-of-colorful-products-ideal-for-food-marketing-and-promotions-photo.jpeg');
       background-size: cover;
       background-position: center;
       background-attachment: fixed;
   }

   .login-box {
       background-color: rgba(255, 255, 255, 0.95);
       padding: 25px 30px;
       border-radius: 10px;
       box-shadow: 0 8px 25px rgba(0, 0, 0, 0.12);
       width: 150%;
       max-width: 600px;
       text-align: center;
       backdrop-filter: blur(3px);
       border: 1px solid rgba(255, 255, 255, 0.3);
       transition: transform 0.3s ease;
   }

   .login-box:hover {
       transform: translateY(-3px);
       box-shadow: 0 12px 30px rgba(0, 0, 0, 0.15);
   }

   .login-box h2 {
       color: #2c3e50;
       font-size: 24px;
       font-weight: 600;
       margin-bottom: 20px;
       position: relative;
       display: inline-block;
   }

   .login-box h2:after {
       content: '';
       position: absolute;
       width: 40px;
       height: 3px;
       background: linear-gradient(90deg, #00796b, #004d40);
       bottom: -8px;
       left: 50%;
       transform: translateX(-50%);
       border-radius: 3px;
   }

   .input-group {
       margin-bottom: 16px;
       text-align: left;
   }

   label {
       display: block;
       margin-bottom: 6px;
       font-weight: 500;
       color: #00796b;
       font-size: 14px;
   }

   .input-field {
       width: 100%;
       padding: 12px 14px;
       border: 2px solid #e0e0e0;
       border-radius: 6px;
       box-sizing: border-box;
       font-size: 14px;
       transition: all 0.3s;
       background-color: #f8f9fa;
   }

   .input-field:focus {
       border-color: #00796b;
       background-color: #fff;
       outline: none;
       box-shadow: 0 0 0 3px rgba(0, 121, 107, 0.1);
   }

   .password-container {
       position: relative;
   }

   

   .login-btn {
       width: 100%;
       padding: 12px;
       background: linear-gradient(135deg, #00796b, #004d40);
       border: none;
       color: white;
       font-weight: 600;
       font-size: 15px;
       cursor: pointer;
       border-radius: 6px;
       transition: all 0.3s;
       margin-top: 8px;
       letter-spacing: 0.5px;
   }

   .login-btn:hover {
       background: linear-gradient(135deg, #00695c, #003d33);
       transform: translateY(-1px);
       box-shadow: 0 4px 12px rgba(0, 77, 64, 0.25);
   }

   .message {
       text-align: center;
       color: #e53935;
       margin: 12px 0;
       font-size: 13px;
       min-height: 18px;
   }

       
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="login-box">
            
            <h2>Supplier Login</h2>

                          <div class="input-group">
    <label for="Name">Name</label>
    <asp:TextBox ID="Name" runat="server" CssClass="input-field" placeholder="Enter supplier username" />
           </div>

            <div class="input-group">
                <label for="txtUsername">Username</label>
                <asp:TextBox ID="txtUsername" runat="server" CssClass="input-field" placeholder="Enter supplier username" />
            </div>
           

            <div class="input-group password-container">
                <label for="txtPassword">Password</label>
                <asp:TextBox ID="txtPassword" runat="server" TextMode="Password" CssClass="input-field" placeholder="Enter your password" />
                
            </div>

            <asp:Button ID="btnLogin" runat="server" Text="Login" OnClick="btnLogin_Click" CssClass="login-btn" />

            <asp:Label ID="lblMessage" runat="server" CssClass="message"></asp:Label>
        </div>
    </form>

</body>
</html>