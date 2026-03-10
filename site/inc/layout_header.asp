<!--#include file="config.asp" -->
<!--#include file="functions.asp" -->
<!DOCTYPE html>
<html lang="zh-CN">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title><%=SITE_NAME%></title>
  <link rel="stylesheet" href="/assets/css/style.css">
</head>
<body>
<header class="site-header">
  <div class="container topbar">
    <div class="logo"><a href="/index.asp"><%=SITE_NAME%></a></div>
    <form class="search" action="/products.asp" method="get">
      <input type="text" name="keyword" placeholder="搜索产品/SKU/关键词">
      <button type="submit">搜索</button>
    </form>
  </div>
  <nav class="container nav">
    <a href="/index.asp">首页</a>
    <a href="/products.asp">全部产品</a>
    <a href="/products.asp">产品分类</a>
    <a href="/about.asp">资质保障</a>
    <a href="/about.asp">关于我们</a>
    <a href="/contact.asp">联系我们</a>
  </nav>
</header>
<main class="container">
