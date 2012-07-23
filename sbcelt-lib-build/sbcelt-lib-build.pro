include(../compiler.pri)

BUILDDIR=$$basename(PWD)
SOURCEDIR=$$replace(BUILDDIR,-lib-build,-src)

!exists($$CELTDIR/COPYING) {
        message("The $$CELTDIR/ directory was not found. You need to do the following:")
        message("")
        message("Use CELT Git:")
        message("git submodule init")
        message("git submodule update")
        message("")
        error("Aborting configuration")
}

!exists(../$$SOURCEDIR/LICENSE) {
	message("The $$SOURCEDIR/ directory was not found. You need to do the following:")
	message("")
	message("Use SBCELT Git:")
	message("git submodule init")
	message("git submodule update")
	message("")
	error("Aborting configuration")
}

TEMPLATE = lib
CONFIG -= qt
CONFIG += debug_and_release
CONFIG -= warn_on
CONFIG += warn_off
CONFIG += static
VPATH	= ../$$SOURCEDIR/lib
TARGET = sbcelt
INCLUDEPATH = ../celt-0.7.0-src/libcelt

QMAKE_CFLAGS -= -fPIE -pie

unix {
	INCLUDEPATH += ../$$BUILDDIR
}

SOURCES *= libsbcelt.c

CONFIG(debug, debug|release) {
  CONFIG += console
  DESTDIR	= ../debug
}

CONFIG(release, debug|release) {
  DESTDIR	= ../release
}

include(../symbols.pri)
