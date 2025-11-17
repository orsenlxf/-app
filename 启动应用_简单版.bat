@echo off
REM 启动应用脚本（简单版本，减少输出）
chcp 65001 >nul

REM 获取脚本所在目录
set "SCRIPT_DIR=%~dp0"
cd /d "%SCRIPT_DIR%"

echo 正在启动玉竹育种APP...
echo.

REM 检查Java
java -version >nul 2>&1
if %errorlevel% neq 0 (
    echo [错误] 未检测到Java环境
    pause
    exit /b 1
)

REM 检查Maven
mvn -version >nul 2>&1
if %errorlevel% neq 0 (
    echo [错误] 未检测到Maven
    pause
    exit /b 1
)

REM 启动后端
if not exist "backend\pom.xml" (
    echo [错误] 找不到backend目录
    pause
    exit /b 1
)

cd backend
start "后端服务" cmd /k "cd /d %CD% && mvn spring-boot:run"
timeout /t 5 /nobreak >nul

REM 启动前端
cd ..
if not exist "frontend\pages" (
    echo [警告] 找不到frontend目录，仅启动后端
    pause
    exit /b 0
)

python --version >nul 2>&1
if %errorlevel% equ 0 (
    start "前端服务" cmd /k "cd /d %CD% && python -m http.server 8080"
) else (
    where http-server >nul 2>&1
    if %errorlevel% equ 0 (
        start "前端服务" cmd /k "cd /d %CD% && http-server -p 8080 -c-1"
    )
)

echo.
echo 启动完成！
echo 前端: http://localhost:8080
echo 后端: http://localhost:8081/api
echo.
pause

