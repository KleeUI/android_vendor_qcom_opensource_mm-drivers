MM_DRIVER_PATH := $(call my-dir)

MM_DRV_DLKM_ENABLE := true
ifeq ($(TARGET_KERNEL_DLKM_DISABLE), true)
	ifeq ($(TARGET_KERNEL_DLKM_MM_DRV_OVERRIDE), false)
		MM_DRV_DLKM_ENABLE := false
	endif
endif

ifeq ($(MM_DRV_DLKM_ENABLE), true)
ifneq ($(TARGET_QCOM_MSM_EXT_DISPLAY_DLKM), false)
	include $(MM_DRIVER_PATH)/msm_ext_display/Android.mk
endif

MM_SYNC_FENCE_DLKM_ENABLE := false
MM_HW_FENCE_DLKM_ENABLE := false
ifeq ($(TARGET_BOARD_PLATFORM), parrot)
MM_SYNC_FENCE_DLKM_ENABLE := true
else ifeq ($(filter taro blair, $(TARGET_BOARD_PLATFORM)),)
MM_SYNC_FENCE_DLKM_ENABLE := true
MM_HW_FENCE_DLKM_ENABLE := true
endif
ifeq ($(TARGET_QCOM_SYNC_FENCE_DLKM), true)
MM_SYNC_FENCE_DLKM_ENABLE := true
else ifeq ($(TARGET_QCOM_SYNC_FENCE_DLKM), false)
MM_SYNC_FENCE_DLKM_ENABLE := false
endif
ifeq ($(TARGET_QCOM_HW_FENCE_DLKM), true)
MM_HW_FENCE_DLKM_ENABLE := true
else ifeq ($(TARGET_QCOM_HW_FENCE_DLKM), false)
MM_HW_FENCE_DLKM_ENABLE := false
endif

ifeq ($(MM_SYNC_FENCE_DLKM_ENABLE), true)
include $(MM_DRIVER_PATH)/sync_fence/Android.mk
endif
ifeq ($(MM_HW_FENCE_DLKM_ENABLE), true)
include $(MM_DRIVER_PATH)/hw_fence/Android.mk
endif
endif
