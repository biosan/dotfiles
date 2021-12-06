#!/usr/bin/env sh
rm -rf "~/Library/LaunchAgents/org.virtualbox.vboxwebsrv.plist"
rm -rf "/usr/local/bin/VirtualBox"
rm -rf "/usr/local/bin/VBoxManage"
rm -rf "/usr/local/bin/VBoxVRDP"
rm -rf "/usr/local/bin/VBoxHeadless"
rm -rf "/usr/local/bin/vboxwebsrv"
rm -rf "/usr/local/bin/VBoxBugReport"
rm -rf "/usr/local/bin/VBoxBalloonCtrl"
rm -rf "/usr/local/bin/VBoxAutostart"
rm -rf "/usr/local/bin/VBoxDTrace"
rm -rf "/usr/local/bin/vbox-img"
rm -rf "/Library/LaunchDaemons/org.virtualbox.startup.plist"
rm -rf "/Library/Python/2.7/site-packages/vboxapi/VirtualBox_constants.py"
rm -rf "/Library/Python/2.7/site-packages/vboxapi/VirtualBox_constants.pyc"
rm -rf "/Library/Python/2.7/site-packages/vboxapi/__init__.py"
rm -rf "/Library/Python/2.7/site-packages/vboxapi/__init__.pyc"
rm -rf "/Library/Python/2.7/site-packages/vboxapi-1.0-py2.7.egg-info"
rm -rf "/Library/Application Support/VirtualBox/LaunchDaemons/"
rm -rf "/Library/Application Support/VirtualBox/VBoxDrv.kext/"
rm -rf "/Library/Application Support/VirtualBox/VBoxUSB.kext/"
rm -rf "/Library/Application Support/VirtualBox/VBoxNetFlt.kext/"
rm -rf "/Library/Application Support/VirtualBox/VBoxNetAdp.kext/"
rm -rf "/Applications/VirtualBox.app/"
rm -rf "/Library/Python/2.7/site-packages/vboxapi/"

# org.virtualbox.kext.VBoxUSB
# org.virtualbox.kext.VBoxNetFlt
# org.virtualbox.kext.VBoxNetAdp
# org.virtualbox.kext.VBoxDrv
# org.virtualbox.pkg.vboxkexts
# org.virtualbox.pkg.virtualbox
# org.virtualbox.pkg.virtualboxcli
