<!--#include file="inc/db.asp" -->
<!--#include file="inc/functions.asp" -->
<!--#include file="inc/layout_header.asp" -->
<%
Dim conn, catId, keyword, page, pageSize, offset
Dim whereSql, sqlList, sqlCount
Dim cmdList, cmdCount, rsList, rsCount, totalRows, totalPages
Dim rsTopCat

Set conn = OpenConn()
catId = ToInt(QS("cat", 0))
keyword = QS("keyword", "")
page = ToInt(QS("page", 1))
If page < 1 Then page = 1
pageSize = 12
offset = (page - 1) * pageSize

whereSql = " WHERE 1=1 "
If catId > 0 Then whereSql = whereSql & " AND category_id = ? "
If keyword <> "" Then whereSql = whereSql & " AND (name LIKE ? OR sku LIKE ? OR keywords LIKE ?) "

sqlCount = "SELECT COUNT(1) AS total_rows FROM products " & whereSql
Set cmdCount = CreateCmd(conn, sqlCount)
If catId > 0 Then AddParam cmdCount, "@cat", 3, 4, catId
If keyword <> "" Then
  AddParam cmdCount, "@k1", 202, 255, LikeParam(keyword)
  AddParam cmdCount, "@k2", 202, 255, LikeParam(keyword)
  AddParam cmdCount, "@k3", 202, 255, LikeParam(keyword)
End If
Set rsCount = cmdCount.Execute
totalRows = rsCount("total_rows")
If totalRows = 0 Then
  totalPages = 1
Else
  totalPages = Int((totalRows + pageSize - 1) / pageSize)
End If

sqlList = "SELECT * FROM products " & whereSql & " ORDER BY sort_order, id DESC OFFSET ? ROWS FETCH NEXT ? ROWS ONLY"
Set cmdList = CreateCmd(conn, sqlList)
If catId > 0 Then AddParam cmdList, "@cat", 3, 4, catId
If keyword <> "" Then
  AddParam cmdList, "@k1", 202, 255, LikeParam(keyword)
  AddParam cmdList, "@k2", 202, 255, LikeParam(keyword)
  AddParam cmdList, "@k3", 202, 255, LikeParam(keyword)
End If
AddParam cmdList, "@offset", 3, 4, offset
AddParam cmdList, "@size", 3, 4, pageSize
Set rsList = cmdList.Execute

Set rsTopCat = conn.Execute("SELECT * FROM categories WHERE parent_id = 0 ORDER BY sort_order, id")
%>

<section>
  <h1>产品列表</h1>
  <form method="get" class="toolbar">
    <select name="cat">
      <option value="0">全部分类</option>
      <% Do Until rsTopCat.EOF %>
      <option value="<%=rsTopCat("id")%>" <% If catId = rsTopCat("id") Then Response.Write "selected" End If %>><%=H(rsTopCat("name"))%></option>
      <% rsTopCat.MoveNext: Loop %>
    </select>
    <input type="text" name="keyword" value="<%=H(keyword)%>" placeholder="关键词搜索">
    <button type="submit">筛选</button>
  </form>

  <div class="grid cols-4">
    <% Do Until rsList.EOF %>
    <article class="card product">
      <img src="<%=H(rsList("main_image"))%>" alt="<%=H(rsList("name"))%>">
      <h3><%=H(rsList("name"))%></h3>
      <p>SKU: <%=H(rsList("sku"))%></p>
      <p>资质：<%=H(rsList("cert_tags"))%></p>
      <a href="/product.asp?id=<%=rsList("id")%>">查看详情</a>
    </article>
    <% rsList.MoveNext: Loop %>
  </div>

  <div class="pager">
    <% Dim i
       For i = 1 To totalPages %>
      <a href="/products.asp?cat=<%=catId%>&keyword=<%=Server.URLEncode(keyword)%>&page=<%=i%>" class="<% If i = page Then Response.Write "active" End If %>"><%=i%></a>
    <% Next %>
  </div>
</section>

<%
rsCount.Close: rsList.Close: rsTopCat.Close
Set rsCount = Nothing: Set rsList = Nothing: Set rsTopCat = Nothing
Set cmdCount = Nothing: Set cmdList = Nothing
conn.Close: Set conn = Nothing
%>
<!--#include file="inc/layout_footer.asp" -->
