@echo off
REM 玉竹育种APP启动脚本
REM 使用方法：双击此文件或在命令行运行

chcp 65001 >nul
cls

echo ========================================
echo   玉竹育种APP启动脚本
echo ========================================
echo.

REM 获取脚本所在目录
set "SCRIPT_DIR=%~dp0"
cd /d "%SCRIPT_DIR%"

echo [信息] 当前目录: %CD%
echo.

REM 检查Java环境
echo [1/4] 检查Java环境...
java -version >nul 2>&1
if %errorlevel% neq 0 (
    echo [错误] 未检测到Java环境，请先安装JDK 8+
    echo [提示] 下载地址: https://www.oracle.com/java/technologies/downloads/
    echo.
    pause
    exit /b 1
)
java -version
echo [成功] Java环境正常

REM 检查Maven
echo.
echo [2/4] 检查Maven环境...
call mvn -version >nul 2>&1
set MAVEN_CHECK=%errorlevel%
if %MAVEN_CHECK% neq 0 (
    echo [错误] 未检测到Maven，请先安装Maven 3.6.1+
    echo [提示] 下载地址: https://maven.apache.org/download.cgi
    echo.
    pause
    exit /b 1
)
call mvn -version
echo [成功] Maven环境正常

REM 检查MySQL（可选）
echo.
echo [3/4] 检查MySQL数据库...
mysql --version >nul 2>&1
if %errorlevel% neq 0 (
    echo [警告] 未检测到MySQL，请确保数据库服务已启动
) else (
    echo [成功] MySQL环境正常
)

REM 启动后端
echo.
echo [4/4] 启动后端服务...
if not exist "backend\pom.xml" (
    echo [错误] 找不到backend目录或pom.xml文件
    echo [提示] 请确保在项目根目录下运行此脚本
    pause
    exit /b 1
)

cd backend
if %errorlevel% neq 0 (
    echo [错误] 无法进入backend目录
    pause
    exit /b 1
)

echo [信息] 启动后端服务 (端口: 8081)...
echo [信息] 首次运行可能需要下载依赖，请耐心等待
start "后端服务" cmd /k "cd /d %CD% && mvn spring-boot:run"
if %errorlevel% neq 0 (
    echo [错误] 启动后端服务失败
    pause
    exit /b 1
)
timeout /t 10 /nobreak >nul

REM 启动前端
echo.
echo [5/5] 启动前端服务...
cd ..
if %errorlevel% neq 0 (
    echo [错误] 无法返回项目根目录
    pause
    exit /b 1
)

if not exist "frontend\pages" (
    echo [错误] 找不到frontend目录
    echo [提示] 当前目录: %CD%
    pause
    exit /b 1
)

echo [信息] 启动前端服务 (端口: 8080)...
echo [提示] 访问地址: http://localhost:8080
echo [提示] 当前目录: %CD%

REM 检查Python
python --version >nul 2>&1
if %errorlevel% equ 0 (
    echo [信息] 使用Python启动前端服务...
    start "前端服务" cmd /k "cd /d %CD% && python -m http.server 8080"
    if %errorlevel% neq 0 (
        echo [警告] Python启动失败，尝试其他方式...
    )
) else (
    REM 检查http-server
    where http-server >nul 2>&1
    if %errorlevel% equ 0 (
        echo [信息] 使用http-server启动前端服务...
        start "前端服务" cmd /k "cd /d %CD% && http-server -p 8080 -c-1"
    ) else (
        echo [警告] 未找到Python或http-server
        echo [提示] 可以直接打开 index.html 文件，或安装Python/Node.js
        echo [提示] Python下载: https://www.python.org/downloads/
        echo [提示] 前端服务未启动，但后端服务已启动
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
echo 提示:
echo   - 服务已在后台运行，关闭此窗口不会停止服务
echo   - 要停止服务，请关闭对应的"后端服务"和"前端服务"窗口
echo   - 或按Ctrl+C停止当前服务
echo.
pause

