# 远程调控玉竹育种APP

## 项目简介

远程调控玉竹育种APP是一款面向玉竹爱好者和科研人员的智能化管理平台，实现玉竹育种全流程的远程监测、精准调控、数据管理与知识共享。

### 核心功能

- **远程监测**: 实时采集环境参数，通过高清摄像头查看玉竹长势，智能分析生长状态
- **远程调控**: 远程操控灌溉、补光、温控、施肥等设备，支持手动操作和定时任务
- **数据管理**: 云端存储所有数据，支持多维度查询分析，图表可视化展示
- **知识库**: 涵盖养护指南、品种资源、经验交流社区
- **实验管理**: 研究者专属功能，支持实验项目管理和对比分析

### 技术栈

#### 前端
- HTML5 + JavaScript (ES6+)
- Bootstrap 5.x
- Chart.js / ECharts
- Axios
- MQTT.js

#### 后端
- Spring Boot / Spring MVC
- Spring Security (JWT认证)
- MyBatis / JPA
- MySQL 8.0+
- MQTT (Eclipse Mosquitto / EMQ X)

## 项目结构

```
yuzhuapp/
├── frontend/          # 前端代码
├── backend/           # 后端代码
├── database/          # 数据库脚本
├── docs/              # 项目文档
├── prototype/         # 项目规范文档
├── tests/              # 测试文件
├── index.html         # 前端入口文件
└── README.md          # 项目说明
```

## 快速开始

### 环境要求

- Node.js 16+ (前端)
- Java 11+ (后端)
- MySQL 8.0+ (数据库)
- Maven 3.6.1+ (构建工具，最低要求3.6.1，推荐3.6.3+)

### 安装步骤

#### 1. 克隆项目
```bash
git clone <repository-url>
cd yuzhuapp
```

#### 2. 前端设置
```bash
cd frontend
npm install
npm run dev
```

#### 3. 后端设置
```bash
cd backend
mvn clean install
mvn spring-boot:run
```

#### 4. 数据库设置
```bash
# 创建数据库
mysql -u root -p
CREATE DATABASE yuzhuapp;

# 导入表结构
mysql -u root -p yuzhuapp < database/schema.sql
```

#### 5. 配置文件
- 前端: 修改 `frontend/config/api.config.js`
- 后端: 修改 `backend/src/main/resources/application.yml`

### 访问应用

- 前端: http://localhost:8080
- 后端API: http://localhost:8081/api

## 开发规范

项目开发遵循以下规范文档：

- [UI设计规范](prototype/ui-standards.md)
- [编码规范](prototype/coding-standards.md)
- [项目目录结构规范](prototype/project-structure.md)
- [技术栈规范](prototype/tech-stack.md)
- [项目开发流程规范](prototype/development-workflow.md)

## 功能模块

### 1. 远程监测模块
- 环境参数实时采集（土壤温湿度、酸碱度、空气温湿度、光照强度等）
- 生长状态可视化（图像识别分析株高、叶面积、叶绿素含量）
- 异常预警提醒（参数阈值设置，多渠道提醒）

### 2. 远程调控模块
- 智能设备控制（灌溉、补光、温控、施肥设备）
- 定制化调控方案（基础模板、自定义参数、批量应用）
- 调控记录追溯（完整操作日志）

### 3. 数据管理模块
- 数据存储与查询（按时间、类型、区域等条件查询）
- 数据分析与可视化（图表展示、趋势分析）
- 实验项目管理（实验组与对照组，对比分析报告）

### 4. 育种知识库模块
- 基础养护指南
- 品种资源管理
- 经验交流社区

### 5. 权限与安全模块
- 角色权限划分（爱好者/研究者）
- 数据安全保障（加密存储、操作日志）

## 性能要求

- 首页加载: ≤3秒
- 远程操控响应: ≤5秒
- 数据查询: ≤2秒
- 设备连接: ≥10台同时连接
- 数据传输成功率: ≥99.5%

## 浏览器支持

- Chrome (最新版)
- Firefox (最新版)
- Safari (最新版)
- Edge (最新版)
- 移动端浏览器 (Android 8.0+, iOS 12.0+)

## 贡献指南

1. Fork 项目
2. 创建功能分支 (`git checkout -b feature/AmazingFeature`)
3. 提交更改 (`git commit -m 'Add some AmazingFeature'`)
4. 推送到分支 (`git push origin feature/AmazingFeature`)
5. 创建 Pull Request

## 许可证

本项目采用 MIT 许可证 - 查看 [LICENSE](LICENSE) 文件了解详情

## 联系方式

- 邮箱: 3415379287@qq.com
- 电话: 18890222714

## 更新日志

查看 [CHANGELOG.md](CHANGELOG.md) 了解版本更新历史


