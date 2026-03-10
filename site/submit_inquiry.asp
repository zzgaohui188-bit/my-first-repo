<!--#include file="inc/db.asp" -->
<!--#include file="inc/functions.asp" -->
<%
Dim name, email, phone, productId, message
name = FS("name", "")
email = FS("email", "")
phone = FS("phone", "")
productId = ToInt(FS("product_id", 0))
message = FS("message", "")

If name = "" Or email = "" Or phone = "" Or message = "" Then
    AlertAndBack "请填写完整信息"
End If

Dim conn, cmd
Set conn = OpenConn()
Set cmd = CreateCmd(conn, "INSERT INTO inquiries(name, email, phone, product_id, message, created_at, status) VALUES(?,?,?,?,?,GETDATE(),0)")
AddParam cmd, "@name", 202, 100, name
AddParam cmd, "@email", 202, 100, email
AddParam cmd, "@phone", 202, 50, phone
AddParam cmd, "@product", 3, 4, productId
AddParam cmd, "@message", 203, 0, message
cmd.Execute

Set cmd = Nothing
conn.Close
Set conn = Nothing

Response.Write "<script>alert('询盘提交成功，我们会尽快联系您');location.href='/products.asp';</script>"
%>
