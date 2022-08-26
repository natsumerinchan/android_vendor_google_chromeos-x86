# Enable support for ARM on x86 native bridge
BUILD_ARM_FOR_X86 := true

ifeq ($(filter x86 x86_64,$(TARGET_ARCH)),)
    $(error TARGET_ARCH needs to be set to x86 or x86_64)
endif

# If native bridge is bundled with the system, indicate support for ARM ABIs
ifeq ($(WITH_NATIVE_BRIDGE), true)
    NATIVE_BRIDGE_ABI_LIST_32_BIT := armeabi-v7a armeabi
    NATIVE_BRIDGE_ABI_LIST_64_BIT := arm64-v8a
endif

# Add ARM to supported ABIs
ifeq ($(TARGET_ARCH),x86_64)
    TARGET_CPU_ABI_LIST_32_BIT := $(TARGET_2ND_CPU_ABI) $(NATIVE_BRIDGE_ABI_LIST_32_BIT)
    TARGET_CPU_ABI_LIST_64_BIT := $(TARGET_CPU_ABI) $(NATIVE_BRIDGE_ABI_LIST_64_BIT)
else
    NATIVE_BRIDGE_ABI_LIST_64_BIT :=
    TARGET_CPU_ABI_LIST_32_BIT := $(TARGET_CPU_ABI) $(NATIVE_BRIDGE_ABI_LIST_32_BIT)
endif
