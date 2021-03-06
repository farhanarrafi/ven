# Copyright Statement:
#
# This software/firmware and related documentation ("MediaTek Software") are
# protected under relevant copyright laws. The information contained herein
# is confidential and proprietary to MediaTek Inc. and/or its licensors.
# Without the prior written permission of MediaTek inc. and/or its licensors,
# any reproduction, modification, use or disclosure of MediaTek Software,
# and information contained herein, in whole or in part, shall be strictly prohibited.

# MediaTek Inc. (C) 2010. All rights reserved.
#
# BY OPENING THIS FILE, RECEIVER HEREBY UNEQUIVOCALLY ACKNOWLEDGES AND AGREES
# THAT THE SOFTWARE/FIRMWARE AND ITS DOCUMENTATIONS ("MEDIATEK SOFTWARE")
# RECEIVED FROM MEDIATEK AND/OR ITS REPRESENTATIVES ARE PROVIDED TO RECEIVER ON
# AN "AS-IS" BASIS ONLY. MEDIATEK EXPRESSLY DISCLAIMS ANY AND ALL WARRANTIES,
# EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE IMPLIED WARRANTIES OF
# MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE OR NONINFRINGEMENT.
# NEITHER DOES MEDIATEK PROVIDE ANY WARRANTY WHATSOEVER WITH RESPECT TO THE
# SOFTWARE OF ANY THIRD PARTY WHICH MAY BE USED BY, INCORPORATED IN, OR
# SUPPLIED WITH THE MEDIATEK SOFTWARE, AND RECEIVER AGREES TO LOOK ONLY TO SUCH
# THIRD PARTY FOR ANY WARRANTY CLAIM RELATING THERETO. RECEIVER EXPRESSLY ACKNOWLEDGES
# THAT IT IS RECEIVER'S SOLE RESPONSIBILITY TO OBTAIN FROM ANY THIRD PARTY ALL PROPER LICENSES
# CONTAINED IN MEDIATEK SOFTWARE. MEDIATEK SHALL ALSO NOT BE RESPONSIBLE FOR ANY MEDIATEK
# SOFTWARE RELEASES MADE TO RECEIVER'S SPECIFICATION OR TO CONFORM TO A PARTICULAR
# STANDARD OR OPEN FORUM. RECEIVER'S SOLE AND EXCLUSIVE REMEDY AND MEDIATEK'S ENTIRE AND
# CUMULATIVE LIABILITY WITH RESPECT TO THE MEDIATEK SOFTWARE RELEASED HEREUNDER WILL BE,
# AT MEDIATEK'S OPTION, TO REVISE OR REPLACE THE MEDIATEK SOFTWARE AT ISSUE,
# OR REFUND ANY SOFTWARE LICENSE FEES OR SERVICE CHARGE PAID BY RECEIVER TO
# MEDIATEK FOR SUCH MEDIATEK SOFTWARE AT ISSUE.
#
# The following software/firmware and/or related documentation ("MediaTek Software")
# have been modified by MediaTek Inc. All revisions are subject to any receiver's
# applicable license agreements with MediaTek Inc.


# Copyright 2006 The Android Open Source Project

# XXX using libutils for simulator build only...
#
ifneq ($(TARGET_BUILD_PDK),true)

ifneq ($(strip $(MTK_PLATFORM)),)

LOCAL_PATH:= $(call my-dir)
include $(CLEAR_VARS)

LOCAL_MODULE:= atcid
LOCAL_MODULE_TAGS:= eng optional

LOCAL_SRC_FILES:= \
    src/atcid_serial.c \
    src/atcid.c \
    src/atcid_cmd_dispatch.c \
    src/atcid_cust_cmd.c \
    src/atcid_util.c \
    src/at_tok.c

LOCAL_SHARED_LIBRARIES := \
    libcutils 
ifeq ($(MTK_WLAN_SUPPORT),yes)
    LOCAL_SHARED_LIBRARIES += libwifitest
    LOCAL_CFLAGS += -DMTK_WLAN_FEATURE
endif

ifeq ($(MTK_GPS_SUPPORT),yes)
    LOCAL_CFLAGS += -DMTK_GPS_FEATURE
endif

ifeq ($(MTK_TC1_FEATURE),yes)
    LOCAL_SRC_FILES += \
        src/atcid_cust_tc1_cmd.c
    LOCAL_SHARED_LIBRARIES += libtc1rft
    LOCAL_CFLAGS += -DMTK_TC1_FEATURE
    LOCAL_C_INCLUDES += $(MTK_PATH_SOURCE)/hardware/connectivity/wlan/libtc1rft/
endif

ifeq ($(GEMINI),yes)	
  LOCAL_CFLAGS += -DMTK_GEMINI
endif

LOCAL_C_INCLUDES += \
        $(MTK_PATH_SOURCE)/kernel/drivers/video \
        $(MTK_PATH_SOURCE)/kernel/drivers/leds \
        $(MTK_PATH_SOURCE)/hardware/connectivity/wlan/libwifitest

ifeq ($(GEMINI),yes)
LOCAL_CFLAGS += \
    -DGEMINI
endif

ifeq ($(MTK_GEMINI_3SIM_SUPPORT),yes)
LOCAL_CFLAGS += \
    -DMTK_GEMINI_3SIM_SUPPORT
endif

ifeq ($(MTK_GEMINI_4SIM_SUPPORT),yes)
LOCAL_CFLAGS += \
    -DMTK_GEMINI_4SIM_SUPPORT
endif

include $(BUILD_EXECUTABLE)

endif
endif
