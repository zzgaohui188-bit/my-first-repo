<!--#include file="_header.asp" -->
<!--#include file="../inc/db.asp" -->
<%
Dim conn, action, id
Set conn = OpenConn()
action = QS("action", "")
id = ToInt(QS("id", 0))

If Request.ServerVariables("REQUEST_METHOD") = "POST" Then
  Dim name, parentId, sortOrder
  name = FS("name", "")
  parentId = ToInt(FS("parent_id", 0))
  sortOrder = ToInt(FS("sort_order", 0))
  If name <> "" Then
    conn.Execute "INSERT INTO categories(name,parent_id,sort_order) VALUES(N'" & Replace(name, "'", "''") & "'," & parentId & "," & sortOrder & ")"
  End If
End If

If action = "delete" And id > 0 Then
  conn.Execute "DELETE FROM categories WHERE id=" & id
  Response.Redirect "/admin/categories.asp"
End If

Dim rsCat, rsTop
Set rsCat = conn.Execute("SELECT c.*, p.name AS parent_name FROM categories c LEFT JOIN categories p ON c.parent_id = p.id ORDER BY c.parent_id, c.sort_order, c.id")
Set rsTop = conn.Execute("SELECT * FROM categories WHERE parent_id = 0 ORDER BY sort_order, id")
%>
<h1>分类管理</h1>
<form method="post" class="toolbar">
  <input type="text" name="name" placeholder="分类名称" required>
  <select name="parent_id">
    <option value="0">一级分类</option>
    <% Do Until rsTop.EOF %>
      <option value="<%=rsTop("id")%>"><%=H(rsTop("name"))%></option>
    <% rsTop.MoveNext: Loop %>
  </select>
  <input type="number" name="sort_order" value="0" placeholder="排序">
  <button type="submit">新增分类</button>
</form>

<table class="table">
  <tr><th>ID</th><th>分类名称</th><th>父级</th><th>排序</th><th>操作</th></tr>
  <% Do Until rsCat.EOF %>
  <tr>
    <td><%=rsCat("id")%></td>
    <td><%=H(rsCat("name"))%></td>
    <td><%=H(rsCat("parent_name"))%></td>
    <td><%=rsCat("sort_order")%></td>
    <td><a href="/admin/categories.asp?action=delete&id=<%=rsCat("id")%>" onclick="return confirm('确认删除?')">删除</a></td>
  </tr>
  <% rsCat.MoveNext: Loop %>
</table>
<%
rsCat.Close: rsTop.Close
Set rsCat=Nothing:Set rsTop=Nothing
conn.Close:Set conn=Nothing
%>
<!--#include file="_footer.asp" -->
