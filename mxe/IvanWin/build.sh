#!/bin/bash

set -xue

MXE_DIR=/usr/lib/mxe

if [ "$IVAN_PLATFORM" = "IvanWin" ]; then
    MXE_TARGET=i686-w64-mingw32.static
    SDL2_PKGCONFIG_CFLAGS=$(/usr/lib/mxe/usr/bin/i686-w64-mingw32.static-pkg-config --cflags sdl2)
    SDL2_PKGCONFIG_LFLAGS=$(/usr/lib/mxe/usr/bin/i686-w64-mingw32.static-pkg-config --libs --static sdl2)
    SDL2_PKGCONFIG_LFLAGS2=$(echo "$SDL2_PKGCONFIG_LFLAGS"| awk '{$1=$1};1')
fi

${MXE_DIR}/usr/bin/${MXE_TARGET}-cmake .. -DIGNORE_EXTRA_WHITESPACES=ON -DBUILD_SHARED_LIBS=OFF -DBUILD_STATIC_LIBS=ON -DSDL2_LDFLAGS="${SDL2_PKGCONFIG_LFLAGS2}" -DCMAKE_CXX_FLAGS="-Werror -Wno-format-security -Wno-undefined-var-template -Wno-unknown-warning-option $CXXFLAGS" -DCMAKE_INSTALL_PREFIX="./${IVAN_PLATFORM}"

set +xue
