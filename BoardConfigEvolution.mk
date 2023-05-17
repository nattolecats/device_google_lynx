#
# Copyright (C) 2023 The LineageOS Project
#
# SPDX-License-Identifier: Apache-2.0
#

BUILD_BROKEN_DUP_RULES := true
DISABLE_ARTIFACT_PATH_REQUIREMENTS := true

# Uses prebuilt kernel for now.
TARGET_KERNEL_DIR = device/google/lynx-kernel
TARGET_FORCE_PREBUILT_KERNEL := true
TARGET_PREBUILT_KERNEL := $(TARGET_KERNEL_DIR)/Image.lz4
PRODUCT_COPY_FILES += $(TARGET_PREBUILT_KERNEL):kernel

# Device Tree
BOARD_PREBUILT_DTBIMAGE_DIR := $(TARGET_KERNEL_DIR)
BOARD_PREBUILT_DTBOIMAGE := $(BOARD_PREBUILT_DTBIMAGE_DIR)/dtbo.img

# Kernel modules
KERNEL_MODULE_DIR := $(TARGET_KERNEL_DIR)
KERNEL_MODULES := $(wildcard $(KERNEL_MODULE_DIR)/*.ko)
BOARD_VENDOR_KERNEL_MODULES_BLOCKLIST_FILE := $(KERNEL_MODULE_DIR)/vendor_dlkm.modules.blocklist
# Prebuilt kernel modules that are *not* listed in vendor_kernel_boot.modules.load
BOARD_PREBUILT_VENDOR_KERNEL_RAMDISK_KERNEL_MODULES = fips140/fips140.ko
BOARD_VENDOR_KERNEL_RAMDISK_KERNEL_MODULES_LOAD_EXTRA = $(foreach k,$(BOARD_PREBUILT_VENDOR_KERNEL_RAMDISK_KERNEL_MODULES),$(if $(wildcard $(KERNEL_MODULE_DIR)/$(k)), $(k)))
KERNEL_MODULES += $(addprefix $(KERNEL_MODULE_DIR)/, $(BOARD_VENDOR_KERNEL_RAMDISK_KERNEL_MODULES_LOAD_EXTRA))
# Kernel modules that are listed in vendor_kernel_boot.modules.load
BOARD_VENDOR_KERNEL_RAMDISK_KERNEL_MODULES_LOAD_FILE := $(strip $(shell cat $(KERNEL_MODULE_DIR)/vendor_kernel_boot.modules.load))
ifndef BOARD_VENDOR_KERNEL_RAMDISK_KERNEL_MODULES_LOAD_FILE
$(error vendor_kernel_boot.modules.load not found or empty)
endif
BOARD_VENDOR_KERNEL_RAMDISK_KERNEL_MODULES_LOAD := $(BOARD_VENDOR_KERNEL_RAMDISK_KERNEL_MODULES_LOAD_EXTRA)
BOARD_VENDOR_KERNEL_RAMDISK_KERNEL_MODULES_LOAD += $(BOARD_VENDOR_KERNEL_RAMDISK_KERNEL_MODULES_LOAD_FILE)
BOARD_VENDOR_KERNEL_RAMDISK_KERNEL_MODULES := $(addprefix $(KERNEL_MODULE_DIR)/, $(BOARD_VENDOR_KERNEL_RAMDISK_KERNEL_MODULES_LOAD_EXTRA))
BOARD_VENDOR_KERNEL_RAMDISK_KERNEL_MODULES += $(addprefix $(KERNEL_MODULE_DIR)/, $(notdir $(BOARD_VENDOR_KERNEL_RAMDISK_KERNEL_MODULES_LOAD_FILE)))
BOARD_VENDOR_KERNEL_MODULES_LOAD := $(strip $(shell cat $(KERNEL_MODULE_DIR)/vendor_dlkm.modules.load))
ifndef BOARD_VENDOR_KERNEL_MODULES_LOAD
$(error vendor_dlkm.modules.load not found or empty)
endif
BOARD_VENDOR_KERNEL_MODULES := $(KERNEL_MODULES)
