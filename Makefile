include theos/makefiles/common.mk

APPLICATION_NAME = passwordstore
passwordstore_FILES = main.m passwordstoreApplication.mm PasswordsViewController.mm PassEntry.mm PassDataController.mm PassEntryViewController.mm PDKeychainBindingsController.m PDKeychainBindings.m
passwordstore_FRAMEWORKS = UIKit CoreGraphics Security
TARGET_CODESIGN_FLAGS = -Sent.xml

include $(THEOS_MAKE_PATH)/application.mk
