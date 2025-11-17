@echo off
echo ========================================
echo   测试后端API连接
echo ========================================
echo.

echo [1/3] 测试后端服务是否运行...
netstat -ano | findstr :8081 >nul
if %errorlevel% equ 0 (
    echo [成功] 后端服务正在运行（端口8081）
) else (
    echo [错误] 后端服务未运行，请先启动后端服务
    pause
    exit /b 1
)

echo.
echo [2/3] 测试API端点可访问性...
curl -X GET http://localhost:8081/api/auth/login -v 2>nul
if %errorlevel% equ 0 (
    echo [成功] API端点可访问
) else (
    echo [警告] 无法使用curl测试，请手动在浏览器中测试
)

echo.
echo [3/3] 测试CORS配置...
curl -X OPTIONS http://localhost:8081/api/auth/login -H "Origin: http://localhost:8080" -H "Access-Control-Request-Method: POST" -v 2>nul
if %errorlevel% equ 0 (
    echo [成功] CORS预检请求成功
) else (
    echo [警告] 无法使用curl测试CORS，请手动在浏览器中测试
)

echo.
echo ========================================
echo   测试完成
echo ========================================
echo.
echo 如果看到"拒绝访问"错误，请：
echo 1. 重启后端服务（使CORS配置生效）
echo 2. 清除浏览器缓存并刷新页面
echo 3. 检查浏览器控制台的Network标签页
echo.
pause

