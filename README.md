name: Build APK
on:
  workflow_dispatch:
  push:
    branches: [main, master]
defaults:
  run:
    working-directory: jasoos-capacitor/jasoos-capacitor
jobs:
  build:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - uses: actions/setup-node@v4
        with:
          node-version: 20
      - uses: actions/setup-java@v4
        with:
          distribution: temurin
          java-version: 21
      - run: npm install
      - run: npx cap add android
      - run: bash scripts/customize.sh
      - run: npx cap sync android
      - run: cd android && chmod +x gradlew && ./gradlew assembleDebug
      - uses: actions/upload-artifact@v4
        with:
          name: jasoos-apk
          path: jasoos-capacitor/jasoos-capacitor/android/app/build/outputs/apk/debug/app-debug.apk
          
