<!--#include file="_header.asp" -->
<!--#include file="../inc/db.asp" -->
<%
Dim conn, action, id
Set conn = OpenConn()
action = QS("action", "")
id = ToInt(QS("id", 0))

If action = "delete" And id > 0 Then
  conn.Execute "DELETE FROM products WHERE id=" & id
  Response.Redirect "/admin/products.asp"
End If

If action = "toggle" And id > 0 Then
  conn.Execute "UPDATE products SET is_active = CASE WHEN is_active=1 THEN 0 ELSE 1 END WHERE id=" & id
  Response.Redirect "/admin/products.asp"
End If

Dim rs
Set rs = conn.Execute("SELECT p.*, c.name AS category_name FROM products p LEFT JOIN categories c ON p.category_id = c.id ORDER BY p.id DESC")
%>
<h1>商品管理</h1>
<p><a class="btn" href="/admin/product_edit.asp">新增商品</a></p>
<table class="table">
  <tr><th>ID</th><th>名称</th><th>SKU</th><th>分类</th><th>热门</th><th>状态</th><th>操作</th></tr>
  <% Do Until rs.EOF %>
  <tr>
    <td><%=rs("id")%></td>
    <td><%=H(rs("name"))%></td>
    <td><%=H(rs("sku"))%></td>
    <td><%=H(rs("category_name"))%></td>
    <td><%=rs("is_hot")%></td>
    <td><%=rs("is_active")%></td>
    <td>
      <a href="/admin/product_edit.asp?id=<%=rs("id")%>">编辑</a>
      <a href="/admin/products.asp?action=toggle&id=<%=rs("id")%>">上下架</a>
      <a href="/admin/products.asp?action=delete&id=<%=rs("id")%>" onclick="return confirm('确认删除?')">删除</a>
    </td>
  </tr>
  <% rs.MoveNext: Loop %>
</table>
<%
rs.Close:Set rs=Nothing
conn.Close:Set conn=Nothing
%>
<!--#include file="_footer.asp" -->
