ARCHS = arm64 arm64e
TARGET := iphone:clang:latest:14.5

include $(THEOS)/makefiles/common.mk

BUNDLE_NAME = HardenedCCPrefs

HardenedCCPrefs_FRAMEWORKS = SwiftUI
HardenedCCPrefs_FILES = $(shell find Sources/HardenedCCPrefs -name '*.swift') $(shell find Sources/HardenedCCPrefsC -name '*.m' -o -name '*.c' -o -name '*.mm' -o -name '*.cpp')
HardenedCCPrefs_SWIFTFLAGS = -ISources/HardenedCCPrefsC/include
HardenedCCPrefs_INSTALL_PATH = /Library/PreferenceBundles
HardenedCCPrefs_CFLAGS = -fobjc-arc

include $(THEOS_MAKE_PATH)/bundle.mk
