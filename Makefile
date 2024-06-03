TARGET := iphone:clang:14.5
INSTALL_TARGET_PROCESSES = SpringBoard
THEOS_PACKAGE_SCHEME=rootless

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = HardenedCC

HardenedCC_FILES = $(shell find Sources/HardenedCC -name '*.swift') $(shell find Sources/HardenedCCC -name '*.m' -o -name '*.c' -o -name '*.mm' -o -name '*.cpp')
HardenedCC_SWIFTFLAGS = -ISources/HardenedCCC/include
HardenedCC_CFLAGS = -fobjc-arc -ISources/HardenedCCC/include
HardenedCC_FRAMEWORKS = ControlCenterUIKit SpringBoard ControlCenterUI

include $(THEOS_MAKE_PATH)/tweak.mk
SUBPROJECTS += hardenedccprefs
include $(THEOS_MAKE_PATH)/aggregate.mk
