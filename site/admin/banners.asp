<!--#include file="_header.asp" -->
<!--#include file="../inc/db.asp" -->
<%
Dim conn, action, id
Set conn = OpenConn()
action = QS("action", "")
id = ToInt(QS("id", 0))

If Request.ServerVariables("REQUEST_METHOD") = "POST" Then
  Dim imageUrl, linkUrl, sortOrder, status
  imageUrl = FS("image_url", "")
  linkUrl = FS("link_url", "#")
  sortOrder = ToInt(FS("sort_order", 0))
  status = ToInt(FS("status", 1))
  If imageUrl <> "" Then
    Dim cmd
    Set cmd = CreateCmd(conn, "INSERT INTO banners(image_url, link_url, sort_order, status) VALUES(?,?,?,?)")
    AddParam cmd, "@img", 202, 255, imageUrl
    AddParam cmd, "@link", 202, 255, linkUrl
    AddParam cmd, "@sort", 3, 4, sortOrder
    AddParam cmd, "@status", 11, 1, status
    cmd.Execute
    Set cmd = Nothing
  End If
End If

If action = "delete" And id > 0 Then
  conn.Execute "DELETE FROM banners WHERE id=" & id
  Response.Redirect "/admin/banners.asp"
End If

Set rs = conn.Execute("SELECT * FROM banners ORDER BY sort_order, id DESC")
%>
<h1>Banner管理</h1>
<form method="post" class="toolbar">
  <input type="text" name="image_url" placeholder="图片URL(/assets/images/banner/xxx.jpg)" required>
  <input type="text" name="link_url" placeholder="跳转链接" value="#">
  <input type="number" name="sort_order" value="0" placeholder="排序">
  <select name="status"><option value="1">启用</option><option value="0">禁用</option></select>
  <button type="submit">新增Banner</button>
</form>

<table class="table">
  <tr><th>ID</th><th>图片</th><th>链接</th><th>排序</th><th>状态</th><th>操作</th></tr>
  <% Do Until rs.EOF %>
  <tr>
    <td><%=rs("id")%></td>
    <td><%=H(rs("image_url"))%></td>
    <td><%=H(rs("link_url"))%></td>
    <td><%=rs("sort_order")%></td>
    <td><%=rs("status")%></td>
    <td><a href="/admin/banners.asp?action=delete&id=<%=rs("id")%>" onclick="return confirm('确认删除?')">删除</a></td>
  </tr>
  <% rs.MoveNext: Loop %>
</table>
<%
rs.Close:Set rs=Nothing
conn.Close:Set conn=Nothing
%>
<!--#include file="_footer.asp" -->
