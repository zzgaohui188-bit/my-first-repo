<!--#include file="inc/db.asp" -->
<!--#include file="inc/functions.asp" -->
<!--#include file="inc/layout_header.asp" -->
<%
Dim conn, rsBanner, rsCat, rsHot, rsNew
Set conn = OpenConn()

Set rsBanner = conn.Execute("SELECT TOP 5 * FROM banners WHERE status = 1 ORDER BY sort_order, id DESC")
Set rsCat = conn.Execute("SELECT TOP 12 * FROM categories WHERE parent_id = 0 ORDER BY sort_order, id")
Set rsHot = conn.Execute("SELECT TOP 12 * FROM products WHERE is_hot = 1 ORDER BY sort_order, id DESC")
Set rsNew = conn.Execute("SELECT TOP 12 * FROM products ORDER BY created_at DESC")
%>

<section class="banner">
  <h2>Banner轮播</h2>
  <div class="grid banner-grid">
  <% Do Until rsBanner.EOF %>
    <a class="card" href="<%=H(rsBanner("link_url"))%>">
      <img src="<%=H(rsBanner("image_url"))%>" alt="banner">
    </a>
  <% rsBanner.MoveNext: Loop %>
  </div>
</section>

<section>
  <h2>产品分类入口</h2>
  <div class="grid cols-4">
  <% Do Until rsCat.EOF %>
    <a class="card" href="/products.asp?cat=<%=rsCat("id")%>"><%=H(rsCat("name"))%></a>
  <% rsCat.MoveNext: Loop %>
  </div>
</section>

<section>
  <h2>热门产品</h2>
  <div class="grid cols-4">
  <% Do Until rsHot.EOF %>
    <article class="card product">
      <img src="<%=H(rsHot("main_image"))%>" alt="<%=H(rsHot("name"))%>">
      <h3><%=H(rsHot("name"))%></h3>
      <p>SKU: <%=H(rsHot("sku"))%></p>
      <a href="/product.asp?id=<%=rsHot("id")%>">查看详情</a>
    </article>
  <% rsHot.MoveNext: Loop %>
  </div>
</section>

<section>
  <h2>新品推荐</h2>
  <div class="grid cols-4">
  <% Do Until rsNew.EOF %>
    <article class="card product">
      <img src="<%=H(rsNew("main_image"))%>" alt="<%=H(rsNew("name"))%>">
      <h3><%=H(rsNew("name"))%></h3>
      <p>SKU: <%=H(rsNew("sku"))%></p>
      <a href="/product.asp?id=<%=rsNew("id")%>">查看详情</a>
    </article>
  <% rsNew.MoveNext: Loop %>
  </div>
</section>

<section class="features">
  <h2>平台优势</h2>
  <ul>
    <li>工厂直连，品类丰富</li>
    <li>证书齐全，质量可追溯</li>
    <li>支持OEM/ODM定制</li>
  </ul>
</section>

<section>
  <h2>合作流程</h2>
  <ol>
    <li>选品咨询</li>
    <li>需求确认</li>
    <li>打样与报价</li>
    <li>量产交付</li>
  </ol>
</section>

<%
rsBanner.Close: rsCat.Close: rsHot.Close: rsNew.Close
Set rsBanner = Nothing: Set rsCat = Nothing: Set rsHot = Nothing: Set rsNew = Nothing
conn.Close: Set conn = Nothing
%>
<!--#include file="inc/layout_footer.asp" -->
