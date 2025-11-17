@echo off
REM 启动应用脚本（调试版本，显示详细错误信息）
REM 使用方法：双击此文件或在命令行运行

chcp 65001 >nul
cls

echo ========================================
echo   玉竹育种APP启动脚本（调试模式）
echo ========================================
echo.

REM 获取脚本所在目录
set "SCRIPT_DIR=%~dp0"
cd /d "%SCRIPT_DIR%"

echo [调试] 脚本目录: %SCRIPT_DIR%
echo [调试] 当前目录: %CD%
echo.

REM 检查Java环境
echo [1/4] 检查Java环境...
java -version
if %errorlevel% neq 0 (
    echo [错误] 未检测到Java环境，请先安装JDK 8+
    echo [提示] 下载地址: https://www.oracle.com/java/technologies/downloads/
    echo.
    pause
    exit /b 1
)
echo [成功] Java环境正常
echo.

REM 检查Maven
echo [2/4] 检查Maven环境...
echo [调试] 正在执行: mvn -version
call mvn -version
set MAVEN_ERROR=%errorlevel%
echo [调试] Maven命令返回码: %MAVEN_ERROR%
echo [调试] 当前目录: %CD%
if %MAVEN_ERROR% neq 0 (
    echo [错误] 未检测到Maven，请先安装Maven 3.6.1+
    echo [提示] 下载地址: https://maven.apache.org/download.cgi
    echo.
    echo [调试] 按任意键退出...
    pause >nul
    exit /b 1
)
echo [成功] Maven环境正常
echo [调试] Maven检查完成，继续执行...
echo [调试] 准备检查MySQL...
echo.

REM 检查MySQL（可选）
echo [3/4] 检查MySQL数据库...
echo [调试] 正在检查MySQL...
mysql --version >nul 2>&1
set MYSQL_ERROR=%errorlevel%
if %MYSQL_ERROR% neq 0 (
    echo [警告] 未检测到MySQL，请确保数据库服务已启动
    echo [调试] MySQL检查完成（可选，不影响启动）
) else (
    mysql --version
    echo [成功] MySQL环境正常
)
echo [调试] MySQL检查完成，继续执行...
echo.

REM 检查项目结构
echo [调试] 开始检查项目结构...
echo [调试] 当前工作目录: %CD%
echo [调试] 检查backend\pom.xml...
if not exist "backend\pom.xml" (
    echo [错误] 找不到backend\pom.xml文件
    echo [调试] 当前目录: %CD%
    echo [调试] 尝试列出文件:
    dir /b
    echo.
    echo [调试] 按任意键退出...
    pause >nul
    exit /b 1
)
echo [成功] 找到backend\pom.xml
echo [调试] backend\pom.xml检查完成

echo [调试] 检查frontend\pages目录...
if not exist "frontend\pages" (
    echo [错误] 找不到frontend\pages目录
    echo [调试] 当前目录: %CD%
    echo [调试] 尝试列出frontend目录:
    if exist "frontend" (
        dir frontend /b
    ) else (
        echo frontend目录不存在
    )
    echo.
    echo [调试] 按任意键退出...
    pause >nul
    exit /b 1
)
echo [成功] 找到frontend\pages目录
echo [调试] 项目结构检查完成
echo.

REM 启动后端
echo [4/4] 启动后端服务...
echo [调试] 准备进入backend目录...
cd backend
set CD_BACKEND_ERROR=%errorlevel%
if %CD_BACKEND_ERROR% neq 0 (
    echo [错误] 无法进入backend目录
    echo [调试] 当前目录: %CD%
    echo [调试] 错误代码: %CD_BACKEND_ERROR%
    echo [调试] 按任意键退出...
    pause >nul
    exit /b 1
)

echo [调试] 后端目录: %CD%
echo [调试] 检查pom.xml是否存在...
if not exist "pom.xml" (
    echo [错误] 在backend目录中找不到pom.xml
    echo [调试] 当前目录: %CD%
    dir /b
    echo [调试] 按任意键退出...
    pause >nul
    exit /b 1
)
echo [调试] pom.xml存在，继续启动...

echo [信息] 启动后端服务 (端口: 8081)...
echo [信息] 首次运行可能需要下载依赖，请耐心等待
echo [调试] 执行命令: mvn spring-boot:run
echo [调试] 正在启动后端服务窗口...
echo.

start "后端服务" cmd /k "cd /d %CD% && mvn spring-boot:run"
set START_BACKEND_ERROR=%errorlevel%
echo [调试] start命令返回码: %START_BACKEND_ERROR%
if %START_BACKEND_ERROR% neq 0 (
    echo [错误] 启动后端服务失败
    echo [调试] 错误代码: %START_BACKEND_ERROR%
    echo [调试] 按任意键退出...
    pause >nul
    exit /b 1
)
echo [调试] 后端服务启动命令已执行

echo [信息] 等待后端服务启动...
echo [调试] 等待10秒...
timeout /t 10 /nobreak >nul
echo [调试] 等待完成

REM 启动前端
echo.
echo [5/5] 启动前端服务...
echo [调试] 准备返回项目根目录...
cd ..
set CD_ROOT_ERROR=%errorlevel%
if %CD_ROOT_ERROR% neq 0 (
    echo [错误] 无法返回项目根目录
    echo [调试] 当前目录: %CD%
    echo [调试] 错误代码: %CD_ROOT_ERROR%
    echo [调试] 按任意键退出...
    pause >nul
    exit /b 1
)

echo [调试] 前端目录: %CD%
echo [调试] 检查frontend目录...
if not exist "frontend" (
    echo [错误] 找不到frontend目录
    echo [调试] 当前目录: %CD%
    dir /b
    echo [调试] 按任意键退出...
    pause >nul
    exit /b 1
)
echo [调试] frontend目录存在

REM 检查Python
echo [调试] 检查Python...
python --version >nul 2>&1
set PYTHON_ERROR=%errorlevel%
echo [调试] Python检查返回码: %PYTHON_ERROR%
if %PYTHON_ERROR% equ 0 (
    python --version
    echo [信息] 使用Python启动前端服务...
    echo [调试] 执行: start "前端服务" cmd /k "cd /d %CD% && python -m http.server 8080"
    start "前端服务" cmd /k "cd /d %CD% && python -m http.server 8080"
    set START_FRONTEND_ERROR=%errorlevel%
    echo [调试] 前端服务启动命令返回码: %START_FRONTEND_ERROR%
) else (
    echo [调试] Python不可用，检查http-server...
    where http-server >nul 2>&1
    set HTTP_SERVER_ERROR=%errorlevel%
    echo [调试] http-server检查返回码: %HTTP_SERVER_ERROR%
    if %HTTP_SERVER_ERROR% equ 0 (
        where http-server
        echo [信息] 使用http-server启动前端服务...
        echo [调试] 执行: start "前端服务" cmd /k "cd /d %CD% && http-server -p 8080 -c-1"
        start "前端服务" cmd /k "cd /d %CD% && http-server -p 8080 -c-1"
        set START_FRONTEND_ERROR=%errorlevel%
        echo [调试] 前端服务启动命令返回码: %START_FRONTEND_ERROR%
    ) else (
        echo [警告] 未找到Python或http-server
        echo [提示] 可以直接打开 index.html 文件
        echo [调试] 前端服务未启动，但后端服务已启动
    )
)
echo [调试] 前端服务启动检查完成

echo.
echo [调试] 所有启动步骤完成
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
echo.
echo [调试] 脚本执行完成，按任意键关闭此窗口...
pause >nul

