<%@ Page Language="VB" AutoEventWireup="false" CodeFile="Registration.aspx.vb" Inherits="Registration" %>

<!DOCTYPE html>
<html>
<head runat="server">
    <title>Registration</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500&display=swap" rel="stylesheet">
    <style>
        body {
            font-family: 'Poppins', sans-serif;
            background: url('https://static.vecteezy.com/system/resources/thumbnails/045/661/918/small_2x/empty-wooden-table-with-a-beautiful-grocery-store-background-featuring-aisles-of-colorful-products-ideal-for-food-marketing-and-promotions-photo.jpeg') center/cover fixed;
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
            margin: 0;
        }
        .reg-box {
            background: rgba(255,255,255,0.98);
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 4px 15px rgba(0,0,0,0.08);
            width: 100%;
            max-width: 380px;
        }
        h2 { 
            text-align: center;
            margin: 0 0 12px; 
            color: #00796b;
            font-size: 20px;
            font-weight: 600;
        }
        label { 
            display: block; 
            margin: 6px 0 3px; 
            font-weight: 400; 
            font-size: 11px;
            color: #555;
            letter-spacing: 0.2px;
        }
        input { 
            width: 100%; 
            padding: 8px 10px; 
            margin-bottom: 6px; 
            border: 1px solid #e0e0e0; 
            border-radius: 4px;
            font-size: 13px;
            transition: border 0.2s;
            height: 36px;
            box-sizing: border-box;
        }
        input:focus {
            border-color: #00796b;
            outline: none;
        }
        .btn { 
            width: 100%; 
            padding: 9px; 
            background: #00796b; 
            color: white; 
            border: none; 
            border-radius: 4px; 
            font-weight: 500;
            font-size: 13px;
            margin-top: 4px;
            cursor: pointer;
            transition: background 0.2s;
            height: 36px;
        }
        .btn:hover { 
            background: #00695c;
        }
        .message { 
            color: #e53935; 
            text-align: center; 
            margin-top: 8px; 
            font-size: 11px; 
            min-height: 16px;
        }
        .role { 
            text-align: center; 
            color: #00796b; 
            font-weight: 500; 
            margin-bottom: 12px;
            font-size: 12px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="reg-box">
            <h2>Registration</h2>
            <asp:Label ID="lblRole" runat="server" CssClass="role"></asp:Label>
            <br />

            <!-- First Name -->
            <asp:Label runat="server" Text="First Name"></asp:Label>
            <asp:TextBox ID="FirstName" runat="server"></asp:TextBox>
            <asp:RequiredFieldValidator ID="rfvFirstName" runat="server"
                ControlToValidate="FirstName"
                ErrorMessage="First name is required."
                ForeColor="Red"
                Display="Dynamic" />
            <asp:RegularExpressionValidator ID="revFirstName" runat="server"
                ControlToValidate="FirstName"
                ValidationExpression="^[A-Za-z]{3,}$"
                ErrorMessage="Only alphabets, min 3 chars."
                ForeColor="Red"
                Display="Dynamic" />

            <!-- Last Name -->
            <asp:Label runat="server" Text="Last Name"></asp:Label>
            <asp:TextBox ID="lastName" runat="server"></asp:TextBox>
            <asp:RequiredFieldValidator ID="rfvLastName" runat="server"
                ControlToValidate="lastName"
                ErrorMessage="Last name is required."
                ForeColor="Red"
                Display="Dynamic" />
            <asp:RegularExpressionValidator ID="revLastName" runat="server"
                ControlToValidate="lastName"
                ValidationExpression="^[A-Za-z]{3,}$"
                ErrorMessage="Only alphabets, min 3 chars."
                ForeColor="Red"
                Display="Dynamic" />

            <!-- Username -->
            <asp:Label runat="server" Text="Username"></asp:Label>
            <asp:TextBox ID="txtUsername" runat="server"></asp:TextBox>
            <asp:RequiredFieldValidator ID="rfvUsername" runat="server"
                ControlToValidate="txtUsername"
                ErrorMessage="Username is required."
                ForeColor="Red"
                Display="Dynamic" />
            <asp:RegularExpressionValidator ID="revUsername" runat="server"
                ControlToValidate="txtUsername"
                ValidationExpression="^\w{4,}$"
                ErrorMessage="Min 4 characters, letters or numbers only."
                ForeColor="Red"
                Display="Dynamic" />

            <!-- Password -->
            <asp:Label runat="server" Text="Password"></asp:Label>
            <asp:TextBox ID="txtPassword" runat="server" TextMode="Password"></asp:TextBox>
            <asp:RequiredFieldValidator ID="rfvPassword" runat="server"
                ControlToValidate="txtPassword"
                ErrorMessage="Password is required."
                ForeColor="Red"
                Display="Dynamic" />
            <asp:RegularExpressionValidator ID="revPassword" runat="server"
                ControlToValidate="txtPassword"
                ValidationExpression="^.{6,}$"
                ErrorMessage="Password must be at least 6 characters."
                ForeColor="Red"
                Display="Dynamic" />

            <!-- Address -->
            <asp:Label runat="server" Text="Address"></asp:Label>
            <asp:TextBox ID="txtAddress" runat="server"></asp:TextBox>
            <asp:RequiredFieldValidator ID="rfvAddress" runat="server"
                ControlToValidate="txtAddress"
                ErrorMessage="Address is required."
                ForeColor="Red"
                Display="Dynamic" />
            <asp:RegularExpressionValidator ID="revAddress" runat="server"
                ControlToValidate="txtAddress"
                ValidationExpression="^.{5,}$"
                ErrorMessage="Address must be at least 5 characters."
                ForeColor="Red"
                Display="Dynamic" />

            <!-- Register Button -->
            <asp:Button ID="btnRegister" runat="server" Text="Register" CssClass="btn"
                OnClick="btnRegister_Click"
                CausesValidation="true" />

            <asp:Label ID="lblMessage" runat="server" CssClass="message"></asp:Label>

            <asp:ValidationSummary ID="ValidationSummary1" runat="server"
                ForeColor="Red"
                ShowMessageBox="False"
                ShowSummary="True" />
        </div>
    </form>
</body>
</html>
