@echo off
chcp 65001 >nul
cls
echo ========================================
echo   玉竹育种APP - 快速启动
echo ========================================
echo.

REM 获取脚本目录
cd /d "%~dp0"

echo [步骤1/3] 检查环境...
java -version >nul 2>&1
if %errorlevel% neq 0 (
    echo [错误] Java未安装，请先安装JDK 8+
    pause
    exit /b 1
)

call mvn -version >nul 2>&1
if %errorlevel% neq 0 (
    echo [错误] Maven未安装，请先安装Maven 3.6.1+
    pause
    exit /b 1
)

echo [成功] 环境检查通过
echo.

echo [步骤2/3] 检查数据库...
echo [提示] 如果数据库未初始化，请先运行: database\import.bat
echo [提示] 按任意键继续，或按Ctrl+C取消...
pause >nul
echo.

echo [步骤3/3] 启动服务...
echo.

REM 启动后端
echo [启动] 后端服务 (端口8081)...
cd backend
start "后端服务-8081" cmd /k "mvn spring-boot:run"
cd ..
timeout /t 5 /nobreak >nul

REM 启动前端
echo [启动] 前端服务 (端口8080)...
python --version >nul 2>&1
if %errorlevel% equ 0 (
    start "前端服务-8080" cmd /k "python -m http.server 8080"
) else (
    echo [警告] Python未安装，无法启动前端服务
    echo [提示] 请手动启动前端服务或安装Python
)

echo.
echo ========================================
echo   启动完成！
echo ========================================
echo.
echo 访问地址:
echo   前端: http://localhost:8080/index.html
echo   登录: http://localhost:8080/frontend/pages/auth/login.html
echo.
echo 测试账号:
echo   用户名: admin
echo   密码: admin123
echo.
echo 提示:
echo   - 等待后端启动完成（约30秒-2分钟）
echo   - 看到 "Started YuzhuAppApplication" 表示后端启动成功
echo   - 关闭服务窗口会停止对应服务
echo.
pause

