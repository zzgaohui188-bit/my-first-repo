<!--#include file="../inc/db.asp" -->
<!--#include file="../inc/functions.asp" -->
<%
If Request.ServerVariables("REQUEST_METHOD") = "POST" Then
  Dim username, password, conn, cmd, rs
  username = FS("username", "")
  password = FS("password", "")

  Set conn = OpenConn()
  Set cmd = CreateCmd(conn, "SELECT TOP 1 * FROM admins WHERE username=? AND password_hash=CONVERT(VARCHAR(64), HASHBYTES('SHA2_256', ?), 2)")
  AddParam cmd, "@u", 202, 50, username
  AddParam cmd, "@p", 202, 255, password
  Set rs = cmd.Execute

  If Not rs.EOF Then
    Session(ADMIN_SESSION_KEY) = rs("id")
    Response.Redirect "/admin/dashboard.asp"
  Else
    Response.Write "<script>alert('账号或密码错误');</script>"
  End If
  rs.Close: Set rs = Nothing
  Set cmd = Nothing
  conn.Close: Set conn = Nothing
End If
%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
  <meta charset="UTF-8"><meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>后台登录</title>
  <link rel="stylesheet" href="/assets/css/style.css">
</head>
<body>
<main class="container">
  <h1>管理员登录</h1>
  <form method="post" class="form card">
    <input type="text" name="username" placeholder="用户名" required>
    <input type="password" name="password" placeholder="密码" required>
    <button type="submit">登录</button>
  </form>
</main>
</body>
</html>
