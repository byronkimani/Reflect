#!/usr/bin/env bash
# Re-apply manual splash fixes after `dart run flutter_native_splash:create`.
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
cd "$ROOT"

ANDROID_V31="$ROOT/android/app/src/main/res/values-v31/styles.xml"
ANDROID_NIGHT_V31="$ROOT/android/app/src/main/res/values-night-v31/styles.xml"
IOS_STORYBOARD="$ROOT/ios/Runner/Base.lproj/LaunchScreen.storyboard"

patch_android_v31() {
  local file="$1"
  cat >"$file" <<'EOF'
<?xml version="1.0" encoding="utf-8"?>
<resources>
    <!-- Full-screen static splash (no Android 12 icon zoom — mark and wordmark appear together). -->
    <style name="LaunchTheme" parent="@android:style/Theme.Light.NoTitleBar">
        <item name="android:forceDarkAllowed">false</item>
        <item name="android:windowFullscreen">true</item>
        <item name="android:windowDrawsSystemBarBackgrounds">true</item>
        <item name="android:windowLayoutInDisplayCutoutMode">shortEdges</item>
        <item name="android:windowBackground">@drawable/launch_background</item>
    </style>
    <style name="NormalTheme" parent="@android:style/Theme.Light.NoTitleBar">
        <item name="android:windowBackground">?android:colorBackground</item>
    </style>
</resources>
EOF
}

patch_android_v31_night() {
  local file="$1"
  cat >"$file" <<'EOF'
<?xml version="1.0" encoding="utf-8"?>
<resources>
    <style name="LaunchTheme" parent="@android:style/Theme.Black.NoTitleBar">
        <item name="android:forceDarkAllowed">false</item>
        <item name="android:windowFullscreen">true</item>
        <item name="android:windowDrawsSystemBarBackgrounds">true</item>
        <item name="android:windowLayoutInDisplayCutoutMode">shortEdges</item>
        <item name="android:windowBackground">@drawable/launch_background</item>
    </style>
    <style name="NormalTheme" parent="@android:style/Theme.Black.NoTitleBar">
        <item name="android:windowBackground">?android:colorBackground</item>
    </style>
</resources>
EOF
}

patch_ios_storyboard() {
  cat >"$IOS_STORYBOARD" <<'EOF'
<?xml version="1.0" encoding="UTF-8" standalone="no"?>
<document type="com.apple.InterfaceBuilder3.CocoaTouch.Storyboard.XIB" version="3.0" toolsVersion="12121" systemVersion="16G29" targetRuntime="iOS.CocoaTouch" propertyAccessControl="none" useAutolayout="YES" launchScreen="YES" colorMatched="YES" initialViewController="01J-lp-oVM">
    <dependencies>
        <deployment identifier="iOS"/>
        <plugIn identifier="com.apple.InterfaceBuilder.IBCocoaTouchPlugin" version="12089"/>
    </dependencies>
    <scenes>
        <!--View Controller-->
        <scene sceneID="EHf-IW-A2E">
            <objects>
                <viewController id="01J-lp-oVM" sceneMemberID="viewController">
                    <layoutGuides>
                        <viewControllerLayoutGuide type="top" id="Ydg-fD-yQy"/>
                        <viewControllerLayoutGuide type="bottom" id="xbc-2k-c8Z"/>
                    </layoutGuides>
                    <view key="view" contentMode="scaleToFill" id="Ze5-6b-2t3">
                        <autoresizingMask key="autoresizingMask" widthSizable="YES" heightSizable="YES"/>
                        <subviews>
                            <imageView opaque="YES" clipsSubviews="YES" userInteractionEnabled="NO" contentMode="scaleAspectFill" image="LaunchImage" translatesAutoresizingMaskIntoConstraints="NO" id="YRO-k0-Ey4"/>
                        </subviews>
                        <color key="backgroundColor" red="0.9607843137254902" green="0.9529411764705882" blue="0.9333333333333333" alpha="1" colorSpace="custom" customColorSpace="sRGB"/>
                        <constraints>
                            <constraint firstItem="YRO-k0-Ey4" firstAttribute="leading" secondItem="Ze5-6b-2t3" secondAttribute="leading" id="3T2-ad-Qdv"/>
                            <constraint firstAttribute="trailing" secondItem="YRO-k0-Ey4" secondAttribute="trailing" id="TQA-XW-tRk"/>
                            <constraint firstItem="YRO-k0-Ey4" firstAttribute="bottom" secondItem="Ze5-6b-2t3" secondAttribute="bottom" id="duK-uY-Gun"/>
                            <constraint firstItem="YRO-k0-Ey4" firstAttribute="top" secondItem="Ze5-6b-2t3" secondAttribute="top" id="xPn-NY-SIU"/>
                        </constraints>
                    </view>
                </viewController>
                <placeholder placeholderIdentifier="IBFirstResponder" id="iYj-Kq-Ea1" userLabel="First Responder" sceneMemberID="firstResponder"/>
            </objects>
            <point key="canvasLocation" x="53" y="375"/>
        </scene>
    </scenes>
    <resources>
        <image name="LaunchImage" width="1284" height="2778"/>
    </resources>
</document>
EOF
}

patch_android_v31 "$ANDROID_V31"
patch_android_v31_night "$ANDROID_NIGHT_V31"
patch_ios_storyboard

echo "Patched Android v31 styles and iOS LaunchScreen.storyboard."
