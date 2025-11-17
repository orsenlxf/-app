# 快速修复登录500错误

## 问题
登录时返回500错误，可能的原因：
1. 浏览器缓存了旧的JavaScript文件（包含`process`错误）
2. 数据库中的admin用户不存在或密码错误
3. 后端服务异常

## 解决步骤

### 步骤1：清除浏览器缓存并强制刷新

1. 按 `Ctrl + Shift + Delete` 打开清除浏览数据
2. 选择"缓存的图片和文件"
3. 点击"清除数据"
4. 或者按 `Ctrl + F5` 强制刷新页面

### 步骤2：验证数据库中的admin用户

打开MySQL命令行或客户端，执行：

```sql
USE yuzhuapp;
SELECT * FROM users WHERE username = 'admin';
```

**如果查询结果为空**，执行以下SQL创建admin用户：

```sql
INSERT INTO users (username, password, email, role, nickname, status) VALUES
('admin', '$2a$10$N.zmdr9k7uOCQb376NoUnuTJ8iAt6Z5EHsM8lE9lBOsl7iwK8pJwC', 'admin@yuzhuapp.com', 'ROLE_RESEARCHER', '管理员', 1);
```

或者运行测试脚本：
```bash
mysql -u root -p < database/test_admin.sql
```

### 步骤3：检查后端服务

1. 确认后端服务正在运行（端口8081）
2. 查看后端控制台输出，查找错误信息
3. 如果看到数据库连接错误，检查MySQL服务是否启动

### 步骤4：测试登录

1. 访问：`http://localhost:8080/frontend/pages/auth/login.html`
2. 使用以下账号：
   - 用户名：`admin`
   - 密码：`admin123`
3. 打开浏览器开发者工具（F12），查看：
   - Console标签：确认没有`process is not defined`错误
   - Network标签：查看登录请求的响应

## 如果仍然失败

### 查看详细错误信息

1. **浏览器Network标签**：
   - 找到`/auth/login`请求
   - 查看Response标签，查看服务器返回的错误信息

2. **后端控制台**：
   - 查看完整的错误堆栈
   - 查找`SQLException`、`NullPointerException`等错误

3. **数据库连接测试**：
   ```sql
   -- 测试数据库连接
   SHOW DATABASES;
   USE yuzhuapp;
   SHOW TABLES;
   ```

## 常见错误及解决方案

### 错误：`process is not defined`
**原因**：浏览器缓存了旧文件
**解决**：清除浏览器缓存并强制刷新（Ctrl+F5）

### 错误：`Could not get JDBC Connection`
**原因**：MySQL服务未启动或连接配置错误
**解决**：
1. 启动MySQL服务：`net start MySQL` 或通过服务管理器启动
2. 检查`backend/src/main/resources/application.yml`中的数据库配置

### 错误：`User not found` 或密码错误
**原因**：admin用户不存在或密码未正确加密
**解决**：运行上面的SQL插入admin用户

### 错误：`JWT signature does not match`
**原因**：JWT配置问题
**解决**：检查`application.yml`中的`jwt.secret`配置

## 验证修复

修复后，应该能够：
1. 页面加载无JavaScript错误
2. 登录请求返回200状态码
3. 成功跳转到首页
4. localStorage中保存了token和user信息

