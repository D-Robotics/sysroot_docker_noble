// Copyright (c) 2025 D-Robotics Co,.Ltd. All Rights Reserved.
//
// The material in this file is confidential and contains trade secrets
// of D-Robotics Co,.Ltd. This is proprietary information owned by
// D-Robotics Co,.Ltd. No part of this work may be disclosed,
// reproduced, copied, transmitted, or used in any way for any purpose,
// without the express written permission of D-Robotics Co,.Ltd.

#include <pybind11/pybind11.h>
#include <pybind11/numpy.h>
#include <pybind11/stl.h>
#include <pybind11/stl_bind.h>

#include "HB_HBMRuntime.hpp"

namespace py = pybind11;

/**
 * @brief Python binding for HB_HBMRuntime module
 *
 * Exposes enums, quantization parameters, and the main HB_HBMRuntime class.
 */
PYBIND11_MODULE(HB_HBMRuntime, m) {
    m.doc() = "Pybind11 binding for HB_HBMRuntime class";

    // Bind enum: tensor data type
    py::enum_<hbDNNDataType>(m, "hbDNNDataType")
        .value("S4",    HB_DNN_TENSOR_TYPE_S4)
        .value("U4",    HB_DNN_TENSOR_TYPE_U4)
        .value("S8",    HB_DNN_TENSOR_TYPE_S8)
        .value("U8",    HB_DNN_TENSOR_TYPE_U8)
        .value("F16",   HB_DNN_TENSOR_TYPE_F16)
        .value("S16",   HB_DNN_TENSOR_TYPE_S16)
        .value("U16",   HB_DNN_TENSOR_TYPE_U16)
        .value("F32",   HB_DNN_TENSOR_TYPE_F32)
        .value("S32",   HB_DNN_TENSOR_TYPE_S32)
        .value("U32",   HB_DNN_TENSOR_TYPE_U32)
        .value("F64",   HB_DNN_TENSOR_TYPE_F64)
        .value("S64",   HB_DNN_TENSOR_TYPE_S64)
        .value("U64",   HB_DNN_TENSOR_TYPE_U64)
        .value("BOOL8", HB_DNN_TENSOR_TYPE_BOOL8)
        .value("MAX",   HB_DNN_TENSOR_TYPE_MAX);

    // Bind enum: quantization type
    py::enum_<hbDNNQuantiType>(m, "hbDNNQuantiType")
        .value("NONE", hbDNNQuantiType::NONE)
        .value("SCALE", hbDNNQuantiType::SCALE);

    // Bind class: quantization parameters
    py::class_<QuantParams>(m, "QuantParams")
        .def_property_readonly("scale", [](const QuantParams& q) {
            return py::array(q.scale.size(), q.scale.data());
        })
        .def_property_readonly("zero_point", [](const QuantParams& q) {
            return py::array(q.zero_point.size(), q.zero_point.data());
        })
        .def_readonly("quant_type", &QuantParams::quant_type)
        .def_readonly("axis", &QuantParams::axis);


    // Bind class: model-level scheduling parameters
    py::class_<SchedParam>(m, "SchedParam")
        .def(py::init<>())
        .def_readwrite("priority", &SchedParam::priority)
        .def_readwrite("customId", &SchedParam::customId)
        .def_readwrite("bpu_cores", &SchedParam::bpu_cores)
        .def_readwrite("deviceId", &SchedParam::deviceId);

    // Bind class: HB_HBMRuntime
    py::class_<HB_HBMRuntime>(m, "HB_HBMRuntime")

        // Constructors
        .def(py::init<const std::string&>(), py::arg("model_file"))
        .def(py::init<const std::vector<std::string>&>(), py::arg("model_files"))

        // Static property
        .def_property_readonly_static("version", [](py::object) {
            return HB_HBMRuntime::GetVersion();
        })

        // Readonly model info
        .def_property_readonly("model_names", &HB_HBMRuntime::GetModelNames)
        .def_property_readonly("model_count", &HB_HBMRuntime::GetModelCount)

        // Input info
        .def_property_readonly("input_counts", &HB_HBMRuntime::GetInputCounts)
        .def_property_readonly("input_names", &HB_HBMRuntime::GetInputNames)
        .def_property_readonly("input_descs", &HB_HBMRuntime::GetInputDescs)
        .def_property_readonly("input_shapes", &HB_HBMRuntime::GetInputShapes)
        .def_property_readonly("input_dtypes", &HB_HBMRuntime::GetInputDtpyes)
        .def_property_readonly("input_quants", &HB_HBMRuntime::GetInputQuants)
        .def_property_readonly("input_strides", &HB_HBMRuntime::GetInputStrides)

        // Output info
        .def_property_readonly("output_counts", &HB_HBMRuntime::GetOutputCounts)
        .def_property_readonly("output_names", &HB_HBMRuntime::GetOutputNames)
        .def_property_readonly("output_descs", &HB_HBMRuntime::GetOutputDescs)
        .def_property_readonly("output_shapes", &HB_HBMRuntime::GetOutputShapes)
        .def_property_readonly("output_dtypes", &HB_HBMRuntime::GetOutputDtpyes)
        .def_property_readonly("output_quants", &HB_HBMRuntime::GetOutputQuants)
        .def_property_readonly("output_strides", &HB_HBMRuntime::GetOutputStrides)

        // Compile-time BPU core count per model
        .def_property_readonly("compile_bpu_core_num", &HB_HBMRuntime::GetCompileBpuCoreNum)

        // HBM and model description
        .def_property_readonly("model_descs", &HB_HBMRuntime::GetModelDescs)
        .def_property_readonly("hbm_descs", &HB_HBMRuntime::GetHBMDescs)

        // Expose scheduling parameters of models as a read-only property
        .def_property_readonly("sched_params", &HB_HBMRuntime::GetModelSchedParams)

        // Bind method to set scheduling parameters with optional arguments
        .def("set_scheduling_params",
             &HB_HBMRuntime::SetSchedulingParams,
             py::arg("priority") = std::nullopt,
             py::arg("bpu_cores") = std::nullopt,
             py::arg("custom_id") = std::nullopt,
             py::arg("device_id") = std::nullopt
        )

        // run() overloads: each accepts optional model_name, priority, bpu_cores, custom_id, device_id
        // GIL is released only inside C++ InferAllModels around LaunchInferenceTasks (not here).
        // Inference entry: single input
        .def("run",
            [](HB_HBMRuntime& self, py::array& input_tensor,
               const std::optional<std::string>& model_name,
               const std::optional<std::unordered_map<std::string, int32_t>>& priority,
               const std::optional<std::unordered_map<std::string, std::vector<int32_t>>>& bpu_cores,
               const std::optional<std::unordered_map<std::string, int64_t>>& custom_id,
               const std::optional<std::unordered_map<std::string, uint32_t>>& device_id) {
                if (!(input_tensor.flags() & py::array::c_style)) {
                    input_tensor = input_tensor.attr("copy")();  // Ensure C-contiguous
                }
                return self.run(input_tensor, model_name, priority, bpu_cores, custom_id, device_id);
            },
            py::arg("input_tensor"),
            py::arg("model_name") = std::nullopt,
            py::arg("priority") = std::nullopt,
            py::arg("bpu_cores") = std::nullopt,
            py::arg("custom_id") = std::nullopt,
            py::arg("device_id") = std::nullopt)

        // Inference entry: single model, multiple inputs
        .def("run",
            [](HB_HBMRuntime& self, std::unordered_map<std::string, py::array>& input_tensors,
               const std::optional<std::string>& model_name,
               const std::optional<std::unordered_map<std::string, int32_t>>& priority,
               const std::optional<std::unordered_map<std::string, std::vector<int32_t>>>& bpu_cores,
               const std::optional<std::unordered_map<std::string, int64_t>>& custom_id,
               const std::optional<std::unordered_map<std::string, uint32_t>>& device_id) {
                for (auto& [name, tensor] : input_tensors) {
                    if (!(tensor.flags() & py::array::c_style)) {
                        tensor = tensor.attr("copy")();
                    }
                }
                return self.run(input_tensors, model_name, priority, bpu_cores, custom_id, device_id);
            },
            py::arg("input_tensors"),
            py::arg("model_name") = std::nullopt,
            py::arg("priority") = std::nullopt,
            py::arg("bpu_cores") = std::nullopt,
            py::arg("custom_id") = std::nullopt,
            py::arg("device_id") = std::nullopt)

        // Inference entry: multiple models
        .def("run",
            [](HB_HBMRuntime& self,
               std::unordered_map<std::string, std::unordered_map<std::string, py::array>>& multi_input_tensors,
               const std::optional<std::string>& model_name,
               const std::optional<std::unordered_map<std::string, int32_t>>& priority,
               const std::optional<std::unordered_map<std::string, std::vector<int32_t>>>& bpu_cores,
               const std::optional<std::unordered_map<std::string, int64_t>>& custom_id,
               const std::optional<std::unordered_map<std::string, uint32_t>>& device_id) {
                for (auto& [mn, tensors] : multi_input_tensors) {
                    for (auto& [tensor_name, tensor] : tensors) {
                        if (!(tensor.flags() & py::array::c_style)) {
                            tensor = tensor.attr("copy")();
                        }
                    }
                }
                return self.run(multi_input_tensors, model_name, priority, bpu_cores, custom_id, device_id);
            },
            py::arg("multi_input_tensors"),
            py::arg("model_name") = std::nullopt,
            py::arg("priority") = std::nullopt,
            py::arg("bpu_cores") = std::nullopt,
            py::arg("custom_id") = std::nullopt,
            py::arg("device_id") = std::nullopt);
}
