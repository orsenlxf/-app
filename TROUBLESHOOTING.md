# 常见问题解决指南

## 问题：cd backend 系统找不到指定路径

### 原因分析

1. **当前不在项目根目录**
   - 确保在 `D:\cursor_yuzhuapp` 目录下执行命令

2. **路径问题**
   - Windows路径分隔符问题
   - 目录名称拼写错误

### 解决方案

#### 方法一：确认当前目录

```bash
# 查看当前目录
cd

# 应该显示: D:\cursor_yuzhuapp
# 如果不是，请先切换到项目根目录
cd D:\cursor_yuzhuapp
```

#### 方法二：使用绝对路径

```bash
# 直接切换到backend目录
cd D:\cursor_yuzhuapp\backend

# 或者
cd /d D:\cursor_yuzhuapp\backend
```

#### 方法三：使用相对路径（从项目根目录）

```bash
# 确保在项目根目录
cd D:\cursor_yuzhuapp

# 然后切换
cd backend
```

#### 方法四：使用backend目录下的启动脚本

```bash
# 在backend目录下有一个start.bat
cd D:\cursor_yuzhuapp\backend
start.bat
```

### 验证目录是否正确

```bash
# 检查是否在backend目录
dir

# 应该看到:
# - pom.xml
# - src/
# - target/
```

### 完整启动流程

#### 方式1：从项目根目录启动

```bash
# 1. 进入项目根目录
cd D:\cursor_yuzhuapp

# 2. 进入backend目录
cd backend

# 3. 启动服务
mvn spring-boot:run
```

#### 方式2：使用绝对路径

```bash
# 直接进入backend并启动
cd /d D:\cursor_yuzhuapp\backend && mvn spring-boot:run
```

#### 方式3：使用启动脚本

```bash
# 从项目根目录
cd D:\cursor_yuzhuapp
start.bat

# 或者直接进入backend目录
cd D:\cursor_yuzhuapp\backend
start.bat
```

## 其他常见问题

### 问题：找不到pom.xml

**原因**: 不在backend目录下

**解决**:
```bash
# 确认当前位置
cd
# 应该显示: D:\cursor_yuzhuapp\backend

# 如果不在，切换过去
cd D:\cursor_yuzhuapp\backend
```

### 问题：Maven命令找不到

**原因**: Maven未安装或未配置环境变量

**解决**:
1. 安装Maven
2. 配置MAVEN_HOME环境变量
3. 将%MAVEN_HOME%\bin添加到PATH

### 问题：Java命令找不到

**原因**: JDK未安装或未配置环境变量

**解决**:
1. 安装JDK 11+
2. 配置JAVA_HOME环境变量
3. 将%JAVA_HOME%\bin添加到PATH

### 问题：端口被占用

**错误**: `Port 8081 is already in use`

**解决**:
```bash
# 查找占用端口的进程
netstat -ano | findstr :8081

# 结束进程（替换PID为实际进程ID）
taskkill /PID <PID> /F

# 或修改端口: backend/src/main/resources/application.yml
server:
  port: 8082  # 改为其他端口
```

### 问题：数据库连接失败

**错误**: `Access denied` 或 `Connection refused`

**解决**:
1. 检查MySQL服务是否启动
2. 检查用户名密码是否正确
3. 检查数据库是否已创建
4. 修改 `backend/src/main/resources/application.yml` 中的数据库配置

## 快速检查清单

在启动前，请确认：

- [ ] 当前在正确的目录（项目根目录或backend目录）
- [ ] Java已安装并配置环境变量
- [ ] Maven已安装并配置环境变量
- [ ] MySQL服务已启动
- [ ] 数据库已创建并导入数据
- [ ] 配置文件已修改（数据库连接信息）

## 获取帮助

如果问题仍未解决：

1. 查看详细运行指南: `docs/RUNNING_GUIDE.md`
2. 查看快速启动指南: `QUICK_START.md`
3. 检查错误日志: `backend/logs/yuzhuapp.log`

