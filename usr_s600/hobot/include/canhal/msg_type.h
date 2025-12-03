// Copyright 2023 Horizon Robotics

#ifndef CANHAL_MSG_TYPE_H_
#define CANHAL_MSG_TYPE_H_

#include <cstring>
#include <string>
#include <vector>

#define CAN_FRAME_LENGTH_MAX 64
#define MAX_DELAY_MS 28U
#define MAX_DELAY_US (MAX_DELAY_MS * 1000U)

namespace hobot {
namespace canhal {

template <typename DataType>
class DataPack {
 public:
  //coverity[autosar_cpp14_m0_1_10_violation:SUPPRESS]
  DataPack(int32_t capacity)
      : datas_(new DataType[capacity]),
        capacity_(capacity),
        len_(0),
        time_stamp_(0U),
        dev_("") {}
  ~DataPack() { delete[] datas_; }

  /**
   * @brief get addr of cahce used to save data.
   */
  DataType *GetUserBufPtr() { return datas_; }

  /**
   * @brief get user buf size.
   */
  const int32_t &GetUserBufSize() { return capacity_; }

  /**
   * @brief get length of raw data.
   * @return return the length of data, -1 if failed.
   */
  const int32_t &GetDataLen() { return len_; }

  /**
   * @brief set size of raw data.
   * @return return true if succ, false if failed.
   */
  void SetDataLen(int32_t l) {
    if (l > capacity_) {
      len_ = capacity_;
    } else {
      len_ = l;
    }
  }

  /**
   * @brief get the soc timestamp at which veh receives the data.
   */
  const uint64_t &GetTimestamp() const { return time_stamp_; }

  void CleanAll() {
    //coverity[autosar_cpp14_m5_0_3_violation:SUPPRESS]
    memset(datas_, 0x00, static_cast<uint32_t>(capacity_) * sizeof(DataType));
    len_ = 0;
    time_stamp_ = 0U;
    dev_ = "";
  }

  /**
   * @brief set the soc timestamp_ at which veh receives the data.
   */
  void SetTimestamp(uint64_t ts) { time_stamp_ = ts; }

  void SetCanDev(std::string dev) { dev_ = dev; }

  const std::string &GetCanDev() { return dev_; }

 private:
  DataType *const datas_;
  int32_t capacity_;
  int32_t len_;
  uint64_t time_stamp_;
  std::string dev_;
};

template <typename DataType>
class ConfigPack {
 public:
  ConfigPack(int32_t capacity)
      : datas_(new DataType[capacity]),
        capacity_(capacity),
        len_(0),
        dev_("") {}
  ~ConfigPack() { delete[] datas_; }

  /**
   * @brief get addr of cahce used to save data.
   */
  DataType *GetUserBufPtr() { return datas_; }

  /**
   * @brief get user buf size.
   */
  const int32_t &GetUserBufSize() { return capacity_; }

  /**
   * @brief get length of raw data.
   * @return return the length of data, -1 if failed.
   */
   //coverity[autosar_cpp14_m0_1_10_violation:SUPPRESS]
  virtual const int32_t &GetDataLen() { return len_; }

  /**
   * @brief set size of raw data.
   * @return return true if succ, false if failed.
   */
  //coverity[autosar_cpp14_m0_1_10_violation:SUPPRESS]
  virtual void SetDataLen(int32_t l) {
    if (l > capacity_) {
      len_ = capacity_;
    } else {
      len_ = l;
    }
  }

  void CleanAll() {
    memset(datas_, 0x00, capacity_ * sizeof(DataType));
    len_ = 0;
    dev_ = "";
  }

  void SetCanDev(std::string dev) { dev_ = dev; }

  const std::string &GetCanDev() { return dev_; }

 protected:
  DataType *const datas_;
  int32_t capacity_;
  int32_t len_;
  std::string dev_;
};

using RawPack = DataPack<uint8_t>;

enum class CanType : uint8_t { CANType_Can = 0, CANType_Canfd = 1 };

// #pragma pack(1)
struct CanFrame {
  uint64_t time_stamp;  ///< timestamp of the signals, unit ms
  uint32_t canid;
  uint8_t count;
  uint8_t can_type;
  uint8_t can_channel;
  uint8_t len;
  uint8_t data[CAN_FRAME_LENGTH_MAX];
};

struct Pack_Info {
  uint64_t soc_ts;
  uint32_t data_num; //can_frame: frame number; raw data: data length; can confilter: can channel number which need confilter can id
  uint64_t mcu_ts;
  uint16_t length; //[receive size prepare] can_frame: frame number; raw data: data length
  uint16_t unused;
  uint64_t unused_1;
  uint8_t  crc_enabled;
};

#pragma pack(1)

typedef struct{
  uint8_t     can_channel;
  uint8_t     verbose;
  uint8_t     reserved;
  uint8_t     filter_num;
  uint32_t    *filter_id;
}can_filter_info_t;

typedef struct {
  uint16_t length;
  uint8_t reversed[2];
  can_filter_info_t data;
}Can_Config_Filter_Type;

#pragma pack()

class CanFramePack : public DataPack<CanFrame> {
 public:
  //coverity[autosar_cpp14_m0_1_10_violation:SUPPRESS]
  CanFramePack(int32_t capacity) : DataPack(capacity) {}
  virtual ~CanFramePack() = default;
  //coverity[autosar_cpp14_m0_1_10_violation:SUPPRESS]
  void SetMcuTimestamp(uint64_t ts) { smpl_time_stamp_ = ts; }
  const uint64_t &GetMcuTimestamp() const { return smpl_time_stamp_; }

 private:
  uint64_t smpl_time_stamp_{0U};
};
//coverity[autosar_cpp14_a12_1_6_violation:SUPPRESS]
class CanConfigPack : public ConfigPack<Can_Config_Filter_Type> {
 public:
  //coverity[autosar_cpp14_m0_1_10_violation:SUPPRESS]
  CanConfigPack(int32_t capacity) : ConfigPack(capacity) {}
  virtual ~CanConfigPack() = default;
  //coverity[autosar_cpp14_m0_1_10_violation:SUPPRESS]
  void SetDataLen(int32_t l) override {
    //coverity[autosar_cpp14_a4_7_1_violation:SUPPRESS]
    if (l > (capacity_ * static_cast<int32_t>(sizeof(Can_Config_Filter_Type)))) {
      len_ = capacity_ * static_cast<int32_t>(sizeof(Can_Config_Filter_Type));
    } else {
      len_ = l;
    }
  }
  //coverity[autosar_cpp14_m0_1_10_violation:SUPPRESS]
  const int32_t &GetDataLen() override { return len_; }

 private:

};

}  // namespace canhal
}  // namespace hobot

#endif  //  CANHAL_MSG_TYPE_H_
