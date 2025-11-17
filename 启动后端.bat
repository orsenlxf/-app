@echo off
REM 仅启动后端服务
REM 使用方法：双击此文件或在命令行运行

chcp 65001 >nul
cls

echo ========================================
echo   启动后端服务
echo ========================================
echo.

REM 获取脚本所在目录
set "SCRIPT_DIR=%~dp0"
cd /d "%SCRIPT_DIR%"

REM 检查是否在项目根目录
if not exist "backend\pom.xml" (
    echo [错误] 找不到backend目录
    echo [提示] 请确保在项目根目录下运行此脚本
    echo [提示] 当前目录: %CD%
    pause
    exit /b 1
)

cd backend

REM 检查Java
echo [1/3] 检查Java环境...
java -version >nul 2>&1
if %errorlevel% neq 0 (
    echo [错误] 未检测到Java环境
    echo [提示] 请安装JDK 8或更高版本
    pause
    exit /b 1
)
java -version
echo.

REM 检查Maven
echo [2/3] 检查Maven环境...
mvn -version >nul 2>&1
if %errorlevel% neq 0 (
    echo [错误] 未检测到Maven
    echo [提示] 请安装Maven 3.6.1+
    pause
    exit /b 1
)
mvn -version
echo.

REM 启动服务（使用Maven直接运行，无需打包）
echo [3/3] 启动后端服务...
echo [信息] 服务将在 http://localhost:8081 启动
echo [信息] 首次运行可能需要下载依赖，请耐心等待
echo [提示] 按Ctrl+C停止服务
echo.

mvn spring-boot:run

pause

