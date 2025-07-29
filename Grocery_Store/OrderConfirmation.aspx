<%@ Page Language="VB" AutoEventWireup="false" CodeFile="OrderConfirmation.aspx.vb" Inherits="OrderConfirmation" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Order Confirmation</title>
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
        .confirmation-header {
            font-size: 24px;
            color: #4CAF50;
            margin-bottom: 20px;
            padding-bottom: 10px;
            border-bottom: 1px solid #eee;
        }
        .thank-you {
            font-size: 18px;
            margin-bottom: 20px;
        }
        .order-info {
            margin-bottom: 30px;
        }
        .info-item {
            margin-bottom: 10px;
        }
        .info-label {
            font-weight: bold;
            display: inline-block;
            width: 150px;
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
        .action-buttons {
            text-align: center;
            margin-top: 30px;
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
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="container">
            <div class="confirmation-header">Order Confirmation</div>
            
            <div class="thank-you">
                Thank you for your order! Your purchase has been confirmed.
            </div>
            
            <div class="order-info">
                <div class="info-item">
                    <span class="info-label">Order Number:</span>
                    <asp:Label ID="lblOrderId" runat="server"></asp:Label>
                </div>
                <div class="info-item">
                    <span class="info-label">Order Date:</span>
                    <asp:Label ID="lblOrderDate" runat="server"></asp:Label>
                </div>
                <div class="info-item">
                    <span class="info-label">Shipping Address:</span>
                    <asp:Label ID="lblShippingAddress" runat="server"></asp:Label>
                </div>
                <div class="info-item">
                    <span class="info-label">Shipping Method:</span>
                    <asp:Label ID="lblShippingMethod" runat="server"></asp:Label>
                </div>
            </div>
            
            <div>
                <asp:GridView ID="gvOrderItems" runat="server" AutoGenerateColumns="False" CssClass="gridview">
                    <Columns>
                        <asp:BoundField DataField="Prod_Name" HeaderText="Product" />
                        <asp:BoundField DataField="Price" HeaderText="Price" DataFormatString="Rs. {0:N2}" />
                        <asp:BoundField DataField="Quantity" HeaderText="Qty" />
                        <asp:BoundField DataField="Subtotal" HeaderText="Subtotal" DataFormatString="Rs. {0:N2}" />
                    </Columns>
                </asp:GridView>
                
                <div class="total-section">
                    <div>Total: <asp:Label ID="lblTotal" runat="server" Text="Rs. 0.00"></asp:Label></div>
                </div>
            </div>
            
            <div class="action-buttons">
                <asp:Button ID="btnContinueShopping" runat="server" Text="Continue Shopping" CssClass="btn" OnClick="btnContinueShopping_Click" />
            </div>
        </div>
    </form>
</body>
</html>