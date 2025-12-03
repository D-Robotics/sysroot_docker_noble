# pyhbipchal 项目
本项目原生支持在x86_64主机上交叉编译出适用于aarch64平台的 `.so` 模块，将C++的 `libhbipcfhal.so` 库接口转换为Python可调用模块，通过 `pybind11` 实现对底层IPCF HAL接口的封装。

## 功能概述

- 将 C++ 结构体（如 `dev_info_t`, `IPCFHAL_Channel`）封装为 Python 类
- 提供对 `hb_ipcfhal_*` 函数的 Python 调用接口
- 错误码映射、自动初始化/清理通道、数据收发等高级封装

## 先决条件
确保主机环境已安装以下依赖：

```bash
pip3 install pybind11
```

构建或部署到目标系统，还需安装：
```
sudo apt install -y python3 python3-dev python3-pip build-essential libpython3-dev
sudo -H python3 -m pip install pybind11
```

请确保以下依赖被放到了setup.py的依赖路径内：
- 依赖hobot-multimedia包中的libhbipcfhal.so
- 依赖hobot-multimedia-dev包中的hb_ipcfhal_interface.h

## ./build.sh 使用方法

1. **默认行为**：
    - 如果不带参数运行 `./build.sh`，默认执行 `build` 命令。
    - 例如：
      ```bash
      ./build.sh
      ```
      等价于：
      ```bash
      ./build.sh build
      ```

2. **命令列表**：
    - `clean`：清理本地构建产物（如 build/, .so, __pycache__ 等）
    - `build`：在 chroot 环境中构建 Python 扩展模块，并复制到本地 ../debian/usr/local/lib/python3.10/dist-packages/

## 使用示例
确保 Python 程序能访问到生成的 .so 文件
```python
import pyhbipchal as pyipc

# 初始化一个通道
channel = pyipc.IPCFHAL_Channel()
print(channel.id)

# 获取库版本
version_info = pyipc.get_version()
print("Version:", version_info)
```

## 文件结构说明

| 文件 | 描述 |
|------|------|
| `bindings.cpp` | 主要绑定逻辑，使用 `pybind11` 将 C++ 接口封装为 Python 模块 |
| `pyhbipchal_utils.py` | 提供更高级封装的 Python 工具类 [IPCChannel](pyhbipchal_utils.py#L5-L64)，支持通道管理、错误处理和数据收发 |
| `build.sh` | 构建脚本，支持`clean`，`build`命令和`install`命令，在 chroot 环境中编译 Python 扩展模块 |
| `setup.py` | Python 扩展模块构建配置文件，定义了模块名称、依赖库（如 `libhbipcfhal.so`）、头文件路径等信息 |
