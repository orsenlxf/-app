# 快速修复指南

## 问题1：MQTT连接错误

### 快速解决（推荐）
编辑 `backend/src/main/resources/application.yml`:
```yaml
mqtt:
  enabled: false  # 禁用MQTT
```

### 如果需要MQTT功能
1. 启动Mosquitto（见下方）
2. 设置 `mqtt.enabled: true`
3. 重启后端

## 问题2：net start mosquitto 拒绝访问

### 解决方案

#### 方法一：以管理员身份运行（如果Mosquitto已安装为服务）
1. 右键点击"命令提示符"
2. 选择"以管理员身份运行"
3. 执行: `net start mosquitto`

#### 方法二：手动启动（推荐，无需管理员权限）
```bash
"D:\mosquitto_xiazai\mosquitto\mosquitto.exe" -c "D:\mosquitto_xiazai\mosquitto\mosquitto.conf"
```

#### 方法三：使用启动脚本
```bash
# 从项目根目录运行
启动MQTT.bat
```

## 问题3：找不到jar文件

### 解决方案
使用Maven直接运行（无需打包）：
```bash
cd backend
mvn spring-boot:run
```

或使用启动脚本：
```bash
启动后端.bat
```

## 问题4：Java版本错误

### 解决方案
已修改pom.xml支持Java 8，直接运行即可。

## 快速启动流程

### 最简单的方式（不需要MQTT）

1. **确保MQTT已禁用**
   - 检查 `backend/src/main/resources/application.yml`
   - `mqtt.enabled: false`

2. **启动后端**
   ```bash
   启动后端.bat
   ```

3. **启动前端**（新开窗口）
   ```bash
   启动前端.bat
   ```

4. **访问应用**
   - 打开浏览器: http://localhost:8080

### 如果需要MQTT功能

1. **启动MQTT**
   ```bash
   启动MQTT.bat
   ```

2. **启用MQTT配置**
   - 编辑 `backend/src/main/resources/application.yml`
   - 设置 `mqtt.enabled: true`

3. **重启后端**
   ```bash
   启动后端.bat
   ```

## 验证服务状态

### 检查后端
```bash
# 访问健康检查
curl http://localhost:8081/api/auth/login
```

### 检查前端
```bash
# 打开浏览器
http://localhost:8080
```

### 检查MQTT
```bash
# 检查端口
netstat -an | findstr 1883
```

## 需要帮助？

- 查看详细文档: `docs/RUNNING_GUIDE.md`
- 查看MQTT配置: `docs/MQTT_SETUP.md`
- 查看问题排查: `TROUBLESHOOTING.md`
