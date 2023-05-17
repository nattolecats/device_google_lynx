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

cd - > /dev/null

return
