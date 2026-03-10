<!--#include file="../inc/config.asp" -->
<%
Session(ADMIN_SESSION_KEY) = ""
Response.Redirect "/admin/login.asp"
%>
