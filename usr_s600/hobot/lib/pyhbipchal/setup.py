from setuptools import setup, Extension
import pybind11

ext_modules = [
    Extension(
        "pyhbipchal",
        sources=["bindings.cpp"],
        include_dirs=[pybind11.get_include(), "/usr/hobot/include/"],
        libraries=["hbipcfhal"],  # 链接 libhbipcfhal.so 库
        library_dirs=["/usr/hobot/lib/"],
        language="c++",
    ),
]

setup(
    name="pyhbipchal",
    version="0.0.1",
    author="d-robot",
    author_email="drobot@d-robotics.cc",
    description="Bindings for hb_ipcfhal library",
    ext_modules=ext_modules,
)
