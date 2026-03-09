/***************************************************************************
* COPYRIGHT NOTICE
* Copyright 2020 Horizon Robotics, Inc.
* All rights reserved.
***************************************************************************/
#ifndef __HBN_VPF_DATA_INFO_H__
#define __HBN_VPF_DATA_INFO_H__

#ifdef __cplusplus
extern "C" {
#endif

#include <stdint.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/time.h>
#include <hb_mem_mgr.h>
#include "hb_gdc_data_info.h"

#define HBN_VFLOW_PIPELINE_MAX 64u
#define HBN_VIO_BUFFER_MAX_PLANES 4u
#define HBN_METADATA_SIZE (4 * 1024) //4KB

#define HBN_LAYER_MAXIMUM 6u
#define HBN_PIPELINE_BIND_MAX 16u /**< vio pipeline max bind count  @NO{S09E05C02U}  */
#ifdef SUPER_CAMSYS
#define HBN_GETFRAME_TIMEOUT 4000
#else
#define HBN_GETFRAME_TIMEOUT 1000 //1000ms for dvb
#endif
#define HBN_MAX_VNODE_CONFIG 8u

#if defined(SOC_NAME_S100)
#define EN_3DNR_HW_ID 1
#elif defined(SOC_NAME_S600)
#define EN_3DNR_HW_ID 3
#endif

typedef int64_t hbn_vnode_handle_t;
typedef int64_t hbn_vflow_handle_t;

// module type
typedef enum hb_vnode_type_e {
	HB_CAM = 1, // CAMERA type for hbn error.
	HB_VIN_V0 = 2, // XJ3
	HB_ISP_V0, // XJ3
	HB_IPU_V0, // XJ3
	HB_PYM_V0, // XJ3
	HB_GDC, // XJ3/Ultra/Super
	HB_VIN_V1, // Ultra
	HB_ISP_V1, // Ultra
	HB_PYM_V1, // Ultra
	HB_STITCH, // Ultra/Super
	HB_LKOF, // Ultra
	HB_VIN, // Super
	HB_ISP, // Super
	HB_YNR, // Super
	HB_PYM, // Super
	HB_IDU, // XJ3/Ultra/Super
	HB_VPU, // XJ3/Ultra/Super
	HB_JPU, // XJ3/Ultra/Super
	HB_CODEC, // XJ3/Ultra/Super
	HB_VIN_RB, // X5
	HB_ISP_RB, // X5
	HB_VSE, // X5
	HB_N2D, // X5
	HB_VNODE_TYPE_MAX
} hb_vnode_type;

typedef struct hbn_frame_info_s {
	uint32_t frame_id;
	uint64_t timestamps;
	struct timeval tv;
	struct timeval trig_tv;
	uint32_t frame_done;
	int32_t bufferindex;
} hbn_frame_info_t;

typedef struct hbn_buf_alloc_attr_s {
	int64_t flags;
	uint32_t buffers_num;
	uint32_t is_contig;
} hbn_buf_alloc_attr_t;

typedef struct hbn_vnode_image_s {
	hbn_frame_info_t info;
	hb_mem_graphic_buf_t buffer;
	void *metadata;
} hbn_vnode_image_t;

typedef struct hbn_vnode_image_group_s {
	hbn_frame_info_t info;
	hb_mem_graphic_buf_group_t buf_group;
	void *metadata;
} hbn_vnode_image_group_t;

typedef struct hbn_version_s {
	uint32_t major;
	uint32_t minor;
} hbn_version_t;

typedef int32_t hobot_status;

#if defined __QNX__
typedef struct vpf_shm_buf_s {
	int32_t use_shm;
	int32_t shm_fd;
	int32_t size;
	uint64_t handle;
	uint8_t *buf;
} vpf_shm_buf_t;
#endif

typedef struct vpf_ext_ctrl {
	uint32_t id;
	void *arg;
#if defined __QNX__
	int32_t need_return;
	int32_t data_size;
	vpf_shm_buf_t shm_buf;
#endif
} vpf_ext_ctrl_t;

typedef enum vpf_bind_mode_e {
	BIND_NONE,
	BIND_OTF_INPUT,
	BIND_OTF_OUTPUT,
	BIND_M2M_INPUT,
	BIND_M2M_OUTPUT,
} vpf_bind_mode_t;

typedef enum HBN_VMODULE_TYPE {
	HBN_VIN_MODULE,
	HBN_ISP_MODULE,
	HBN_PYM_MODULE,
	HBN_MODULE_MAX
} HBN_VMODULE_TYPE_E;

typedef enum HBN_VEVENT_TYPE {
	HBN_INFO_FRAME_START = 1u << 0u,
	HBN_INFO_FRAME_DONE = 1u << 1u,
	HBN_INFO_EVENT_ALL = 0xFFFFFFFF,
} HBN_VEVENT_TYPE_E;

struct hbn_vevent {
	uint32_t pipe_id;//通路编号
	HBN_VMODULE_TYPE_E module_type; //模块类型
	HBN_VEVENT_TYPE_E event_type; //事件类型
	uint32_t hw_frame_id; //硬件帧号，记录SOC收到的帧数
	uint32_t sw_frame_id; //软件帧号，通路中通用帧号，除基于时间戳跳帧场景外，都等于硬件帧号
	uint64_t hw_timestamps; //第一个pixel到CIM侧记录的RTC时间戳 （us）
	uint64_t fs_timestamps; //帧处理开始的时间（us）
	uint64_t fe_timestamps; //帧处理结束的时间（us）
	uint64_t event_timestamps; //事件触发的时间（us）
	uint32_t event_cnt; //事件触发的次数
	uint32_t reserved[8];
};

#define HB_VIO_BUFF_MAX_NUM 16u
typedef struct hbn_buf_info_s {
	int32_t buf_num; /**< buffer number. */
	uint32_t buf_type;
	hb_mem_graphic_buf_t buf[HB_VIO_BUFF_MAX_NUM];
	hb_mem_graphic_buf_group_t group_buf[HB_VIO_BUFF_MAX_NUM];
} hbn_buf_info_t;

typedef struct vio_buf_info_s {
	hbn_buf_info_t ibuf;
	hbn_buf_info_t obuf;
} vio_buf_info_t;

#ifdef __cplusplus
}
#endif

#endif
