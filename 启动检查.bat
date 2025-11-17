@echo off
chcp 65001 >nul
echo ========================================
echo   玉竹育种APP - 启动前检查
echo ========================================
echo.

echo [1/6] 检查Java环境...
java -version >nul 2>&1
if %errorlevel% neq 0 (
    echo [错误] Java未安装或未配置环境变量
    echo 请安装Java 8+并配置JAVA_HOME
    pause
    exit /b 1
) else (
    echo [成功] Java环境正常
    java -version
)

echo.
echo [2/6] 检查Maven环境...
call mvn -version >nul 2>&1
if %errorlevel% neq 0 (
    echo [错误] Maven未安装或未配置环境变量
    echo 请安装Maven 3.6.1+并配置MAVEN_HOME
    pause
    exit /b 1
) else (
    echo [成功] Maven环境正常
    call mvn -version
)

echo.
echo [3/6] 检查MySQL服务...
sc query MySQL >nul 2>&1
if %errorlevel% neq 0 (
    echo [警告] 无法检查MySQL服务状态
    echo 请手动确认MySQL服务正在运行
) else (
    sc query MySQL | findstr "RUNNING" >nul
    if %errorlevel% equ 0 (
        echo [成功] MySQL服务正在运行
    ) else (
        echo [警告] MySQL服务可能未运行
        echo 请启动MySQL服务
    )
)

echo.
echo [4/6] 检查端口占用...
netstat -ano | findstr :8081 >nul
if %errorlevel% equ 0 (
    echo [警告] 端口8081已被占用
    echo 后端服务可能已在运行，或需要关闭占用端口的程序
) else (
    echo [成功] 端口8081可用
)

netstat -ano | findstr :8080 >nul
if %errorlevel% equ 0 (
    echo [警告] 端口8080已被占用
    echo 前端服务可能已在运行，或需要关闭占用端口的程序
) else (
    echo [成功] 端口8080可用
)

echo.
echo [5/6] 检查数据库...
echo 请手动验证数据库是否已初始化：
echo   1. 数据库 yuzhuapp 已创建
echo   2. 所有表已创建
echo   3. admin用户存在
echo.
echo 验证命令：
echo   mysql -u root -p
echo   USE yuzhuapp;
echo   SHOW TABLES;
echo   SELECT * FROM users WHERE username = 'admin';
echo.

echo [6/6] 检查项目文件...
if not exist "backend\pom.xml" (
    echo [错误] backend\pom.xml 不存在
    pause
    exit /b 1
) else (
    echo [成功] 后端项目文件存在
)

if not exist "frontend\pages\auth\login.html" (
    echo [错误] 前端登录页面不存在
    pause
    exit /b 1
) else (
    echo [成功] 前端项目文件存在
)

echo.
echo ========================================
echo   检查完成
echo ========================================
echo.
echo 如果所有检查都通过，可以运行：
echo   启动应用.bat
echo.
pause

