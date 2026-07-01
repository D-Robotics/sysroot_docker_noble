.PHONY: install
all: install

install:
ifeq ($(HB_PKG_HBUTILS_DEV_DEB), y)
	$(Q)install -d ${MODULE_RUNTIME_DIR}/usr/hobot/bin/
	install ${SRC_PATH}/pcie_tool/* ${MODULE_RUNTIME_DIR}/usr/hobot/bin
endif
