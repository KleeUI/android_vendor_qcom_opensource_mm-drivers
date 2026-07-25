
ifneq ($(TARGET_QCOM_MSM_EXT_DISPLAY_DLKM), false)
PRODUCT_PACKAGES += msm_ext_display.ko
endif

MM_DRV_DLKM_ENABLE := true
ifeq ($(TARGET_KERNEL_DLKM_DISABLE), true)
	ifeq ($(TARGET_KERNEL_DLKM_MM_DRV_OVERRIDE), false)
		MM_DRV_DLKM_ENABLE := false
	endif
endif

ifeq ($(MM_DRV_DLKM_ENABLE), true)
	ifneq ($(TARGET_QCOM_SYNC_FENCE_DLKM), false)
		ifneq ($(filter true parrot,$(TARGET_QCOM_SYNC_FENCE_DLKM) $(TARGET_BOARD_PLATFORM)),)
			PRODUCT_PACKAGES += sync_fence.ko
		else ifeq ($(filter taro blair, $(TARGET_BOARD_PLATFORM)),)
			PRODUCT_PACKAGES += sync_fence.ko
		endif
	endif
	ifneq ($(TARGET_QCOM_HW_FENCE_DLKM), false)
		ifeq ($(TARGET_QCOM_HW_FENCE_DLKM), true)
			PRODUCT_PACKAGES += msm_hw_fence.ko
		else ifeq ($(filter taro blair parrot, $(TARGET_BOARD_PLATFORM)),)
			PRODUCT_PACKAGES += msm_hw_fence.ko
		endif
	endif
endif

DISPLAY_MM_DRIVER := msm_ext_display.ko sync_fence.ko msm_hw_fence.ko
