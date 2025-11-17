@echo off
REM 测试Maven命令
chcp 65001 >nul
echo 测试Maven命令...
echo.

echo [测试1] 直接执行mvn -version
mvn -version
echo 返回码: %errorlevel%
echo.

echo [测试2] 使用call执行mvn -version
call mvn -version
set TEST_ERROR=%errorlevel%
echo 返回码: %TEST_ERROR%
echo.

echo [测试3] 检查errorlevel
if %errorlevel% equ 0 (
    echo Maven可用
) else (
    echo Maven不可用
)
echo.

pause

