/***************************************************************************
 * COPYRIGHT NOTICE
 * Copyright 2023 Horizon Robotics, Inc.
 * All rights reserved.
 ***************************************************************************/

#ifndef __HBN_VIN_CFG_INTERFACE_H__
#define __HBN_VIN_CFG_INTERFACE_H__

#include <stdint.h>
#include "hbn_vin_cfg.h"

int32_t vin_node_parser_config(const void *root, void *vin_cfg);

#endif //__HBN_VIN_CFG_INTERFACE_H__
