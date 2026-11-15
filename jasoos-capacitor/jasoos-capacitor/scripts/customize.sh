#!/bin/bash
set -e
cd android/app/src/main

# قفل الاتجاه عمودي
sed -i 's/<activity /<activity android:screenOrientation="portrait" /' AndroidManifest.xml

# أيقونة التطبيق
sudo apt-get install -y imagemagick >/dev/null
rm -rf res/mipmap-anydpi-v26
for d in mdpi:48 hdpi:72 xhdpi:96 xxhdpi:144 xxxhdpi:192; do
  n=${d%%:*}; s=${d##*:}
  mkdir -p res/mipmap-$n
  convert ../../../../icon.png -resize ${s}x${s} res/mipmap-$n/ic_launcher.png
  cp res/mipmap-$n/ic_launcher.png res/mipmap-$n/ic_launcher_round.png
  cp res/mipmap-$n/ic_launcher.png res/mipmap-$n/ic_launcher_foreground.png
done
