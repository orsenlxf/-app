# 路径问题修复说明

## 问题

访问 `http://localhost:8080/frontend/pages/auth/register.html` 时出现 404 错误。

## 原因

前端服务器启动位置不同，导致路径不一致：
- 如果服务器在 `frontend` 目录下启动，路径应该是：`/pages/auth/register.html`
- 如果服务器在项目根目录启动，路径应该是：`/frontend/pages/auth/register.html`

## 解决方案

### 方案一：在项目根目录启动前端服务器（推荐）

修改 `启动前端.bat`，在项目根目录启动服务器：

```bash
# 在项目根目录运行
python -m http.server 8080
```

这样所有路径都统一为：`/frontend/pages/...`

### 方案二：在frontend目录启动，修改所有路径引用

如果要在 `frontend` 目录下启动，需要修改所有路径引用：
- `index.html` 中的链接
- 所有页面中的跳转路径
- JavaScript 中的路径引用

## 正确的访问路径

### 如果服务器在项目根目录启动：

- 首页：`http://localhost:8080/index.html`
- 登录页：`http://localhost:8080/frontend/pages/auth/login.html`
- 注册页：`http://localhost:8080/frontend/pages/auth/register.html`
- 监测页：`http://localhost:8080/frontend/pages/monitoring/monitoring-dashboard.html`
- 控制页：`http://localhost:8080/frontend/pages/control/device-control.html`

### 如果服务器在frontend目录启动：

- 登录页：`http://localhost:8080/pages/auth/login.html`
- 注册页：`http://localhost:8080/pages/auth/register.html`
- 监测页：`http://localhost:8080/pages/monitoring/monitoring-dashboard.html`
- 控制页：`http://localhost:8080/pages/control/device-control.html`

## 快速修复

已更新 `启动前端.bat`，现在会在项目根目录启动服务器，路径统一为 `/frontend/pages/...`

重新启动前端服务后，访问：
- `http://localhost:8080/frontend/pages/auth/register.html` 应该可以正常访问

