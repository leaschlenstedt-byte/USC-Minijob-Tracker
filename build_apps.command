#!/bin/zsh
cd "/Users/TUM/Desktop/USC Minijob Tracker" || exit 1

rm -rf "Trainings Tracker.app" "Trainings Tracker Stop.app"

mkdir -p "Trainings Tracker.app/Contents/MacOS"
mkdir -p "Trainings Tracker.app/Contents/Resources"
mkdir -p "Trainings Tracker Stop.app/Contents/MacOS"
mkdir -p "Trainings Tracker Stop.app/Contents/Resources"

cat > "Trainings Tracker.app/Contents/Info.plist" <<'EOF'
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
  <key>CFBundleDevelopmentRegion</key>
  <string>de</string>
  <key>CFBundleExecutable</key>
  <string>launcher</string>
  <key>CFBundleIdentifier</key>
  <string>local.trainings.tracker</string>
  <key>CFBundleInfoDictionaryVersion</key>
  <string>6.0</string>
  <key>CFBundleName</key>
  <string>Trainings Tracker</string>
  <key>CFBundlePackageType</key>
  <string>APPL</string>
  <key>CFBundleShortVersionString</key>
  <string>1.0</string>
  <key>CFBundleVersion</key>
  <string>1</string>
  <key>LSUIElement</key>
  <false/>
</dict>
</plist>
EOF

cat > "Trainings Tracker Stop.app/Contents/Info.plist" <<'EOF'
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
  <key>CFBundleDevelopmentRegion</key>
  <string>de</string>
  <key>CFBundleExecutable</key>
  <string>launcher</string>
  <key>CFBundleIdentifier</key>
  <string>local.trainings.tracker.stop</string>
  <key>CFBundleInfoDictionaryVersion</key>
  <string>6.0</string>
  <key>CFBundleName</key>
  <string>Trainings Tracker Stop</string>
  <key>CFBundlePackageType</key>
  <string>APPL</string>
  <key>CFBundleShortVersionString</key>
  <string>1.0</string>
  <key>CFBundleVersion</key>
  <string>1</string>
  <key>LSUIElement</key>
  <false/>
</dict>
</plist>
EOF

/usr/bin/clang tracker_app.c -o "Trainings Tracker.app/Contents/MacOS/launcher"
/usr/bin/clang tracker_stop_app.c -o "Trainings Tracker Stop.app/Contents/MacOS/launcher"
chmod +x "Trainings Tracker.app/Contents/MacOS/launcher" "Trainings Tracker Stop.app/Contents/MacOS/launcher"

echo "Apps erstellt:"
echo "  Trainings Tracker.app"
echo "  Trainings Tracker Stop.app"
echo
echo "Falls macOS beim ersten Start warnt: Rechtsklick > Oeffnen."
