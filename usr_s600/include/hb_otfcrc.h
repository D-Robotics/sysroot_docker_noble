/**
 * @file hb_otfcrc.h
 *
 * @NO{S06E12C06}
 *
 * @ASIL{B}
 *
 * COPYRIGHT NOTICE
 * Copyright 2023 Horizon Robotics, Inc.
 * All rights reserved.
 */
#ifndef HOBOT_OTFCRC_H
#define HOBOT_OTFCRC_H

#include <stdint.h>

#ifdef __cplusplus
extern "C" {
#endif

#define OTFCRC_MAX_DATA_LEN (0x800000u - 1u)

/**
 * @enum hb_otfcrc_polymode
 * otfcrc support poly mode
 */
typedef enum {
	CRC5_D128_AUTOSTAR = 0,
	CRC5_D128_USBTOKEN,
	CRC8_D128_ATMHEC,
	CRC8_D128_SAEJ850,
	CRC10_D128,
	CRC16_D128_CCITT,
	CRC16_D128_USB,
	CRC32_D128_AUTOSTAR,
	CRC32_D128_IEEE,
	MAX_CRC_MODE,
} hb_otfcrc_polymode;

/**
 * @NO{S06E12C06}
 * @ASIL{B}
 * @brief otfcrc func init interface
 *
 * @param[in] input_reflect: input reflect flag 输入反转
 * @param[in] result_reflect: result reflect flag 输出反转
 * @param[in] poly_mode: use poly mode 使用的多项式模式
 * @param[in] ini_val: crc init val CRC的初始值
 * @param[in] xor_outval: out xor val CRC计算结束后需要xor的值
 * @param[in] data_len: data length 数据长度
 *
 * @retval =0: success
 * @retval !=0: failure
 *
 * @data_read None
 * @data_updated None
 * @compatibility HW: Super SoC
 * @compatibility SW: 1.0.0
 *
 * @callgraph
 * @callergraph
 * @design
 */
uint32_t hb_otfcrc_init(uint32_t input_reflect, uint32_t result_reflect,
			hb_otfcrc_polymode poly_mode, uint32_t ini_val,
			uint32_t xor_outval, uint32_t data_len);
/**
 * @NO{S06E12C06}
 * @ASIL{B}
 * @brief get otfcrc in ske encrypto proc
 *
 * @param[out] otfcrc: otfcrc value 计算后的otfcrc结果
 *
 * @retval =0: success
 * @retval <0: failure
 *
 * @data_read None
 * @data_updated None
 * @compatibility HW: Super SoC
 * @compatibility SW: 1.0.0
 *
 * @callgraph
 * @callergraph
 * @design
 */
uint32_t hb_otfcrc_fini_getcrc(uint32_t *otfcrc);

/**
 * @NO{S06E12C06}
 * @ASIL{B}
 * @brief check otfcrc val in ske decrypt proc
 *
 * @param[in] otfcrc: otfcrc value 待检查的crc结果
 *
 * @retval =0: success
 * @retval <0: failure
 *
 * @data_read None
 * @data_updated None
 * @compatibility HW: Super SoC
 * @compatibility SW: 1.0.0
 *
 * @callgraph
 * @callergraph
 * @design
 */
uint32_t hb_otfcrc_fini_checkcrc(uint32_t otfcrc);

#ifdef __cplusplus
}
#endif

#endif //HOBOT_LIFECYCLE_H
