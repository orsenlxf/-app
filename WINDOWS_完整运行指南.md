# Windows系统完整运行指南

## 📋 目录

1. [前置要求检查](#前置要求检查)
2. [数据库初始化](#数据库初始化)
3. [配置文件修改](#配置文件修改)
4. [启动应用](#启动应用)
5. [访问和测试](#访问和测试)
6. [常见问题解决](#常见问题解决)

---

## 📋 前置要求检查

### 1. 检查必需软件

运行环境检查脚本：
```cmd
启动检查.bat
```

或手动检查：
```cmd
java -version      # 需要Java 8+
mvn -version      # 需要Maven 3.6.1+
python --version  # 需要Python 3.x（用于前端服务器）
mysql --version   # 需要MySQL 8.0+
```

### 2. 安装缺失的软件

如果缺少某个软件，请先安装：

| 软件 | 版本要求 | 下载地址 |
|------|---------|---------|
| Java JDK | 8+ | https://www.oracle.com/java/technologies/downloads/ |
| Maven | 3.6.1+ | https://maven.apache.org/download.cgi |
| MySQL | 8.0+ | https://dev.mysql.com/downloads/mysql/ |
| Python | 3.x | https://www.python.org/downloads/ |

### 3. 配置环境变量

#### Java环境变量

1. 右键"此电脑" → 属性 → 高级系统设置 → 环境变量
2. 新建系统变量：
   - 变量名：`JAVA_HOME`
   - 变量值：`C:\Program Files\Java\jdk1.8.0_xxx`（你的JDK安装路径）
3. 编辑Path变量，添加：`%JAVA_HOME%\bin`
4. 重新打开命令提示符，验证：`java -version`

#### Maven环境变量

1. 下载并解压Maven到某个目录（如：`C:\apache-maven-3.6.3`）
2. 新建系统变量：
   - 变量名：`MAVEN_HOME`
   - 变量值：`C:\apache-maven-3.6.3`（你的Maven解压路径）
3. 编辑Path变量，添加：`%MAVEN_HOME%\bin`
4. 重新打开命令提示符，验证：`mvn -version`

---

## 📋 数据库初始化

### 方法1：使用批处理脚本（推荐）

```cmd
database\import.bat
```

按提示输入MySQL用户名和密码即可。

### 方法2：手动导入

1. **打开命令提示符**

2. **进入项目目录**
   ```cmd
   cd D:\cursor_yuzhuapp
   ```

3. **执行导入命令**
   ```cmd
   mysql -u root -p < database\import.sql
   ```
   输入MySQL密码

### 方法3：使用MySQL客户端

1. 打开MySQL Workbench或命令行
2. 连接到数据库服务器
3. 执行：
   ```sql
   source D:/cursor_yuzhuapp/database/import.sql;
   ```

### 验证数据库

```cmd
mysql -u root -p
```

```sql
USE yuzhuapp;
SHOW TABLES;
SELECT * FROM users WHERE username = 'admin';
```

应该能看到：
- 多个表（users, devices, environment_data等）
- admin用户记录（密码：admin123）

---

## 📋 配置文件修改

### 重要：修改数据库密码

**必须修改** `backend\src\main\resources\application.yml` 中的数据库密码：

```yaml
spring:
  datasource:
    url: jdbc:mysql://localhost:3306/yuzhuapp?useUnicode=true&characterEncoding=utf8&useSSL=false&serverTimezone=Asia/Shanghai
    username: root
    password: 你的MySQL密码  # ⚠️ 修改这里
```

### 可选：修改MQTT配置

如果未安装MQTT Broker，请设置：

```yaml
mqtt:
  enabled: false  # 设置为false禁用MQTT功能
```

如果已安装MQTT Broker，保持 `enabled: true` 并配置连接信息。

---

## 📋 启动应用

### 方法一：一键启动（推荐）

1. **打开命令提示符（CMD）**
   - 按 `Win + R`，输入 `cmd`，按回车

2. **进入项目目录**
   ```cmd
   cd D:\cursor_yuzhuapp
   ```

3. **运行启动脚本**
   ```cmd
   启动应用.bat
   ```

4. **等待服务启动**
   - 脚本会自动检查环境
   - 启动后端服务（新窗口，端口8081）
   - 启动前端服务（新窗口，端口8080）
   - **首次运行可能需要下载Maven依赖，请耐心等待（5-10分钟）**

5. **确认服务启动成功**
   - 后端窗口显示：`Started YuzhuAppApplication`
   - 前端窗口显示：`Serving HTTP on 0.0.0.0 port 8080`

### 方法二：分别启动

#### 启动后端服务

**方式1：使用脚本**
```cmd
启动后端.bat
```

**方式2：手动启动**
```cmd
cd D:\cursor_yuzhuapp\backend
mvn spring-boot:run
```

**等待看到**：`Started YuzhuAppApplication`

#### 启动前端服务（新开一个命令提示符）

**方式1：使用脚本**
```cmd
启动前端.bat
```

**方式2：手动启动**
```cmd
cd D:\cursor_yuzhuapp
python -m http.server 8080
```

**等待看到**：`Serving HTTP on 0.0.0.0 port 8080`

---

## 📋 访问和测试

### 1. 访问应用

打开浏览器（推荐Chrome或Edge），访问：

- **首页**：http://localhost:8080/index.html
- **登录页**：http://localhost:8080/frontend/pages/auth/login.html
- **注册页**：http://localhost:8080/frontend/pages/auth/register.html

### 2. 登录测试

使用默认测试账号登录：

- **用户名**：`admin`
- **密码**：`admin123`

### 3. 功能测试

登录成功后，测试以下功能：

- ✅ **监测仪表板**
  - 访问：http://localhost:8080/frontend/pages/monitoring/monitoring-dashboard.html
  - 查看设备列表和环境数据

- ✅ **设备控制**
  - 访问：http://localhost:8080/frontend/pages/control/device-control.html
  - 发送控制指令

- ✅ **数据查询**
  - 访问：http://localhost:8080/frontend/pages/data/data-query.html
  - 查询历史数据

- ✅ **知识库**
  - 访问：http://localhost:8080/frontend/pages/knowledge/knowledge-base.html
  - 浏览知识内容

- ✅ **实验管理**（仅研究者角色）
  - 访问：http://localhost:8080/frontend/pages/experiment/experiment-list.html
  - 管理实验项目

---

## 📋 常见问题解决

### 问题1：Java未找到

**错误**：`'java' 不是内部或外部命令`

**解决**：
1. 确认已安装JDK 8+
2. 配置JAVA_HOME环境变量
3. 将 `%JAVA_HOME%\bin` 添加到Path
4. 重新打开命令提示符验证

### 问题2：Maven未找到

**错误**：`'mvn' 不是内部或外部命令`

**解决**：
1. 下载并解压Maven 3.6.1+
2. 配置MAVEN_HOME环境变量
3. 将 `%MAVEN_HOME%\bin` 添加到Path
4. 重新打开命令提示符验证

### 问题3：MySQL连接失败

**错误**：`Could not get JDBC Connection`

**解决**：
1. **启动MySQL服务**
   ```cmd
   net start MySQL
   ```
   或查找实际服务名：
   ```cmd
   wmic service where "name like '%mysql%'" get name,state,displayname
   ```
   常见服务名：`MySQL84`、`MySQL80`、`MySQL57`、`MySQL`

2. **检查数据库配置**
   - 打开 `backend\src\main\resources\application.yml`
   - 确认数据库名称、用户名、密码正确

3. **确认数据库已创建**
   ```sql
   SHOW DATABASES;
   ```
   应该能看到 `yuzhuapp` 数据库

### 问题4：端口被占用

**错误**：`Port 8081 is already in use`

**解决**：
```cmd
# 查找占用端口的进程
netstat -ano | findstr :8081

# 结束进程（替换PID为实际进程ID）
taskkill /PID <PID> /F
```

或修改端口：
- 编辑 `backend\src\main\resources\application.yml`
- 修改 `server.port: 8082`（改为其他端口）

### 问题5：前端页面404错误

**错误**：`File not found`

**解决**：
1. 确认HTTP服务器从项目根目录启动
2. 确认访问路径正确：
   - 正确：`http://localhost:8080/frontend/pages/auth/login.html`
   - 错误：`http://localhost:8080/pages/auth/login.html`

### 问题6：登录返回500错误

**解决**：
1. **检查admin用户是否存在**
   ```sql
   SELECT * FROM users WHERE username = 'admin';
   ```

2. **如果不存在，执行**：
   ```sql
   INSERT INTO users (username, password, email, role, nickname, status) VALUES
   ('admin', '$2a$10$N.zmdr9k7uOCQb376NoUnuTJ8iAt6Z5EHsM8lE9lBOsl7iwK8pJwC', 'admin@yuzhuapp.com', 'ROLE_RESEARCHER', '管理员', 1);
   ```

3. **查看后端控制台日志**，查找具体错误信息

### 问题7：MQTT连接失败

**错误**：`无法连接至服务器`

**解决**：
1. 如果不需要MQTT功能，设置 `mqtt.enabled: false`
2. 如果需要MQTT功能：
   - 安装MQTT Broker（如Mosquitto）
   - 启动MQTT服务
   - 配置正确的连接信息

### 问题8：Maven下载依赖慢

**解决**：
1. 配置Maven国内镜像（推荐阿里云）
2. 编辑 `%MAVEN_HOME%\conf\settings.xml`
3. 添加镜像配置：
   ```xml
   <mirrors>
     <mirror>
       <id>aliyun</id>
       <mirrorOf>central</mirrorOf>
       <name>Aliyun Maven</name>
       <url>https://maven.aliyun.com/repository/public</url>
     </mirror>
   </mirrors>
   ```

---

## 📊 服务状态检查

### 检查后端服务

```cmd
netstat -ano | findstr :8081
```

如果看到 `LISTENING`，说明服务正在运行。

### 检查前端服务

```cmd
netstat -ano | findstr :8080
```

如果看到 `LISTENING`，说明服务正在运行。

### 测试API

```cmd
curl http://localhost:8081/api/auth/login
```

应该返回JSON响应（即使是错误响应）。

---

## 🛑 停止服务

### 停止后端服务
- 在后端服务窗口按 `Ctrl + C`
- 或关闭"后端服务"窗口

### 停止前端服务
- 在前端服务窗口按 `Ctrl + C`
- 或关闭"前端服务"窗口

---

## ✅ 成功运行标志

当看到以下情况时，说明应用运行成功：

1. ✅ 后端控制台显示：`Started YuzhuAppApplication`
2. ✅ 前端控制台显示：`Serving HTTP on 0.0.0.0 port 8080`
3. ✅ 浏览器可以访问登录页面
4. ✅ 可以使用admin/admin123成功登录
5. ✅ 登录后可以访问各个功能页面
6. ✅ 浏览器控制台（F12）无错误

---

## 📚 相关文档

- **快速启动**：`QUICK_START.md`
- **详细运行指南**：`docs/RUNNING_GUIDE.md`
- **Windows设置指南**：`docs/WINDOWS_SETUP_GUIDE.md`
- **功能测试指南**：`docs/TESTING_GUIDE.md`
- **故障排除**：`TROUBLESHOOTING.md`
- **数据库初始化**：`docs/DATABASE_INIT_GUIDE.md`

---

## 💡 重要提示

1. **首次运行**可能需要下载Maven依赖，请耐心等待（5-10分钟）

2. **保持服务窗口打开**，关闭窗口会停止服务

3. **修改数据库密码**：必须修改 `application.yml` 中的数据库密码

4. **清除浏览器缓存**：如果页面显示异常，按 `Ctrl + F5` 强制刷新

5. **查看日志**：后端控制台会显示详细的运行日志和错误信息

6. **模拟运行**：即使没有真实硬件设备，应用也可以使用模拟数据运行

7. **MQTT可选**：如果未安装MQTT Broker，设置 `mqtt.enabled: false` 即可

---

## 🎯 快速参考

### 完整启动流程

```cmd
REM 1. 进入项目目录
cd D:\cursor_yuzhuapp

REM 2. 初始化数据库（首次运行）
database\import.bat

REM 3. 修改数据库密码（重要！）
REM 编辑 backend\src\main\resources\application.yml

REM 4. 启动应用
启动应用.bat

REM 5. 等待服务启动（约30秒-2分钟）

REM 6. 访问应用
REM http://localhost:8080/frontend/pages/auth/login.html
```

### 日常使用

```cmd
REM 直接启动即可
启动应用.bat
```

---

祝您使用愉快！🎉

如有问题，请查看相关文档或检查后端控制台日志。

