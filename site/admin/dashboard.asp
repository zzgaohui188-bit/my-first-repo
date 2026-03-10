<!--#include file="_header.asp" -->
<!--#include file="../inc/db.asp" -->
<%
Dim conn, rs
Set conn = OpenConn()
%>
<h1>后台仪表盘</h1>
<div class="grid cols-4">
  <div class="card"><h3>商品总数</h3><p><%=conn.Execute("SELECT COUNT(1) c FROM products")("c")%></p></div>
  <div class="card"><h3>分类总数</h3><p><%=conn.Execute("SELECT COUNT(1) c FROM categories")("c")%></p></div>
  <div class="card"><h3>Banner总数</h3><p><%=conn.Execute("SELECT COUNT(1) c FROM banners")("c")%></p></div>
  <div class="card"><h3>待处理询盘</h3><p><%=conn.Execute("SELECT COUNT(1) c FROM inquiries WHERE status=0")("c")%></p></div>
</div>
<%
conn.Close:Set conn=Nothing
%>
<!--#include file="_footer.asp" -->
