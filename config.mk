# Customize below to fit your system (run ./configure for automatic presets)

# paths (unset $PCPREFIX to not install a pkg-config-file)
DESTDIR   =
PREFIX    = /usr/local
INCPREFIX = $(PREFIX)/include
LIBPREFIX = $(PREFIX)/lib
MANPREFIX = $(PREFIX)/share/man
PCPREFIX  = $(LIBPREFIX)/pkgconfig

# flags
CPPFLAGS = -D_DEFAULT_SOURCE
CFLAGS   = -std=c99 -Os -Wall -Wextra -Wpedantic
LDFLAGS  = -s

BUILD_CPPFLAGS = $(CPPFLAGS)
BUILD_CFLAGS   = $(CFLAGS)
BUILD_LDFLAGS  = $(LDFLAGS)

SHFLAGS   = -fPIC -ffreestanding

SONAME    = libgrapheme.so.$(VERSION_MAJOR).$(VERSION_MINOR).$(VERSION_PATCH)
SOFLAGS   = -shared -nostdlib -Wl,--soname=$(SONAME)
ifeq ($(OS),Windows_NT)
    SONAME = libgrapheme.dll
    SOFLAGS   = -s -shared -Wl,--subsystem,windows -Wl,--soname=$(SONAME)
endif
SOSYMLINK = true

# tools (unset $LDCONFIG to not call ldconfig(1) after install/uninstall)
CC       = gcc
BUILD_CC = $(CC)
AR       = ar
RANLIB   = ranlib
LDCONFIG = ldconfig
SH       = sh
