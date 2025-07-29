<%@ Page Language="VB" AutoEventWireup="false" CodeFile="Cart.aspx.vb" Inherits="Cart" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Shopping Cart</title>
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
        .cart-header {
            font-size: 24px;
            color: #333;
            margin-bottom: 20px;
            padding-bottom: 10px;
            border-bottom: 1px solid #eee;
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
        .btn {
            padding: 10px 20px;
            border: none;
            border-radius: 3px;
            cursor: pointer;
            font-size: 16px;
        }
        .btn-checkout {
            background-color: #4CAF50;
            color: white;
        }
        .btn-continue {
            background-color: #2196F3;
            color: white;
        }
        .btn-remove {
            background-color: #f44336;
            color: white;
            padding: 5px 10px;
            font-size: 14px;
        }
        .btn-update {
            background-color: #FFC107;
            color: black;
            padding: 5px 10px;
            font-size: 14px;
        }
        .quantity-input {
            width: 50px;
            padding: 5px;
            text-align: center;
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
        .empty-cart {
            text-align: center;
            padding: 20px;
            font-size: 18px;
        }
        .action-buttons {
            text-align: right;
            margin-top: 20px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="container">
            <div class="cart-header">Shopping Cart</div>

            <asp:Label ID="lblMessage" runat="server" CssClass="message" Visible="false"></asp:Label>

            <asp:Panel ID="pnlCartItems" runat="server">
                <asp:GridView ID="gvCart" runat="server" AutoGenerateColumns="False"
                    CssClass="gridview" OnRowCommand="gvCart_RowCommand"
                    OnRowDeleting="gvCart_RowDeleting" DataKeyNames="Cart_ID">
                    <Columns>
                        <asp:BoundField DataField="Prod_Name" HeaderText="Product Name" />
                        <asp:BoundField DataField="Price" HeaderText="Price" DataFormatString="{0:C}" />
                        <asp:TemplateField HeaderText="Quantity">
                            <ItemTemplate>
                                <asp:TextBox ID="txtQuantity" runat="server" Text='<%# Eval("Quantity") %>' Width="40px"></asp:TextBox>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:BoundField DataField="Subtotal" HeaderText="Subtotal" DataFormatString="{0:C}" />
                        <asp:TemplateField>
                            <ItemTemplate>
                               
                                <asp:Button ID="btnRemove" runat="server" CommandName="Delete"
                                    Text="Remove" CssClass="btn btn-remove" />
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                </asp:GridView>

                <div class="total-section">
                    <asp:Label ID="lblTotal" runat="server" Text="Total: Rs. 0.00"></asp:Label>
                </div>

                <div class="action-buttons">
                    <asp:Button ID="btnContinueShopping" runat="server"
                        Text="Continue Shopping" CssClass="btn btn-continue"
                        OnClick="btnContinueShopping_Click" />
                    <asp:Button ID="btnCheckout" runat="server" Text="Proceed to Checkout"
                        CssClass="btn btn-checkout" OnClick="btnCheckout_Click" />
                </div>
            </asp:Panel>

            <asp:Panel ID="pnlEmptyCart" runat="server" Visible="false" CssClass="empty-cart">
                Your shopping cart is empty.
                <br /><br />
                <asp:Button ID="btnStartShopping" runat="server" Text="Start Shopping"
                    CssClass="btn btn-continue" OnClick="btnContinueShopping_Click" />
            </asp:Panel>
        </div>
    </form>
</body>
</html>
