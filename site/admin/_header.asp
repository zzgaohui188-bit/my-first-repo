<!--#include file="../inc/config.asp" -->
<!--#include file="../inc/functions.asp" -->
<%
RequireAdminLogin
%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
  <meta charset="UTF-8"><meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>后台管理</title>
  <link rel="stylesheet" href="/assets/css/style.css">
</head>
<body>
<main class="container">
<nav class="nav admin-nav">
  <a href="/admin/dashboard.asp">仪表盘</a>
  <a href="/admin/products.asp">商品管理</a>
  <a href="/admin/categories.asp">分类管理</a>
  <a href="/admin/banners.asp">Banner管理</a>
  <a href="/admin/inquiries.asp">询盘管理</a>
  <a href="/admin/logout.asp">退出</a>
</nav>
