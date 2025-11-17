# Windows系统运行操作步骤

## 🎯 快速开始（3步启动）

### 第一步：初始化数据库

```cmd
database\import.bat
```

**或者手动操作**：
1. 打开命令提示符（CMD）
2. 执行：
   ```cmd
   mysql -u root -p < database\import.sql
   ```
3. 输入MySQL密码

### 第二步：启动应用

**方法1：一键启动（推荐）**
```cmd
启动应用.bat
```

**方法2：分别启动**
```cmd
启动后端.bat
启动前端.bat
```

### 第三步：访问应用

打开浏览器，访问：
```
http://localhost:8080/frontend/pages/auth/login.html
```

使用以下账号登录：
- 用户名：`admin`
- 密码：`admin123`

---

## 📋 详细操作步骤

### 准备工作

#### 1. 检查环境

运行环境检查：
```cmd
启动检查.bat
```

或手动检查：
```cmd
java -version      # 应该显示Java版本
mvn -version      # 应该显示Maven版本
python --version  # 应该显示Python版本
mysql --version   # 应该显示MySQL版本
```

#### 2. 安装缺失的软件

如果缺少某个软件：

- **Java**：https://www.oracle.com/java/technologies/downloads/
- **Maven**：https://maven.apache.org/download.cgi
- **MySQL**：https://dev.mysql.com/downloads/mysql/
- **Python**：https://www.python.org/downloads/

### 数据库初始化

#### 方法1：使用批处理脚本（最简单）

```cmd
database\import.bat
```

按提示输入MySQL密码即可。

#### 方法2：使用命令行

```cmd
mysql -u root -p < database\import.sql
```

#### 方法3：使用MySQL客户端

1. 打开MySQL Workbench或命令行
2. 执行：
   ```sql
   source D:\cursor_yuzhuapp\database\import.sql;
   ```

#### 验证数据库

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
- admin用户记录

### 启动服务

#### 方式一：一键启动（推荐）

```cmd
启动应用.bat
```

脚本会自动：
1. 检查环境
2. 启动后端（新窗口）
3. 启动前端（新窗口）

**等待提示**：
- 后端窗口显示：`Started YuzhuAppApplication`
- 前端窗口显示：`Serving HTTP on 0.0.0.0 port 8080`

#### 方式二：手动启动

**启动后端**：

1. 打开命令提示符
2. 进入项目目录：
   ```cmd
   cd D:\cursor_yuzhuapp\backend
   ```
3. 启动服务：
   ```cmd
   mvn spring-boot:run
   ```
4. 等待看到：`Started YuzhuAppApplication`
5. **保持窗口打开**

**启动前端**（新开一个命令提示符）：

1. 打开新的命令提示符
2. 进入项目根目录：
   ```cmd
   cd D:\cursor_yuzhuapp
   ```
3. 启动HTTP服务器：
   ```cmd
   python -m http.server 8080
   ```
4. 等待看到：`Serving HTTP on 0.0.0.0 port 8080`
5. **保持窗口打开**

### 访问应用

1. **打开浏览器**（Chrome、Edge、Firefox等）

2. **访问登录页面**：
   ```
   http://localhost:8080/frontend/pages/auth/login.html
   ```

3. **登录**：
   - 用户名：`admin`
   - 密码：`admin123`

4. **成功标志**：
   - 跳转到首页
   - 浏览器控制台（F12）无错误
   - 可以访问各个功能页面

---

## 🔍 验证服务运行状态

### 检查后端服务

```cmd
netstat -ano | findstr :8081
```

如果看到 `LISTENING`，说明后端正在运行。

### 检查前端服务

```cmd
netstat -ano | findstr :8080
```

如果看到 `LISTENING`，说明前端正在运行。

### 测试API

```cmd
curl http://localhost:8081/api/auth/login
```

应该返回JSON响应。

---

## 🛠️ 常见问题快速解决

### 问题1：Java未安装

**解决**：
1. 下载安装JDK 8+
2. 配置JAVA_HOME环境变量
3. 添加到Path：`%JAVA_HOME%\bin`
4. 重新打开CMD验证

### 问题2：Maven未安装

**解决**：
1. 下载解压Maven
2. 配置MAVEN_HOME环境变量
3. 添加到Path：`%MAVEN_HOME%\bin`
4. 重新打开CMD验证

### 问题3：MySQL连接失败

**解决**：
1. 启动MySQL服务：
   ```cmd
   net start MySQL
   ```
2. 检查数据库配置：
   - 文件：`backend\src\main\resources\application.yml`
   - 确认用户名、密码正确
3. 确认数据库已创建：
   ```sql
   SHOW DATABASES;
   ```

### 问题4：端口被占用

**解决**：
```cmd
# 查找占用端口的进程
netstat -ano | findstr :8081

# 结束进程（替换PID）
taskkill /PID <PID> /F
```

### 问题5：登录500错误

**解决**：
1. 检查admin用户是否存在：
   ```sql
   SELECT * FROM users WHERE username = 'admin';
   ```
2. 如果不存在，执行：
   ```sql
   INSERT INTO users (username, password, email, role, nickname, status) VALUES
   ('admin', '$2a$10$N.zmdr9k7uOCQb376NoUnuTJ8iAt6Z5EHsM8lE9lBOsl7iwK8pJwC', 'admin@yuzhuapp.com', 'ROLE_RESEARCHER', '管理员', 1);
   ```

### 问题6：前端页面404

**解决**：
1. 确认HTTP服务器从项目根目录启动
2. 确认访问路径：`http://localhost:8080/frontend/pages/auth/login.html`

---

## 📝 完整操作流程示例

### 第一次运行

```cmd
REM 1. 进入项目目录
cd D:\cursor_yuzhuapp

REM 2. 初始化数据库
database\import.bat

REM 3. 启动应用
启动应用.bat

REM 4. 等待服务启动（约30秒-2分钟）

REM 5. 打开浏览器访问
REM http://localhost:8080/frontend/pages/auth/login.html
```

### 日常使用

```cmd
REM 直接启动即可
启动应用.bat
```

---

## ✅ 成功运行标志

当看到以下情况时，说明应用运行成功：

1. ✅ 后端控制台显示：`Started YuzhuAppApplication`
2. ✅ 前端控制台显示：`Serving HTTP on 0.0.0.0 port 8080`
3. ✅ 浏览器可以访问登录页面
4. ✅ 可以使用admin/admin123成功登录
5. ✅ 登录后可以访问各个功能模块

---

## 🎯 功能测试

登录成功后，测试以下功能：

1. **监测仪表板**
   - 访问：http://localhost:8080/frontend/pages/monitoring/monitoring-dashboard.html
   - 查看设备列表和环境数据

2. **设备控制**
   - 访问：http://localhost:8080/frontend/pages/control/device-control.html
   - 发送控制指令

3. **数据查询**
   - 访问：http://localhost:8080/frontend/pages/data/data-query.html
   - 查询历史数据

4. **知识库**
   - 访问：http://localhost:8080/frontend/pages/knowledge/knowledge-base.html
   - 浏览知识内容

---

## 🛑 停止服务

### 停止后端
- 在后端服务窗口按 `Ctrl + C`
- 或关闭"后端服务"窗口

### 停止前端
- 在前端服务窗口按 `Ctrl + C`
- 或关闭"前端服务"窗口

---

## 📚 更多帮助

- **详细指南**：`docs/WINDOWS_SETUP_GUIDE.md`
- **快速启动**：`QUICK_START.md`
- **故障排除**：`TROUBLESHOOTING.md`
- **测试指南**：`docs/TESTING_GUIDE.md`

---

## 💡 提示

1. **首次运行**可能需要下载Maven依赖，请耐心等待（5-10分钟）

2. **保持服务窗口打开**，关闭窗口会停止服务

3. **清除浏览器缓存**：如果页面异常，按 `Ctrl + F5` 强制刷新

4. **查看日志**：后端控制台会显示详细的运行日志和错误信息

5. **模拟运行**：即使没有真实硬件，应用也可以使用模拟数据运行

祝您使用愉快！🎉

