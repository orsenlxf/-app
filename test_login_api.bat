@echo off
echo ========================================
echo   测试登录API
echo ========================================
echo.

echo [测试1] GET请求（应该返回405或400）
echo.
curl -X GET http://localhost:8081/api/auth/login
echo.
echo.

echo [测试2] POST请求（无请求体，应该返回400）
echo.
curl -X POST http://localhost:8081/api/auth/login -H "Content-Type: application/json"
echo.
echo.

echo [测试3] POST请求（空用户名，应该返回400）
echo.
curl -X POST http://localhost:8081/api/auth/login ^
  -H "Content-Type: application/json" ^
  -d "{\"username\":\"\",\"password\":\"admin123\"}"
echo.
echo.

echo [测试4] POST请求（正确的登录信息）
echo.
curl -X POST http://localhost:8081/api/auth/login ^
  -H "Content-Type: application/json" ^
  -d "{\"username\":\"admin\",\"password\":\"admin123\"}"
echo.
echo.

echo ========================================
echo   测试完成
echo ========================================
echo.
pause

