TEMPLATE = subdirs
CONFIG *= ordered debug_and_release

!CONFIG(no-client) {
  unix:!CONFIG(bundled-speex):system(pkg-config --atleast-version=1.2 speexdsp) {
	CONFIG *= no-bundled-speex
  }
  !CONFIG(no-bundled-speex) {
    SUBDIRS *= speexbuild
  }

  SUBDIRS *= celt-0.7.0-build

  CONFIG(sbcelt) {
    SUBDIRS *= sbcelt-lib-build sbcelt-helper-build
  }

  !CONFIG(no-opus) {
    CONFIG *= opus
  }

  CONFIG(opus):!CONFIG(no-bundled-opus) {
	SUBDIRS *= opus-build
  }

  SUBDIRS *= src/mumble

  !CONFIG(no-plugins) {
    SUBDIRS *= plugins
  }

  win32 {
    SUBDIRS *= overlay
    !CONFIG(no-g15) {
      SUBDIRS *= g15helper
    }
  }

  unix:!macx:!CONFIG(no-overlay) {
    SUBDIRS *= overlay_gl
  }

  macx {
    MUMBLE_PREFIX = $$(MUMBLE_PREFIX)
    isEmpty(MUMBLE_PREFIX) {
      error("Missing $MUMBLE_PREFIX environment variable");
    }
    SUBDIRS *= macx
    !exists($$(MUMBLE_PREFIX)/../lglcd) {
      CONFIG *= no-g15
    }
    !CONFIG(no-g15) {
      SUBDIRS *= g15helper
    }
  }
}

!CONFIG(no-server) {
  SUBDIRS *= src/murmur
}

DIST=LICENSE INSTALL README README.Linux CHANGES

include(scripts/scripts.pro)
