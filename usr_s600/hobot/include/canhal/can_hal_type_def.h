// Copyright 2023 Horizon Robotics

#ifndef INCLUDE_CANHAL_TYPE_DEF_H_
#define INCLUDE_CANHAL_TYPE_DEF_H_

#include <string>
#include <vector>

namespace hobot {
namespace canhal{

enum class ErrorCode {
  ERROR_CODE_UNKNOWN = -1,
  ERROR_CODE_SUCCESS = 0,
  ERROR_CODE_CONFIG_FILE_INVALID = -100,
  ERROR_CODE_CONFIG_FILE_NOT_EXIST = -101,
  ERROR_CODE_TARGET_NOT_EXIST = -200,
  ERROR_CODE_IO_CHANNEL_INVALID_ID = -201,
  ERROR_CODE_IO_CHANNEL_NOT_EXIST = -202,
  ERROR_CODE_IO_CHANNEL_CONFIG_INVALID = -203,
  ERROR_CODE_IO_CHANNEL_NOT_INITED = -204,
  ERROR_CODE_IO_CHANNEL_INITED_ALREDY = -205,
  ERROR_CODE_IO_CHANNEL_INIT_FAILED = -206,
  ERROR_CODE_INIT_HAL_GROUP_FAILED = -301,
  ERROR_CODE_CONFIG_HAL_GROUP_FAILED = -302,
  ERROR_CODE_DEV_BSP_API_FAILED = -303,
  ERROR_CODE_DEV_NO_CHANNEL_CONFIG = -304,
  ERROR_CODE_DEV_CONFIG_NO_GROUP = -305,
  ERROR_CODE_DEV_CONFIG_NO_MSGS = -306,
  ERROR_CODE_DEV_CONFIG_NO_FILTERS = -307,
  ERROR_CODE_DEV_INITED_ALREADY = -308,
  ERROR_CODE_DEV_NOT_INITED = -309,
  ERROR_CODE_DEV_RECONNECT = -310,
  ERROR_CODE_BASIC_COM_LOAD_DEV_FAILED = -311,
  ERROR_CODE_SEND_INVALID_PTR = -400,
  ERROR_CODE_SEND_BUFFER_OVERFLOW = -401,
  ERROR_CODE_PROTO_INVALID = -402,
  ERROR_CODE_PROTO_NOT_SUPPORT = -403,
  ERROR_CODE_CACHE_INVALID = -404,
  ERROR_CODE_CHECKSUM_ABNORMAL = -405,
  ERROR_CODE_SEQUENCE_ABNORMAL = -406,
  ERROR_CODE_CACHE_TOO_SMALL = -407,
  ERROR_CODE_LATENCY_TOO_LARGE = -408,
  ERROR_CODE_CRC_ERROR = -409
};

enum class DevType {
  DEV_INVALID = -1,
  DEV_CAN,
  DEV_SPI,
  DEV_IPCF,
  DEV_ETH
};
 //coverity[autosar_cpp14_m0_1_10_violation:SUPPRESS]
inline const char *DevTypeToString(DevType type) {
  switch (type) {
    //coverity[autosar_cpp14_m6_4_5_violation:SUPPRESS]
    case DevType::DEV_CAN:
      return "can";
    //coverity[autosar_cpp14_m6_4_5_violation:SUPPRESS]
    case DevType::DEV_SPI:
      return "spi";
    //coverity[autosar_cpp14_m6_4_5_violation:SUPPRESS]
    case DevType::DEV_IPCF:
      return "ipcf";
    //coverity[autosar_cpp14_m6_4_5_violation:SUPPRESS]
    case DevType::DEV_ETH:
      return "eth";
    //coverity[autosar_cpp14_m6_4_5_violation:SUPPRESS]
    default:
      return "invalid";
  }
}
}
}

#endif //  INCLUDE_CANHAL_TYPE_DEF_H_


