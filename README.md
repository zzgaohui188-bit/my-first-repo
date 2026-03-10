# 跨境选品展示平台（Classic ASP + SQL Server）

本项目是根据 PRD 实现的完整 V1.1 站点源码，适用于 **Windows Server 2012 + IIS + SQL Server**。

## 目录结构

- `site/`：网站根目录（IIS 指向该目录）
- `site/admin/`：后台管理
- `site/inc/`：配置、数据库、公共函数
- `site/assets/`：CSS/JS/图片静态资源
- `database/schema.sql`：数据库建表与管理员初始化脚本

## 部署步骤

1. 在 SQL Server 执行 `database/schema.sql`。
2. 在 IIS 新建网站，物理路径指向 `site/`。
3. 修改 `site/inc/config.asp` 中数据库连接信息。
4. 打开前台：`/index.asp`。
5. 打开后台：`/admin/login.asp`。

## 默认后台账号

- 用户名：`admin`
- 密码：`admin123`

> 建议上线后立即修改密码并启用 HTTPS。
