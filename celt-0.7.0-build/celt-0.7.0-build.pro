include(../compiler.pri)

BUILDDIR=$$basename(PWD)
SOURCEDIR=$$replace(BUILDDIR,-build,-src)
VERSION=$$replace(BUILDDIR,-build,)
VERSION=$$replace(VERSION,celt-,)

!exists(../$$SOURCEDIR/COPYING) {
	message("The $$SOURCEDIR/ directory was not found.
	message("")
	message("Use CELT Git:")
	message("git submodule init")
	message("git submodule update")
	message("")
	error("Aborting configuration")
}

TEMPLATE = lib
CONFIG -= qt
CONFIG += static
CONFIG += debug_and_release
CONFIG -= warn_on
CONFIG += warn_off
VPATH	= ../$$SOURCEDIR/libcelt
TARGET = celt
DEFINES += HAVE_CONFIG_H
TARGET_VERSION_EXT = .$$VERSION

QMAKE_CFLAGS -= -fPIE -pie

win32 {
  DEFINES += WIN32 _WIN32
  INCLUDEPATH += ../$$BUILDDIR/win32

  CONFIG(sse2) {
    TARGET_VERSION_EXT = .$${VERSION}.sse2
  } else {
    QMAKE_CFLAGS_RELEASE -= -arch:SSE
    QMAKE_CFLAGS_DEBUG -= -arch:SSE
  }
}

unix {
	INCLUDEPATH += ../$$BUILDDIR
}

DIST = config.h

SOURCES *= bands.c celt.c cwrs.c entcode.c entdec.c entenc.c header.c kiss_fft.c kiss_fftr.c laplace.c mdct.c modes.c pitch.c psy.c quant_bands.c rangedec.c rangeenc.c rate.c vq.c

CONFIG(debug, debug|release) {
  CONFIG += console
  DESTDIR	= ../debug
}

CONFIG(release, debug|release) {
  DESTDIR	= ../release
}

include(../symbols.pri)
