#ifndef _HBN_TXSER_ADAPTER_
#define _HBN_TXSER_ADAPTER_
#include "cJSON.h"

int32_t hbn_txser_adapter_cfg_init(uint32_t port, const cJSON *board_node);
int32_t hbn_txser_adapter_init(uint32_t port);
int32_t hbn_txser_adapter_deinit(uint32_t port);

#endif