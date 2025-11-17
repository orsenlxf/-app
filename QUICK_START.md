# 快速启动指南

## 一、前置条件检查

在启动前，请确保已安装：

- ✅ **JDK 8+** - 运行后端（已配置为Java 8）
- ✅ **Maven 3.6.1+** - 构建后端（最低3.6.1，推荐3.6.3+）
- ✅ **MySQL 8.0+** - 数据库
- ✅ **Python 3** 或 **Node.js** - 运行前端（可选）

## 二、一键启动（推荐）

### Windows用户
```bash
# 双击运行或在命令行执行
start.bat
```

### Linux/Mac用户
```bash
# 添加执行权限（首次）
chmod +x start.sh

# 运行启动脚本
./start.sh
```

## 三、手动启动步骤

### 步骤1: 初始化数据库

```bash
# 登录MySQL
mysql -u root -p

# 执行数据库脚本
source database/schema.sql
```

### 步骤2: 配置数据库连接

编辑 `backend/src/main/resources/application.yml`:
```yaml
spring:
  datasource:
    username: root      # 你的MySQL用户名
    password: root      # 你的MySQL密码
```

### 步骤3: 启动后端

**重要**: 确保在项目根目录下执行

```bash
# 方式1: 分步执行
cd backend
mvn spring-boot:run

# 方式2: 一行命令（从项目根目录）
cd backend && mvn spring-boot:run

# 方式3: 使用绝对路径
cd /d D:\cursor_yuzhuapp\backend && mvn spring-boot:run

# 方式4: 使用backend目录下的启动脚本
cd backend
start.bat
```

**如果提示"系统找不到指定路径"**:
- 确认当前在项目根目录: `cd` 应该显示 `D:\cursor_yuzhuapp`
- 使用绝对路径: `cd /d D:\cursor_yuzhuapp\backend`
- 查看 `TROUBLESHOOTING.md` 获取更多帮助

等待看到: `Started YuzhuAppApplication`

### 步骤4: 启动前端（新终端）

```bash
cd frontend
python -m http.server 8080
```

### 步骤5: 访问应用

打开浏览器访问: **http://localhost:8080**

## 四、测试登录

使用默认测试账号：
- **用户名**: `admin`
- **密码**: `admin123`

> 注意：首次运行需要先执行数据库脚本创建用户

## 五、常见问题

### 端口被占用？
- 后端默认端口: 8081
- 前端默认端口: 8080
- 可在配置文件中修改

### 数据库连接失败？
- 检查MySQL服务是否启动
- 检查用户名密码是否正确
- 检查数据库是否已创建

### 前端无法访问后端？
- 检查后端服务是否启动
- 检查API地址配置是否正确
- 检查CORS配置

## 六、项目结构

```
yuzhuapp/
├── frontend/          # 前端代码
├── backend/           # 后端代码
├── database/          # 数据库脚本
├── docs/              # 文档
├── start.bat          # Windows启动脚本
└── start.sh           # Linux/Mac启动脚本
```

## 七、详细文档

更多详细信息请查看: `docs/RUNNING_GUIDE.md`

