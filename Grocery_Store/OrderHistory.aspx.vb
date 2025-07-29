Imports System.ComponentModel
Imports System.Data
Imports System.Data.SqlClient
Imports System.Text

Partial Class OrderHistory
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Session("UserID") Is Nothing Then
            Response.Redirect("User_Login.aspx")
            Return
        End If

        If Not IsPostBack Then
            LoadOrders()
        End If
    End Sub

    Private Sub LoadOrders()
        Dim userId As Integer = Convert.ToInt32(Session("UserID"))
        Dim html As New StringBuilder()

        Using conn As New SqlConnection("Server=Grocery_store.mssql.somee.com;Database=Grocery_store;User Id=wajeeha2004_SQLLogin_1;Password=z1xo3teh8f;TrustServerCertificate=True;")
            Dim orderCmd As New SqlCommand("SELECT Order_ID, Order_Date FROM Customer_Order WHERE Customer_ID = @UserID ORDER BY Order_Date DESC", conn)
            orderCmd.Parameters.Add("@UserID", SqlDbType.Int).Value = userId

            Try
                conn.Open()
                Using orderReader As SqlDataReader = orderCmd.ExecuteReader()
                    If Not orderReader.HasRows Then
                        html.Append("<div class='no-orders'>You haven't placed any orders yet.</div>")
                    Else
                        While orderReader.Read()
                            Dim orderId As Integer = Convert.ToInt32(orderReader("Order_ID"))

                            html.Append("<div class='order-card'>")
                            html.Append("<div class='order-header'>")
                            html.Append("<div class='order-meta'>")
                            html.AppendFormat("<span class='order-id'>Order ID: #ORD-{0}</span>", orderId)
                            html.Append("</div></div>")

                            ' Fetch Order Items
                            Dim itemsHtml As New StringBuilder()
                            Dim totalAmount As Decimal = 0

                            Using itemsConn As New SqlConnection("Server=Grocery_store.mssql.somee.com;Database=Grocery_store;User Id=wajeeha2004_SQLLogin_1;Password=z1xo3teh8f;TrustServerCertificate=True;")
                                Dim itemsCmd As New SqlCommand("SELECT p.Prod_Name, oi.Quantity, p.Price FROM Order_Details oi INNER JOIN Product p ON oi.Product_ID = p.Product_ID WHERE oi.Order_ID = @OrderID", itemsConn)
                                itemsCmd.Parameters.Add("@OrderID", SqlDbType.Int).Value = orderId

                                itemsConn.Open()
                                Using itemsReader As SqlDataReader = itemsCmd.ExecuteReader()
                                    If itemsReader.HasRows Then
                                        itemsHtml.Append("<div class='order-itemscontainer'>")
                                        itemsHtml.Append("<table class='order-items'>")
                                        itemsHtml.Append("<thead><tr><th>Product</th><th>Quantity</th><th>Unit Price</th><th>Total</th></tr></thead>")
                                        itemsHtml.Append("<tbody>")

                                        While itemsReader.Read()
                                            Dim productName As String = itemsReader("Prod_Name").ToString()
                                            Dim quantity As Integer = Convert.ToInt32(itemsReader("Quantity"))
                                            Dim price As Decimal = Convert.ToDecimal(itemsReader("Price"))
                                            Dim itemTotal As Decimal = quantity * price
                                            totalAmount += itemTotal

                                            itemsHtml.Append("<tr>")
                                            itemsHtml.AppendFormat("<td>{0}</td>", productName)
                                            itemsHtml.AppendFormat("<td>{0}</td>", quantity)
                                            itemsHtml.AppendFormat("<td>Rs. {0:N2}</td>", price)
                                            itemsHtml.AppendFormat("<td>Rs. {0:N2}</td>", itemTotal)
                                            itemsHtml.Append("</tr>")
                                        End While

                                        itemsHtml.Append("</tbody></table>")
                                        itemsHtml.AppendFormat("<div class='order-summary'><div class='ordertotal'>Total Amount: <span>Rs. {0:N2}</span></div></div>", totalAmount)
                                        itemsHtml.Append("</div>")
                                    Else
                                        itemsHtml.Append("<div class='no-items'>No items found in this order.</div>")
                                    End If
                                End Using
                            End Using

                            html.Append(itemsHtml.ToString())
                            html.Append("</div>") ' Close order-card
                        End While
                    End If
                End Using
            Catch ex As Exception
                html.Append("<div class='error-message'>Error loading orders: " & Server.HtmlEncode(ex.Message) & "</div>")
            End Try
        End Using

        litOrders.Text = html.ToString()
    End Sub

    Protected Sub btnViewCart_Click(sender As Object, e As EventArgs) Handles btnViewCart.Click
        Response.Redirect("Cart.aspx")
    End Sub

    Protected Sub btnDashboard_Click(sender As Object, e As EventArgs) Handles btnDashboard.Click
        Response.Redirect("User_Dash.aspx")
    End Sub

    Protected Sub btnLogout_Click(sender As Object, e As EventArgs) Handles btnLogout.Click
        Session.Clear()
        Response.Redirect("User_Login.aspx")
    End Sub
End Class
