#!/bin/bash

echo "========================================"
echo "  玉竹育种APP启动脚本"
echo "========================================"
echo ""

# 检查Java环境
echo "[1/4] 检查Java环境..."
if ! command -v java &> /dev/null; then
    echo "[错误] 未检测到Java环境，请先安装JDK 11+"
    exit 1
fi
echo "[成功] Java环境正常"

# 检查MySQL
echo ""
echo "[2/4] 检查MySQL数据库..."
if ! command -v mysql &> /dev/null; then
    echo "[警告] 未检测到MySQL，请确保数据库服务已启动"
else
    echo "[成功] MySQL环境正常"
fi

# 启动后端
echo ""
echo "[3/4] 启动后端服务..."
cd backend

if [ ! -f "target/yuzhuapp-backend-1.0.0.jar" ]; then
    echo "[信息] 正在编译后端项目..."
    mvn clean package -DskipTests
    if [ $? -ne 0 ]; then
        echo "[错误] 后端编译失败"
        exit 1
    fi
fi

echo "[信息] 启动后端服务 (端口: 8081)..."
java -jar target/yuzhuapp-backend-1.0.0.jar &
BACKEND_PID=$!
sleep 5

# 启动前端
echo ""
echo "[4/4] 启动前端服务..."
cd ../frontend

echo "[信息] 启动前端服务 (端口: 8080)..."
if command -v python3 &> /dev/null; then
    python3 -m http.server 8080 &
    FRONTEND_PID=$!
elif command -v python &> /dev/null; then
    python -m SimpleHTTPServer 8080 &
    FRONTEND_PID=$!
elif command -v http-server &> /dev/null; then
    http-server -p 8080 -c-1 &
    FRONTEND_PID=$!
else
    echo "[错误] 请安装Python或Node.js http-server"
    echo "[提示] 也可以直接打开 index.html 文件"
    kill $BACKEND_PID 2>/dev/null
    exit 1
fi

echo ""
echo "========================================"
echo "  启动完成！"
echo "========================================"
echo ""
echo "访问地址:"
echo "  前端: http://localhost:8080"
echo "  后端API: http://localhost:8081/api"
echo ""
echo "默认测试账号:"
echo "  用户名: admin"
echo "  密码: admin123"
echo ""
echo "按Ctrl+C停止服务"

# 等待中断信号
trap "echo ''; echo '正在停止服务...'; kill $BACKEND_PID $FRONTEND_PID 2>/dev/null; exit" INT
wait

