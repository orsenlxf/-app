@echo off
chcp 65001 >nul
echo ========================================
echo   启动MQTT Broker
echo ========================================
echo.

REM 检查Mosquitto是否已安装为服务
sc query mosquitto >nul 2>&1
if %errorlevel% equ 0 (
    echo [信息] 检测到Mosquitto服务
    echo [信息] 尝试启动服务（需要管理员权限）...
    net start mosquitto
    if %errorlevel% equ 0 (
        echo [成功] Mosquitto服务已启动
        goto :end
    ) else (
        echo [警告] 服务启动失败，尝试手动启动...
    )
)

REM 尝试手动启动Mosquitto
echo [信息] 尝试手动启动Mosquitto...
echo.

REM 检查常见安装路径
set "MOSQUITTO_PATH="

if exist "D:\mosquitto_xiazai\mosquitto\mosquitto.exe" (
    set "MOSQUITTO_PATH=D:\mosquitto_xiazai\mosquitto\mosquitto.exe"
    set "MOSQUITTO_CONF=D:\mosquitto_xiazai\mosquitto\mosquitto.conf"
) else if exist "C:\Program Files\mosquitto\mosquitto.exe" (
    set "MOSQUITTO_PATH=C:\Program Files\mosquitto\mosquitto.exe"
    set "MOSQUITTO_CONF=C:\Program Files\mosquitto\mosquitto.conf"
) else if exist "C:\mosquitto\mosquitto.exe" (
    set "MOSQUITTO_PATH=C:\mosquitto\mosquitto.exe"
    set "MOSQUITTO_CONF=C:\mosquitto\mosquitto.conf"
)

if defined MOSQUITTO_PATH (
    echo [信息] 找到Mosquitto: %MOSQUITTO_PATH%
    echo [信息] 启动MQTT Broker (端口: 1883)...
    echo [提示] 按Ctrl+C停止服务
    echo.
    start "MQTT Broker" cmd /k ""%MOSQUITTO_PATH%" -c "%MOSQUITTO_CONF%""
    timeout /t 2 /nobreak >nul
    echo [成功] MQTT Broker已启动
) else (
    echo [错误] 未找到Mosquitto安装路径
    echo [提示] 请手动指定Mosquitto路径，或安装Mosquitto
    echo [提示] 下载地址: https://mosquitto.org/download/
    echo.
    echo [提示] 如果暂时不需要MQTT，可以在application.yml中设置:
    echo        mqtt.enabled: false
)

:end
echo.
echo ========================================
echo   提示
echo ========================================
echo.
echo 如果MQTT已启动，可以:
echo   1. 编辑 backend/src/main/resources/application.yml
echo   2. 设置 mqtt.enabled: true
echo   3. 重启后端服务
echo.
pause

