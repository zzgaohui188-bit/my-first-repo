<!--#include file="_header.asp" -->
<!--#include file="../inc/db.asp" -->
<%
Dim conn, action, id
Set conn = OpenConn()
action = QS("action", "")
id = ToInt(QS("id", 0))

If action = "done" And id > 0 Then
  conn.Execute "UPDATE inquiries SET status=1 WHERE id=" & id
  Response.Redirect "/admin/inquiries.asp"
End If
If action = "delete" And id > 0 Then
  conn.Execute "DELETE FROM inquiries WHERE id=" & id
  Response.Redirect "/admin/inquiries.asp"
End If

Dim rs
Set rs = conn.Execute("SELECT i.*, p.name AS product_name FROM inquiries i LEFT JOIN products p ON i.product_id = p.id ORDER BY i.id DESC")
%>
<h1>询盘管理</h1>
<table class="table">
  <tr><th>ID</th><th>姓名</th><th>邮箱</th><th>电话</th><th>咨询产品</th><th>留言</th><th>时间</th><th>状态</th><th>操作</th></tr>
  <% Do Until rs.EOF %>
  <tr>
    <td><%=rs("id")%></td>
    <td><%=H(rs("name"))%></td>
    <td><%=H(rs("email"))%></td>
    <td><%=H(rs("phone"))%></td>
    <td><%=H(rs("product_name"))%></td>
    <td><%=H(rs("message"))%></td>
    <td><%=rs("created_at")%></td>
    <td><% If rs("status") = 1 Then Response.Write "已处理" Else Response.Write "待处理" End If %></td>
    <td>
      <a href="/admin/inquiries.asp?action=done&id=<%=rs("id")%>">标记已处理</a>
      <a href="/admin/inquiries.asp?action=delete&id=<%=rs("id")%>" onclick="return confirm('确认删除?')">删除</a>
    </td>
  </tr>
  <% rs.MoveNext: Loop %>
</table>
<%
rs.Close:Set rs=Nothing
conn.Close:Set conn=Nothing
%>
<!--#include file="_footer.asp" -->
