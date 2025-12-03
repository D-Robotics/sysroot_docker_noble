//
// Copyright 2023 Horizon Robotics.
//
 //coverity[autosar_cpp14_a1_1_1_violation:SUPPRESS]
#include <stdint.h>
#if defined __linux__
#include <linux/can.h>
#endif
#ifdef __cplusplus
    extern "C" {
    #endif
#define CAN_FRAME_LENGTH_MAX 64

//coverity[autosar_cpp14_a7_2_3_violation:SUPPRESS]
enum cantype {
    CANType_Can = 0,
    CANType_Canfd
};

struct canframe {
  uint64_t time_stamp;  ///< timestamp of the signals, unit ms
  uint32_t canid;
  uint8_t count;
  uint8_t can_type;
  uint8_t can_channel;
  uint8_t len;
  uint8_t data[CAN_FRAME_LENGTH_MAX];
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
#pragma pack(0)

struct pack_info {
  uint64_t soc_ts;
  uint32_t data_num; //can_frame: frame number; raw data: data length; can confilter: data length
  uint64_t mcu_ts;
  uint16_t length; //[receive size prepare] can_frame: frame number; raw data: data length
  uint16_t unused;
  uint64_t unused_1;
  uint8_t  crc_enabled;
};
/* canframe的个数不确定，不方便定canframe的大小
  struct canframe[];
*/

int canInit();
void canDeInit();
int canRecvMsgRaw(const char *target, uint8_t *rx_buf, struct pack_info *pack);//接收原始数据
int canSendMsgRaw(const char *target, uint8_t *tx_buf, struct pack_info *pack);//发送原始数据
int canRecvMsgFrame(const char *target, struct canframe *frame, struct pack_info *pack);//接收解析之后的can数据
int canSendMsgFrame(const char *target, struct canframe *frame, struct pack_info *pack);//发送can frame数据
int canSendMsgConfig(const char *target, Can_Config_Filter_Type *filter, struct pack_info *pack);

#ifdef __cplusplus
  }
#endif
