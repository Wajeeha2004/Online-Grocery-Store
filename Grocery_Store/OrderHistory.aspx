<%@ Page Language="VB" AutoEventWireup="false" CodeFile="OrderHistory.aspx.vb" 
Inherits="OrderHistory" %> 
 
<!DOCTYPE html> 
 
<html xmlns="http://www.w3.org/1999/xhtml"> 
<head runat="server"> 
    <title>Grocery Store - My Orders</title> 
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
        .btn-dashboard { 
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
        .orders-container { 
            margin: 20px 0; 
        } 
        .order-card { 
            background-color: white; 
            padding: 20px; 
            border-radius: 5px; 
            margin-bottom: 20px; 
            box-shadow: 0 2px 5px rgba(0,0,0,0.1); 
        } 
        .order-header { 
            display: flex; 
            justify-content: space-between; 
            margin-bottom: 10px; 
            padding-bottom: 10px; 
            border-bottom: 1px solid #eee; 
        } 
        .order-id { 
            font-weight: bold; 
            color: #333; 
        } 
        .order-date { 
            color: #6c757d; 
        } 
        .order-status { 
            padding: 5px 10px; 
            border-radius: 4px; 
            font-weight: bold; 
        } 
        .status-pending { 
            background-color: #fff3cd; 
            color: #856404; 
        } 
        .status-completed { 
            background-color: #d4edda; 
            color: #155724; 
        } 
        .status-cancelled { 
            background-color: #f8d7da; 
            color: #721c24; 
        } 
 
 
 
        .order-items { 
            width: 100%; 
            border-collapse: collapse; 
            margin-top: 10px; 
        } 
        .order-items th { 
            text-align: left; 
            padding: 8px; 
            background-color: #f2f2f2; 
        } 
        .order-items td { 
            padding: 8px; 
            border-bottom: 1px solid #ddd; 
        } 
        .order-total { 
            text-align: right; 
            margin-top: 10px; 
            font-weight: bold; 
            font-size: 18px; 
        } 
        .no-orders { 
            text-align: center; 
            padding: 20px; 
            background-color: white; 
            border-radius: 5px; 
            box-shadow: 0 2px 5px rgba(0,0,0,0.1); 
        } 
    </style> 
</head> 
<body> 
    <form id="form1" runat="server"> 
        <div class="header"> 
            <div class="container header-content"> 
                <div class="logo">Grocery Store</div> 
                <div class="user-nav"> 
                    <asp:Button ID="btnViewCart" runat="server" Text="View Cart" 
CssClass="btn-nav btn-cart" OnClick="btnViewCart_Click" /> 
                    <asp:Button ID="btnDashboard" runat="server" Text="Dashboard" 
CssClass="btn-nav btn-dashboard" OnClick="btnDashboard_Click" /> 
                    <asp:Button ID="btnLogout" runat="server" Text="Logout" 
CssClass="btn-nav btn-logout" OnClick="btnLogout_Click" /> 
                </div> 
            </div> 
        </div> 
 
        <div class="container"> 
            <h1>My Orders</h1> 
            <div class="orders-container"> 
                <asp:Panel ID="pnlOrders" runat="server"> 
                     <asp:Literal ID="litOrders" runat="server"></asp:Literal> 
                  </asp:Panel> 
            </div> 
        </div> 
    </form> 
</body> 
    </html>