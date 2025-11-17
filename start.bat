@echo off
chcp 65001 >nul
echo ========================================
echo   玉竹育种APP启动脚本
echo ========================================
echo.

echo [1/4] 检查Java环境...
java -version >nul 2>&1
if %errorlevel% neq 0 (
    echo [错误] 未检测到Java环境，请先安装JDK 11+
    pause
    exit /b 1
)
echo [成功] Java环境正常

echo.
echo [2/4] 检查MySQL数据库...
mysql --version >nul 2>&1
if %errorlevel% neq 0 (
    echo [警告] 未检测到MySQL，请确保数据库服务已启动
) else (
    echo [成功] MySQL环境正常
)

echo.
echo [3/4] 启动后端服务...
cd backend
if not exist target\yuzhuapp-backend-1.0.0.jar (
    echo [信息] 正在编译后端项目...
    call mvn clean package -DskipTests
    if %errorlevel% neq 0 (
        echo [错误] 后端编译失败
        pause
        exit /b 1
    )
)

echo [信息] 启动后端服务 (端口: 8081)...
start "后端服务" cmd /k "java -jar target\yuzhuapp-backend-1.0.0.jar"
timeout /t 5 /nobreak >nul

echo.
echo [4/4] 启动前端服务...
cd ..\frontend
echo [信息] 启动前端服务 (端口: 8080)...
start "前端服务" cmd /k "python -m http.server 8080"
if %errorlevel% neq 0 (
    echo [警告] Python服务器启动失败，尝试使用Node.js...
    where http-server >nul 2>&1
    if %errorlevel% equ 0 (
        start "前端服务" cmd /k "http-server -p 8080 -c-1"
    ) else (
        echo [错误] 请安装Python或Node.js http-server
        echo [提示] 也可以直接打开 index.html 文件
    )
)

echo.
echo ========================================
echo   启动完成！
echo ========================================
echo.
echo 访问地址:
echo   前端: http://localhost:8080
echo   后端API: http://localhost:8081/api
echo.
echo 默认测试账号:
echo   用户名: admin
echo   密码: admin123
echo.
echo 按任意键关闭此窗口（服务将继续运行）
pause >nul

