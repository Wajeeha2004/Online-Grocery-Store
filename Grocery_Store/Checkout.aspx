<%@ Page Language="VB" AutoEventWireup="false" CodeFile="Checkout.aspx.vb" Inherits="Checkout" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Checkout</title>
    <style type="text/css">
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f5f5f5;
        }
        .container {
            width: 80%;
            margin: 20px auto;
            background-color: white;
            padding: 20px;
            border-radius: 5px;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
        }
        .checkout-header {
            font-size: 24px;
            color: #333;
            margin-bottom: 20px;
            padding-bottom: 10px;
            border-bottom: 1px solid #eee;
        }
        .section {
            margin-bottom: 30px;
            padding-bottom: 20px;
            border-bottom: 1px solid #eee;
        }
        .section-title {
            font-size: 18px;
            color: #4CAF50;
            margin-bottom: 15px;
        }
        .gridview {
            width: 100%;
            border-collapse: collapse;
            margin-bottom: 20px;
        }
        .gridview th {
            background-color: #4CAF50;
            color: white;
            padding: 10px;
            text-align: left;
        }
        .gridview td {
            padding: 10px;
            border-bottom: 1px solid #ddd;
        }
        .gridview tr:nth-child(even) {
            background-color: #f9f9f9;
        }
        .total-section {
            text-align: right;
            font-size: 18px;
            font-weight: bold;
            margin: 20px 0;
        }
        .form-group {
            margin-bottom: 15px;
        }
        .form-group label {
            display: block;
            margin-bottom: 5px;
            font-weight: bold;
        }
        .form-control {
            width: 100%;
            padding: 8px;
            border: 1px solid #ddd;
            border-radius: 4px;
            box-sizing: border-box;
        }
        .btn {
            padding: 10px 20px;
            border: none;
            border-radius: 3px;
            cursor: pointer;
            font-size: 16px;
            background-color: #4CAF50;
            color: white;
        }
        .message {
            padding: 10px;
            margin-bottom: 15px;
            border-radius: 4px;
        }
        .error-message {
            background-color: #ffdddd;
            color: #d8000c;
        }
        .success-message {
            background-color: #ddffdd;
            color: #4F8A10;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="container">
            <div class="checkout-header">Checkout</div>
            
            <asp:Label ID="lblMessage" runat="server" CssClass="message" Visible="false"></asp:Label>
            
            <div class="section">
                <div class="section-title">Order Summary</div>
                <asp:GridView ID="gvOrderItems" runat="server" AutoGenerateColumns="False" CssClass="gridview">
                    <Columns>
                        <asp:BoundField DataField="Prod_Name" HeaderText="Product" />
                        <asp:BoundField DataField="Price" HeaderText="Price" DataFormatString="Rs. {0:N2}" />
                        <asp:BoundField DataField="Quantity" HeaderText="Qty" />
                        <asp:BoundField DataField="Subtotal" HeaderText="Subtotal" DataFormatString="Rs. {0:N2}" />
                    </Columns>
                </asp:GridView>
                
                <div class="total-section">
                    <div>Subtotal: <asp:Label ID="lblSubtotal" runat="server" Text="Rs. 0.00"></asp:Label></div>
                    <div>Total: <asp:Label ID="lblTotal" runat="server" Text="Rs. 0.00"></asp:Label></div>
                </div>
            </div>
            
            <div class="section">
                <div class="section-title">Shipping Information</div>
                
                <div class="form-group">
                    <label for="txtShippingAddress">Shipping Address</label>
                    <asp:TextBox ID="txtShippingAddress" runat="server" CssClass="form-control" TextMode="MultiLine" Rows="3" required="true"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="rfvShippingAddress" runat="server" 
                        ControlToValidate="txtShippingAddress" ErrorMessage="Shipping address is required" 
                        Display="Dynamic" CssClass="error-message"></asp:RequiredFieldValidator>
                </div>
                
                <div class="form-group">
                    <label for="txtPhone">Phone Number</label>
                    <asp:TextBox ID="txtPhone" runat="server" CssClass="form-control" required="true"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="rfvPhone" runat="server" 
                        ControlToValidate="txtPhone" ErrorMessage="Phone number is required" 
                        Display="Dynamic" CssClass="error-message"></asp:RequiredFieldValidator>
                    <asp:RegularExpressionValidator ID="revPhone" runat="server"
                        ControlToValidate="txtPhone" ErrorMessage="Enter a valid phone number"
                        ValidationExpression="^[0-9]{10,15}$" Display="Dynamic" CssClass="error-message"></asp:RegularExpressionValidator>
                </div>
                
                <div class="form-group">
                    <label for="ddlShippingMethod">Shipping Method</label>
                    <asp:DropDownList ID="ddlShippingMethod" runat="server" CssClass="form-control">
                        <asp:ListItem Text="Standard Shipping (3-5 business days)" Value="Standard"></asp:ListItem>
                        <asp:ListItem Text="Express Shipping (1-2 business days)" Value="Express"></asp:ListItem>
                    </asp:DropDownList>
                </div>
            </div>
            
            <div class="form-group" style="text-align: right;">
                <asp:Button ID="btnPlaceOrder" runat="server" Text="Place Order" CssClass="btn" OnClick="btnPlaceOrder_Click" />
            </div>
        </div>
    </form>
</body>
</html>