<!--#include file="inc/db.asp" -->
<!--#include file="inc/functions.asp" -->
<!--#include file="inc/layout_header.asp" -->
<%
Dim conn, productId, cmd, rs, rsImages, rsCert
productId = ToInt(QS("id", 0))
If productId <= 0 Then
  Response.Write "<p>产品不存在</p>"
  Response.End
End If

Set conn = OpenConn()
Set cmd = CreateCmd(conn, "SELECT p.*, c.name AS category_name FROM products p LEFT JOIN categories c ON p.category_id = c.id WHERE p.id = ?")
AddParam cmd, "@id", 3, 4, productId
Set rs = cmd.Execute

If rs.EOF Then
  Response.Write "<p>产品不存在</p>"
  Response.End
End If

Set rsImages = conn.Execute("SELECT * FROM product_images WHERE product_id = " & productId & " ORDER BY sort_order, id")
Set rsCert = conn.Execute("SELECT * FROM product_certificates WHERE product_id = " & productId & " ORDER BY id DESC")
%>
<section>
  <h1><%=H(rs("name"))%></h1>
  <div class="grid cols-2">
    <div>
      <img src="<%=H(rs("main_image"))%>" alt="<%=H(rs("name"))%>">
      <div class="thumbs">
        <% Do Until rsImages.EOF %>
          <img src="<%=H(rsImages("image_url"))%>" alt="图集">
        <% rsImages.MoveNext: Loop %>
      </div>
    </div>
    <div>
      <p>SKU：<%=H(rs("sku"))%></p>
      <p>分类：<%=H(rs("category_name"))%></p>
      <p>库存状态：<%=H(rs("stock_status"))%></p>
      <h3>产品卖点</h3>
      <p><%=Replace(H(rs("selling_points")), vbCrLf, "<br>")%></p>
      <h3>产品参数</h3>
      <p><%=Replace(H(rs("parameters")), vbCrLf, "<br>")%></p>
    </div>
  </div>
</section>

<section>
  <h2>资质证书</h2>
  <div class="grid cols-4">
    <% Do Until rsCert.EOF %>
      <a class="card" href="<%=H(rsCert("file_url"))%>" target="_blank"><%=H(rsCert("cert_name"))%></a>
    <% rsCert.MoveNext: Loop %>
  </div>
</section>

<section>
  <h2>询盘表单</h2>
  <form method="post" action="/submit_inquiry.asp" class="form">
    <input type="hidden" name="product_id" value="<%=productId%>">
    <input type="text" name="name" placeholder="姓名" required>
    <input type="email" name="email" placeholder="邮箱" required>
    <input type="text" name="phone" placeholder="电话" required>
    <textarea name="message" placeholder="需求备注" rows="5" required></textarea>
    <button type="submit">提交询盘</button>
  </form>
</section>

<%
rs.Close: rsImages.Close: rsCert.Close
Set rs = Nothing: Set rsImages = Nothing: Set rsCert = Nothing
Set cmd = Nothing
conn.Close: Set conn = Nothing
%>
<!--#include file="inc/layout_footer.asp" -->
