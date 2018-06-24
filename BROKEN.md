system-settings-git:
==> WARNING: Package contains reference to $srcdir
usr/lib/ubuntu-system-settings/private/Ubuntu/SystemSettings/Bluetooth/libUbuntuBluetoothPanel.so

settings-components-git:
/usr/lib/qt5/qml/Ubuntu/Settings -> /usr/lib/qt/qml/Ubuntu/Settings

qmenumodel:
/usr/lib/qt5/qml/QMenuModel -> /usr/lib/qt/qml/QMenuModel

qtmir:
/usr/lib/qt5/plugins/platforms/libqpa-mirserver.so -> /usr/lib/qt/plugins/platforms

indicator-network-git:
/usr/lib/qt5/qml/Ubuntu/Connectivity -> /usr/lib/qt/qml/Ubuntu/Connectivity

ubuntu-download-manager:
/usr/lib/qt5/qml/Ubuntu/DownloadManager -> /usr/lib/qt/qml/Ubuntu/DownloadManager

content-hub:
/usr/lib/qt5/qml/Ubuntu/Content -> /usr/lib/qt/qml/Ubuntu/Content

unity8:
missing deps: qtmir-git
missing /usr/share/backgrounds/warty-final-ubuntu.png (should be /usr/share/wallpapers?) (https://t.me/ubports/136672)
references build path:  <Unknown File>:46:33: QML CroppedImageMinimumSourceSize: Cannot open: file:///mnt/antihype/Projects/AUR/tests/graphics/applicationIcons/dash.png

system-settings:
missing deps: indicator-datetime (unpackaged)
module "Biometryd" is not installed (unpackaged)
Settings schema 'com.ubuntu.notifications.settings.applications' is not installed
Settings schema 'com.canonical.keyboard.maliit' is not installed

missing dep:
gsettings-qt-git

/usr/include/gtest/CMakeLists.txt exists in both 'libertine-git' and 'platform-api-git'
