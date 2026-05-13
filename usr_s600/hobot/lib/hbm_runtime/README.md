# hbm_runtime

hbm_runtime 是一个统一的推理执行接口，支持在 BPU 上加载和执行量化后的模型。本项目提供 Python 接口（通过 pybind11 绑定），便于在多种开发环境中使用。

## 环境要求
本项目基于 Python 编写并依赖多个第三方库。请确保您的环境满足以下要求：

### Python 环境
  Python 版本：建议使用 Python 3.10.x（当前已在 3.10.12 下测试通过）

### python依赖库

| 组件                   | 版本要求       |
| --------------------- | -------------- |
| **CMake**             | ≥ 3.22.1       |
| **pybind11**          | ≥ 3.0.0        |
| **scikit-build-core** | ≥ 0.11.5       |
| **build**             | ≥ 1.2.2.post1  |
| **wheel**             | ≥ 0.37.1       |

#### 安装依赖

```bash
# 系统依赖
sudo apt update

# Python 构建依赖
pip install build scikit-build-core pybind11 wheel
```

### 动态库依赖
| 库名          | 来源路径           | 说明                     |
| ------------- | ----------------- | ------------------------ |
| `libhbucp.so` | `/usr/hobot/lib/` | UCP 通信库，芯片间通信接口 |
| `libdnn.so`   | `/usr/hobot/lib/` | DNN 推理引擎运行库        |


## 项目结构说明

```bash
.
├── CMakeLists.txt                # CMake 构建配置文件
├── README.md                     # 项目说明文档（当前文件）
├── build.sh                      # 一键构建脚本
├── build_wheels_all_py.sh        # 多 Python 版本 wheel 构建与修复脚本
├── hbm_runtime                   # Python 接口目录
│   ├── HB_HBMRuntime.pyi         # Python 类型提示文件
│   ├── __init__.py               # Python 包入口
│   └── py.typed                  # PEP 561 标记，声明类型完整性
├── include                       # C++ 头文件
│   ├── HB_HBMRuntime.hpp
│   └── HB_RuntimeUtils.hpp
├── pyproject.toml                # Python 打包配置文件
└── src                           # C++ 源码目录
    ├── HBMRuntimeBinding.cc      # pybind11 绑定代码
    ├── HB_HBMRuntime.cc
    └── HB_RuntimeUtils.cc
```

## build.sh 介绍
  本项目提供了统一的构建脚本 build.sh，用于快速完成构建、安装和清理操作。

### 构建 wheel 包
```bash
./build.sh build
```
等价于执行 python -m build --wheel
输出文件将生成在 dist/ 目录下，文件名形如：HB_HBMRuntime-<version>-py3-none-any.whl

### 安装 Python 包
```bash
./build.sh install
```
使用 pip install 安装当前目录下的包（包括 C++ 扩展模块），无需重新构建。

### 清理构建缓存
```bash
./build.sh clean
```
删除 build/、dist/、*.egg-info/、_skbuild/ 等中间构建产物。

### 默认行为
若不传入参数，则默认为 build：
```bash
./build.sh
```
等价于：

```
./build.sh build
```

---

## build_wheels_all_py.sh

在 **Python 3.8 ~ 3.13** 下用 conda 环境分别构建 wheel，再在 py3.12 中用 auditwheel 统一修复，输出到 `wheel_out/`。适用于需要为多版本 Python 提供预编译包的场景（如 CI 或发布）。

- **多版本构建**：在 py3.8~py3.13 六个 conda 环境中各执行一次 `python -m build --wheel`，生成的 wheel 暂存到 `_raw_wheels/`。
- **统一修复**：在 py3.12 中对上述 wheel 执行 `auditwheel repair`，排除脚本内指定的系统/第三方 .so（如 libdnn.so、libbpu.so.2 等），结果输出到 `wheel_out/`。
- **环境自举**：未检测到 conda 时会自动安装 Miniconda（Linux aarch64），缺少对应 Python 版本环境时会自动创建。

### 使用说明

**运行构建（默认）**

```bash
./build_wheels_all_py.sh
# 或
./build_wheels_all_py.sh run
```

执行完整流程后，修复后的 wheel 在 `wheel_out/`。

**仅清理**

```bash
./build_wheels_all_py.sh clean
```

删除 `build/`、`_raw_wheels/`、`dist/`、`wheel_out/` 等目录，不进行构建。

**可选环境变量**

- `OUT_DIR`：修复后 wheel 的输出目录，默认 `wheel_out/`。
- `MINICONDA_DIR`：Miniconda 安装路径，默认 `$HOME/miniconda3`。

**说明**：脚本默认使用 Linux aarch64 版 Miniconda；x86_64 等需自行修改脚本中的 `MINICONDA_URL`。修复阶段排除的 .so 需在目标机器上另行安装。
