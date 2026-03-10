<!--#include file="_header.asp" -->
<!--#include file="../inc/db.asp" -->
<%
Dim conn, id, isEdit, name, sku, categoryId, mainImage, sellingPoints, parameters, certTags, sortOrder, isHot, isActive
Set conn = OpenConn()
id = ToInt(QS("id", 0))
isEdit = (id > 0)

If Request.ServerVariables("REQUEST_METHOD") = "POST" Then
  name = FS("name", "")
  sku = FS("sku", "")
  categoryId = ToInt(FS("category_id", 0))
  mainImage = FS("main_image", "")
  sellingPoints = FS("selling_points", "")
  parameters = FS("parameters", "")
  certTags = FS("cert_tags", "")
  sortOrder = ToInt(FS("sort_order", 0))
  isHot = ToInt(FS("is_hot", 0))
  isActive = ToInt(FS("is_active", 1))

  Dim cmd
  If isEdit Then
    Set cmd = CreateCmd(conn, "UPDATE products SET name=?, sku=?, category_id=?, main_image=?, selling_points=?, parameters=?, cert_tags=?, sort_order=?, is_hot=?, is_active=? WHERE id=?")
  Else
    Set cmd = CreateCmd(conn, "INSERT INTO products(name, sku, category_id, main_image, selling_points, parameters, cert_tags, sort_order, is_hot, is_active, created_at) VALUES(?,?,?,?,?,?,?,?,?,?,GETDATE())")
  End If

  AddParam cmd, "@name", 202, 255, name
  AddParam cmd, "@sku", 202, 100, sku
  AddParam cmd, "@category", 3, 4, categoryId
  AddParam cmd, "@img", 202, 255, mainImage
  AddParam cmd, "@sp", 203, 0, sellingPoints
  AddParam cmd, "@params", 203, 0, parameters
  AddParam cmd, "@cert", 202, 255, certTags
  AddParam cmd, "@sort", 3, 4, sortOrder
  AddParam cmd, "@hot", 11, 1, isHot
  AddParam cmd, "@active", 11, 1, isActive
  If isEdit Then AddParam cmd, "@id", 3, 4, id
  cmd.Execute
  Set cmd = Nothing
  Response.Redirect "/admin/products.asp"
End If

Dim rsData, rsCat
If isEdit Then
  Set rsData = conn.Execute("SELECT * FROM products WHERE id=" & id)
  If Not rsData.EOF Then
    name = rsData("name"): sku = rsData("sku"): categoryId = rsData("category_id")
    mainImage = rsData("main_image"): sellingPoints = rsData("selling_points")
    parameters = rsData("parameters"): certTags = rsData("cert_tags")
    sortOrder = rsData("sort_order"): isHot = rsData("is_hot"): isActive = rsData("is_active")
  End If
End If
Set rsCat = conn.Execute("SELECT * FROM categories ORDER BY sort_order, id")
%>
<h1><% If isEdit Then Response.Write "编辑" Else Response.Write "新增" End If %>商品</h1>
<form method="post" class="form card">
  <input type="text" name="name" value="<%=H(name)%>" placeholder="产品名称" required>
  <input type="text" name="sku" value="<%=H(sku)%>" placeholder="SKU" required>
  <select name="category_id" required>
    <option value="">选择分类</option>
    <% Do Until rsCat.EOF %>
      <option value="<%=rsCat("id")%>" <% If ToInt(categoryId)=ToInt(rsCat("id")) Then Response.Write "selected" End If %>><%=H(rsCat("name"))%></option>
    <% rsCat.MoveNext: Loop %>
  </select>
  <input type="text" name="main_image" value="<%=H(mainImage)%>" placeholder="主图URL">
  <textarea name="selling_points" placeholder="卖点"><%=H(sellingPoints)%></textarea>
  <textarea name="parameters" placeholder="参数"><%=H(parameters)%></textarea>
  <input type="text" name="cert_tags" value="<%=H(certTags)%>" placeholder="资质标签，如FDA,CE">
  <input type="number" name="sort_order" value="<%=sortOrder%>" placeholder="排序">
  <label><input type="checkbox" name="is_hot" value="1" <% If ToInt(isHot)=1 Then Response.Write "checked" End If %>> 热门</label>
  <label><input type="checkbox" name="is_active" value="1" <% If ToInt(isActive)=1 Then Response.Write "checked" End If %>> 上架</label>
  <button type="submit">保存</button>
</form>
<%
If isEdit Then rsData.Close:Set rsData=Nothing
rsCat.Close:Set rsCat=Nothing
conn.Close:Set conn=Nothing
%>
<!--#include file="_footer.asp" -->
