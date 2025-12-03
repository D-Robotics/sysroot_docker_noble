#include <pybind11/pybind11.h>
#include <pybind11/stl.h>
#include "hb_ipcfhal_interface.h"
#include "ipcf_hal_errno.h"
#include <cstring>

namespace py = pybind11;

// 绑定 dev_info_t 结构体
void bind_dev_info_t(py::module &m)
{
    py::class_<dev_info_t>(m, "dev_info_t")
        .def(py::init<>())
        .def_readwrite("fd", &dev_info_t::fd)
        .def_readwrite("users", &dev_info_t::users)
        .def("get_dev_path", [](const dev_info_t &self)
             { return std::string(self.dev_path); })
        .def("set_dev_path", [](dev_info_t &self, const std::string &value)
             {
            std::strncpy(self.dev_path, value.c_str(), sizeof(self.dev_path) - 1);
            self.dev_path[sizeof(self.dev_path) - 1] = '\0'; })
        .def("get_dev_name", [](const dev_info_t &self)
             { return std::string(self.dev_name); })
        .def("set_dev_name", [](dev_info_t &self, const std::string &value)
             {
            std::strncpy(self.dev_name, value.c_str(), sizeof(self.dev_name) - 1);
            self.dev_name[sizeof(self.dev_name) - 1] = '\0'; })
        .def_readwrite("vaild_state", &dev_info_t::vaild_state);
}

// 绑定 hal_info_t 结构体
void bind_hal_info_t(py::module &m)
{
    py::class_<hal_info_t>(m, "hal_info_t")
        .def(py::init<>())
        .def_readwrite("init_state", &hal_info_t::init_state)
        .def_readwrite("vaild_state", &hal_info_t::vaild_state)
        .def_readwrite("pkg_size_max", &hal_info_t::pkg_size_max);
}

// 绑定 IPCFHAL_Channel 结构体
void bind_IPCFHAL_Channel(py::module &m)
{
    py::class_<IPCFHAL_Channel>(m, "IPCFHAL_Channel")
        .def(py::init<>())
        .def_readwrite("id", &IPCFHAL_Channel::id)
        .def("get_name", [](const IPCFHAL_Channel &self)
             { return std::string(self.name); })
        .def("set_name", [](IPCFHAL_Channel &self, const std::string &value)
             {
            std::strncpy(self.name, value.c_str(), sizeof(self.name) - 1);
            self.name[sizeof(self.name) - 1] = '\0'; })
        .def_readwrite("fifo_size", &IPCFHAL_Channel::fifo_size)
        .def_readwrite("fifo_type", &IPCFHAL_Channel::fifo_type)
        .def_readwrite("ipcf_dev", &IPCFHAL_Channel::ipcf_dev)
        .def_readwrite("ipcf_hal", &IPCFHAL_Channel::ipcf_hal);
}

// 定义 th_arg_t 结构体
struct th_arg_t
{
    IPCFHAL_Channel ch;  /**< ipcfhal channel */
    bool Is_Enable;      /**< thread status */
    uint32_t data_len;   /**< send data length */
    uint32_t sleep_time; /**< send period */
    bool result;         /**< thread running result */
};
// 绑定 th_arg_t 结构体
void bind_th_arg_t(py::module &m)
{
    py::class_<th_arg_t>(m, "th_arg_t")
        .def(py::init<>())
        .def_readwrite("ch", &th_arg_t::ch)
        .def_readwrite("Is_Enable", &th_arg_t::Is_Enable)
        .def_readwrite("data_len", &th_arg_t::data_len)
        .def_readwrite("sleep_time", &th_arg_t::sleep_time)
        .def_readwrite("result", &th_arg_t::result);
}

// 自定义包装函数处理 char** 参数
std::string hb_ipcfhal_trans_err_wrapper(int32_t err_code)
{
    char *err_c_str = nullptr;
    int32_t result = hb_ipcfhal_trans_err(err_code, &err_c_str);

    if (result != IPCF_HAL_E_OK) {
        // 如果转换失败，抛出 Python 异常
        throw std::runtime_error("Failed to translate error code");
    }

    if (err_c_str == nullptr) {
        return "Unknown error";  // 默认错误信息
    }

    return std::string(err_c_str);
}

// 包装 hb_ipcfhal_send 函数
int hb_ipcfhal_send_wrapper(py::object data, int length, IPCFHAL_Channel channel)
{
    const char *data_ptr = nullptr;
    if (py::isinstance<py::bytes>(data))
    {
        data_ptr = PyBytes_AsString(data.ptr());
    }
    else if (py::isinstance<py::bytearray>(data))
    {
        data_ptr = PyByteArray_AsString(data.ptr());
    }
    else
    {
        throw std::invalid_argument("Argument 1 must be bytes or bytearray");
    }
    return hb_ipcfhal_send(reinterpret_cast<const uint8_t *>(data_ptr), length, &channel);
}

// 包装 hb_ipcfhal_recv 函数，支持 bytearray
int hb_ipcfhal_recv_wrapper(py::object data, int length, int timeout, IPCFHAL_Channel channel)
{
    const char *data_ptr = nullptr;
    if (py::isinstance<py::bytes>(data))
    {
        data_ptr = PyBytes_AsString(data.ptr());
    }
    else if (py::isinstance<py::bytearray>(data))
    {
        data_ptr = PyByteArray_AsString(data.ptr());
    }
    else
    {
        throw std::invalid_argument("Argument 1 must be bytes or bytearray");
    }
    // 这里需要确保 data 是可写的，才能去掉 const 限定符
    // 如果 data 本身是只读的，应该先复制一份再转换
    char *writable_data_ptr = const_cast<char *>(data_ptr);
    return hb_ipcfhal_recv(reinterpret_cast<uint8_t *>(writable_data_ptr), length, timeout, &channel);
}

std::tuple<int32_t, uint32_t, uint32_t, uint32_t> get_version() {
    uint32_t major, minor, patch;
    int32_t ret = hb_ipcfhal_get_version(&major, &minor, &patch);
    return std::make_tuple(ret, major, minor, patch);
}

// 绑定所有函数
void bind_functions(py::module &m)
{
    m.def("hb_ipcfhal_init", &hb_ipcfhal_init);
    m.def("hb_ipcfhal_getchan_byjson", &hb_ipcfhal_getchan_byjson);
    m.def("hb_ipcfhal_config", &hb_ipcfhal_config);
    m.def("hb_ipcfhal_send", &hb_ipcfhal_send_wrapper);
    m.def("hb_ipcfhal_recv", &hb_ipcfhal_recv_wrapper);
    m.def("hb_ipcfhal_deinit", &hb_ipcfhal_deinit);
    m.def("hb_ipcfhal_trans_err", &hb_ipcfhal_trans_err_wrapper,
        py::call_guard<py::gil_scoped_release>(),
        "Convert error codes into descriptive strings",
        py::arg("err_code"));
    m.def("get_version", &get_version,
        "Retrieve library version information",
        py::call_guard<py::gil_scoped_release>());
    m.def("HorizonHal_IPCF_Init", &HorizonHal_IPCF_Init);
    m.def("HorizonHal_IPCF_GetChannelbyJson", &HorizonHal_IPCF_GetChannelbyJson);
    m.def("HorizonHal_IPCF_Config", &HorizonHal_IPCF_Config);
    m.def("HorizonHal_IPCF_Send", &HorizonHal_IPCF_Send);
    m.def("HorizonHal_IPCF_Recv", &HorizonHal_IPCF_Recv);
    m.def("HorizonHal_IPCF_Deinit", &HorizonHal_IPCF_Deinit);
}

// 绑定宏定义
void bind_macros(py::module &m)
{
    m.attr("IPCF_HAL_E_OK") = IPCF_HAL_E_OK;
    m.attr("IPCF_HAL_E_NOK") = IPCF_HAL_E_NOK;
    m.attr("IPCF_HAL_E_CONFIG_FAIL") = IPCF_HAL_E_CONFIG_FAIL;
    m.attr("IPCF_HAL_E_WRONG_CONFIGURATION") = IPCF_HAL_E_WRONG_CONFIGURATION;
    m.attr("IPCF_HAL_E_NULL_POINTER") = IPCF_HAL_E_NULL_POINTER;
    m.attr("IPCF_HAL_E_PARAM_INVALID") = IPCF_HAL_E_PARAM_INVALID;
    m.attr("IPCF_HAL_E_LENGTH_TOO_SMALL") = IPCF_HAL_E_LENGTH_TOO_SMALL;
    m.attr("IPCF_HAL_E_INIT_FAILED") = IPCF_HAL_E_INIT_FAILED;
    m.attr("IPCF_HAL_E_UNINIT") = IPCF_HAL_E_UNINIT;
    m.attr("IPCF_HAL_E_BUFFER_OVERFLOW") = IPCF_HAL_E_BUFFER_OVERFLOW;
    m.attr("IPCF_HAL_E_ALLOC_FAIL") = IPCF_HAL_E_ALLOC_FAIL;
    m.attr("IPCF_HAL_E_TIMEOUT") = IPCF_HAL_E_TIMEOUT;
    m.attr("IPCF_HAL_E_REINIT") = IPCF_HAL_E_REINIT;
    m.attr("IPCF_HAL_E_BUSY") = IPCF_HAL_E_BUSY;
    m.attr("IPCF_HAL_E_CHANNEL_INVALID") = IPCF_HAL_E_CHANNEL_INVALID;
}

PYBIND11_MODULE(pyhbipchal, m)
{
    m.doc() = "Bindings for hb_ipcfhal library";

    bind_dev_info_t(m);
    bind_hal_info_t(m);
    bind_IPCFHAL_Channel(m);
    bind_th_arg_t(m);
    bind_functions(m);
    bind_macros(m);
}