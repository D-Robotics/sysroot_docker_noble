/***************************************************************************
* COPYRIGHT NOTICE
* Copyright 2019 Horizon Robotics, Inc.
* All rights reserved.
***************************************************************************/
#ifndef __HBN_ISP_CFG_INTERFACE_H__
#define __HBN_ISP_CFG_INTERFACE_H__
#include "cJSON.h"
#include "hbn_isp_cfg.h"

extern int32_t isp_node_parser_config(const cJSON *root, isp_cfg_t *cfg);

#endif
