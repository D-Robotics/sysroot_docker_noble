/***************************************************************************
 * COPYRIGHT NOTICE
 * Copyright 2019 Horizon Robotics, Inc.
 * All rights reserved.
 ***************************************************************************/
#ifndef SUPER_VIN_VNODE_H_
#define SUPER_VIN_VNODE_H_

#include "vpf_inter_interface.h"
#include "hbn_vpf_interface.h"
#include "vin_cfg.h"

int32_t vin_vnode_open(vnode_entity_t *vnode);
int32_t vin_vnode_close(vnode_entity_t *vnode);
hbn_vnode_handle_t vin_vnode_init(void *vin);
hbn_vnode_handle_t vin_vnode_cfg_init(void *root);
#endif //SUPER_VIN_VNODE_H_
