#!/bin/sh

# Guard
if ! history | tail -n 1 | grep -q "evolution_lynx"; then return; fi

# This is unofficial build
unset EVO_BUILD_TYPE

# Go to root of source
croot

# Remove conflict packages
rm -rf vendor/gms/product/packages/privileged_apps/DeviceIntelligenceNetworkPrebuilt
rm -rf vendor/gms/product/packages/privileged_apps/DevicePersonalizationPrebuiltPixel2020

# Create DTS symlink if missing
SYMLINK_TARGET=kernel/google/gs201/private/gs-google/arch/arm64/boot/dts/google/devices
mkdir -p $SYMLINK_TARGET && ln -sf ../../../../../../../devices/google/lynx/dts/ $SYMLINK_TARGET/lynx

cd - > /dev/null

return
