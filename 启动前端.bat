@echo off
REM 仅启动前端服务
REM 使用方法：双击此文件或在命令行运行

chcp 65001 >nul
cls

echo ========================================
echo   启动前端服务
echo ========================================
echo.

REM 获取脚本所在目录
set "SCRIPT_DIR=%~dp0"
cd /d "%SCRIPT_DIR%"

REM 检查是否在项目根目录
if not exist "frontend\pages" (
    echo [错误] 找不到frontend目录
    echo [提示] 请确保在项目根目录下运行此脚本
    echo [提示] 当前目录: %CD%
    pause
    exit /b 1
)

REM 在项目根目录启动服务器，这样路径更统一
echo [信息] 启动前端服务 (端口: 8080)...
echo [提示] 访问地址: http://localhost:8080
echo [提示] 首页: http://localhost:8080/index.html
echo [提示] 登录页: http://localhost:8080/frontend/pages/auth/login.html
echo [提示] 注册页: http://localhost:8080/frontend/pages/auth/register.html
echo [提示] 按Ctrl+C停止服务
echo.

REM 尝试使用Python（在项目根目录启动）
python -m http.server 8080 2>nul
if %errorlevel% neq 0 (
    REM 尝试使用Node.js http-server
    where http-server >nul 2>&1
    if %errorlevel% equ 0 (
        http-server -p 8080 -c-1
    ) else (
        echo [错误] 未找到Python或http-server
        echo [提示] 请安装Python或Node.js http-server
        echo [提示] 或者直接打开 index.html 文件
        pause
        exit /b 1
    )
)

pause

