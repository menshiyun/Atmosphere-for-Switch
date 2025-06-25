#!/bin/sh
set -e

### Credit to the Authors at https://rentry.org/CFWGuides
### Script created by Fraxalotl
### Mod by huangqian8
### Mod by gzk_47

# -------------------------------------------

### GitHub API Headers
API_AUTH="Authorization: Bearer $GITHUB_TOKEN"
API_VER="X-GitHub-Api-Version: 2022-11-28"

# -------------------------------------------

### Create a new folder for storing files
if [ -d ZDM-Tesla ]; then
  rm -rf ZDM-Tesla
fi
if [ -e description.txt ]; then
  rm -rf description.txt
fi
mkdir -p ./ZDM-Tesla
#mkdir -p ./ZDM-Tesla/atmosphere/config
#mkdir -p ./ZDM-Tesla/atmosphere/hosts
#mkdir -p ./ZDM-Tesla/bootloader/ini
mkdir -p ./ZDM-Tesla/emuiibo/overlay
mkdir -p ./ZDM-Tesla/bootloader/payloads
cd ZDM-Tesla

# -------------------------------------------

cat >> ../description.txt << ENDOFFILE
大气层核心套件：
 
ENDOFFILE

### Fetch latest atmosphere from https://github.com/Atmosphere-NX/Atmosphere/releases/latest
curl -H "$API_AUTH" -sL https://api.github.com/repos/Atmosphere-NX/Atmosphere/releases/latest \
  | jq '.name' \
  | xargs -I {} echo {} >> ../description.txt


### Fetch Hekate + Nyx CHS from https://github.com/easyworld/hekate/releases/latest
curl -H "$API_AUTH" -sL https://api.github.com/repos/easyworld/hekate/releases/latest \
  | jq '.name' \
  | xargs -I {} echo {} >> ../description.txt

### Fetch Sigpatches 
### from https://gbatemp.net/threads/sigpatches-for-atmosphere-hekate-fss0-fusee-package3.571543/
#curl -sL https://raw.githubusercontent.com/gzk47/SwitchPlugins/main/sys/sigpatches.zip -o sigpatches.zip
#if [ $? -ne 0 ]; then
#    echo "sigpatches download\033[31m failed\033[0m."
#else
#    echo "sigpatches download\033[32m success\033[0m."
#    echo sigpatches >> ../description.txt
#    rm sigpatches.zip
#fi

###
cat >> ../description.txt << ENDOFFILE
sigpatches
ENDOFFILE
###

### Fetch sys-patch from https://github.com/impeeza/sys-patch/releases/latest
curl -H "$API_AUTH" -sL https://api.github.com/repos/impeeza/sys-patch/releases/latest \
  | jq '.name' \
  | xargs -I {} echo {} >> ../description.txt
#curl -H "$API_AUTH" -sL https://api.github.com/repos/impeeza/sys-patch/releases/latest \
#  | grep -oP '"browser_download_url": "\Khttps://[^"]*sys-patch.zip"' \
#  | sed 's/"//g' \
#  | xargs -I {} curl -sL {} -o sys-patch.zip
#if [ $? -ne 0 ]; then
#    echo "sys-patch download\033[31m failed\033[0m."
#else
#    echo "sys-patch download\033[32m success\033[0m."
#    unzip -oq sys-patch.zip
#    rm sys-patch.zip
#fi


# -------------------------------------------

###
cat >> ../description.txt << ENDOFFILE
 
------------------------------
 
Hekate paloads 二次引导软件：
 
ENDOFFILE
###

#### Fetch latest Lockpick_RCM.bin from https://github.com/Decscots/Lockpick_RCM/releases/latest
#curl -H "$API_AUTH" -sL https://api.github.com/repos/Decscots/Lockpick_RCM/releases/latest \
#  | jq '.tag_name' \
#  | xargs -I {} echo Lockpick_RCM {} >> ../description.txt
#curl -H "$API_AUTH" -sL https://api.github.com/repos/Decscots/Lockpick_RCM/releases/latest \
#  | grep -oP '"browser_download_url": "\Khttps://[^"]*Lockpick_RCM.bin"' \
#  | sed 's/"//g' \
#  | xargs -I {} curl -sL {} -o Lockpick_RCM.bin
#if [ $? -ne 0 ]; then
#    echo "Lockpick_RCM download\033[31m failed\033[0m."
#else
#    echo "Lockpick_RCM download\033[32m success\033[0m."
#    mv Lockpick_RCM.bin ./bootloader/payloads
#fi

### Fetch lastest Lockpick_RCMDecScots from https://github.com/zdm65477730/Lockpick_RCMDecScots/releases/latest
curl -H "$API_AUTH" -sL https://api.github.com/repos/zdm65477730/Lockpick_RCMDecScots/releases/latest \
  | jq '.tag_name' \
  | xargs -I {} echo Lockpick_RCM {} >> ../description.txt
curl -H "$API_AUTH" -sL https://api.github.com/repos/zdm65477730/Lockpick_RCMDecScots/releases/latest \
  | grep -oP '"browser_download_url": "\Khttps://[^"]*Lockpick_RCM.bin"' \
  | sed 's/"//g' \
  | xargs -I {} curl -sL {} -o Lockpick_RCM.bin
if [ $? -ne 0 ]; then
    echo "Lockpick_RCM download\033[31m failed\033[0m."
else
    echo "Lockpick_RCM download\033[32m success\033[0m."
    mkdir -p ./bootloader/payloads
    mv Lockpick_RCM.bin ./bootloader/payloads
fi

### Fetch latest TegraExplorer.bin form https://github.com/zdm65477730/TegraExplorer/releases
curl -H "$API_AUTH" -sL https://api.github.com/repos/zdm65477730/TegraExplorer/releases/latest \
  | jq '.tag_name' \
  | xargs -I {} echo TegraExplorer {} >> ../description.txt
curl -H "$API_AUTH" -sL https://api.github.com/repos/zdm65477730/TegraExplorer/releases/latest \
  | grep -oP '"browser_download_url": "\Khttps://[^"]*TegraExplorer.bin"' \
  | sed 's/"//g' \
  | xargs -I {} curl -sL {} -o TegraExplorer.bin
if [ $? -ne 0 ]; then
    echo "TegraExplorer download\033[31m failed\033[0m."
else
    echo "TegraExplorer download\033[32m success\033[0m."
    mv TegraExplorer.bin ./bootloader/payloads
fi

### Fetch latest CommonProblemResolver.bin form https://github.com/zdm65477730/CommonProblemResolver/releases
curl -H "$API_AUTH" -sL https://api.github.com/repos/zdm65477730/CommonProblemResolver/releases/latest \
  | jq '.tag_name' \
  | xargs -I {} echo CommonProblemResolver {} >> ../description.txt
curl -H "$API_AUTH" -sL https://api.github.com/repos/zdm65477730/CommonProblemResolver/releases/latest \
  | grep -oP '"browser_download_url": "\Khttps://[^"]*CommonProblemResolver.bin"' \
  | sed 's/"//g' \
  | xargs -I {} curl -sL {} -o CommonProblemResolver.bin
if [ $? -ne 0 ]; then
    echo "CommonProblemResolver download\033[31m failed\033[0m."
else
    echo "CommonProblemResolver download\033[32m success\033[0m."
    mv CommonProblemResolver.bin ./bootloader/payloads
fi

# -------------------------------------------

###
cat >> ../description.txt << ENDOFFILE
 
------------------------------
 
相册nro软件：
 
ENDOFFILE
###

### Fetch lastest Switch_90DNS_tester from https://github.com/meganukebmp/Switch_90DNS_tester/releases/latest
curl -H "$API_AUTH" -sL https://api.github.com/repos/meganukebmp/Switch_90DNS_tester/releases/latest \
  | jq '.tag_name' \
  | xargs -I {} echo Switch_90DNS_tester {} >> ../description.txt

### Fetch lastest DBI from https://github.com/rashevskyv/dbi/releases/latest
curl -H "$API_AUTH" -sL https://api.github.com/repos/rashevskyv/dbi/releases/latest \
  | jq '.name' \
  | xargs -I {} echo {} >> ../description.txt

### Fetch lastest Awoo Installer from https://github.com/dragonflylee/Awoo-Installer/releases/latest
curl -H "$API_AUTH" -sL https://api.github.com/repos/dragonflylee/Awoo-Installer/releases/latest \
  | jq '.name' \
  | xargs -I {} echo {} >> ../description.txt

### Fetch lastest DeepSeaToolbox from https://github.com/Team-Neptune/DeepSea-Toolbox/releases/latest
curl -H "$API_AUTH" -sL https://api.github.com/repos/Team-Neptune/DeepSea-Toolbox/releases/latest \
  | jq '.tag_name' \
  | xargs -I {} echo DeepSeaToolbox {} >> ../description.txt

### Fetch lastest NX-Activity-Log from https://github.com/zdm65477730/NX-Activity-Log/releases/latest
curl -H "$API_AUTH" -sL https://api.github.com/repos/zdm65477730/NX-Activity-Log/releases/latest \
  | jq '.tag_name' \
  | xargs -I {} echo NX-Activity-Log {} >> ../description.txt
curl -H "$API_AUTH" -sL https://api.github.com/repos/zdm65477730/NX-Activity-Log/releases/latest \
  | grep -oP '"browser_download_url": "\Khttps://[^"]*NX-Activity-Log.nro"' \
  | sed 's/"//g' \
  | xargs -I {} curl -sL {} -o NX-Activity-Log.nro
if [ $? -ne 0 ]; then
    echo "NX-Activity-Log download\033[31m failed\033[0m."
else
    echo "NX-Activity-Log download\033[32m success\033[0m."
    mkdir -p ./switch/NX-Activity-Log
    mv NX-Activity-Log.nro ./switch/NX-Activity-Log
fi

### Fetch lastest NXThemesInstaller from https://github.com/exelix11/SwitchThemeInjector/releases/latest
curl -H "$API_AUTH" -sL https://api.github.com/repos/exelix11/SwitchThemeInjector/releases/latest \
  | jq '.tag_name' \
  | xargs -I {} echo NXThemesInstaller {} >> ../description.txt

### Fetch lastest JKSV from https://github.com/J-D-K/JKSV/releases/latest
curl -H "$API_AUTH" -sL https://api.github.com/repos/J-D-K/JKSV/releases/latest \
  | jq '.name' \
  | xargs -I {} echo JKSV {} >> ../description.txt

### Fetch lastest tencent-switcher-gui from https://github.com/CaiMiao/Tencent-switcher-GUI/releases/latest
curl -H "$API_AUTH" -sL https://api.github.com/repos/CaiMiao/Tencent-switcher-GUI/releases/latest \
  | jq '.tag_name' \
  | xargs -I {} echo tencent-switcher-gui {} >> ../description.txt

### Fetch lastest aio-switch-updater from https://github.com/HamletDuFromage/aio-switch-updater/releases/latest
curl -H "$API_AUTH" -sL https://api.github.com/repos/HamletDuFromage/aio-switch-updater/releases/latest \
  | jq '.tag_name' \
  | xargs -I {} echo aio-switch-updater {} >> ../description.txt

### Fetch lastest wiliwili from https://github.com/xfangfang/wiliwili/releases/latest
curl -H "$API_AUTH" -sL https://api.github.com/repos/xfangfang/wiliwili/releases/latest \
  | jq '.tag_name' \
  | xargs -I {} echo wiliwili {} >> ../description.txt

### Fetch lastest SimpleModDownloader from https://github.com/PoloNX/SimpleModDownloader/releases/latest
curl -H "$API_AUTH" -sL https://api.github.com/repos/PoloNX/SimpleModDownloader/releases/latest \
  | jq '.tag_name' \
  | xargs -I {} echo SimpleModDownloader {} >> ../description.txt

### Fetch lastest SimpleModManager from https://github.com/nadrino/SimpleModManager/releases/latest
curl -H "$API_AUTH" -sL https://api.github.com/repos/nadrino/SimpleModManager/releases/latest \
  | jq '.tag_name' \
  | xargs -I {} echo SimpleModManager {} >> ../description.txt

### Fetch lastest Switchfin from https://github.com/dragonflylee/switchfin/releases/latest
curl -H "$API_AUTH" -sL https://api.github.com/repos/dragonflylee/switchfin/releases/latest \
  | jq '.tag_name' \
  | xargs -I {} echo Switchfin {} >> ../description.txt

### Fetch lastest Moonlight from https://github.com/XITRIX/Moonlight-Switch/releases/latest
curl -H "$API_AUTH" -sL https://api.github.com/repos/XITRIX/Moonlight-Switch/releases/latest \
  | jq '.tag_name' \
  | xargs -I {} echo Moonlight {} >> ../description.txt

### Fetch NX-Shell from https://github.com/zdm65477730/NX-Shell/releases/latest
curl -H "$API_AUTH" -sL https://api.github.com/repos/zdm65477730/NX-Shell/releases/latest \
  | jq '.tag_name' \
  | xargs -I {} echo NX-Shell {} >> ../description.txt
curl -H "$API_AUTH" -sL https://api.github.com/repos/zdm65477730/NX-Shell/releases/latest \
  | grep -oP '"browser_download_url": "\Khttps://[^"]*NX-Shell.nro"' \
  | sed 's/"//g' \
  | xargs -I {} curl -sL {} -o NX-Shell.nro
if [ $? -ne 0 ]; then
    echo "NX-Shell download\033[31m failed\033[0m."
else
    echo "NX-Shell download\033[32m success\033[0m."
    mkdir -p ./switch/NX-Shell
    mv NX-Shell.nro ./switch/NX-Shell
fi

### Fetch lastest hb-appstore from https://github.com/fortheusers/hb-appstore/releases/latest
curl -H "$API_AUTH" -sL https://api.github.com/repos/fortheusers/hb-appstore/releases/latest \
  | jq '.tag_name' \
  | xargs -I {} echo hb-appstore {} >> ../description.txt

### Fetch lastest ReverseNX-Tool from https://github.com/masagrator/ReverseNX-Tool/releases
curl -H "$API_AUTH" -sL https://api.github.com/repos/masagrator/ReverseNX-Tool/releases/latest \
  | jq '.tag_name' \
  | xargs -I {} echo ReverseNX-Tool {} >> ../description.txt
  curl -H "$API_AUTH" -sL https://api.github.com/repos/masagrator/ReverseNX-Tool/releases/latest \
  | grep -oP '"browser_download_url": "\Khttps://[^"]*ReverseNX-Tool.nro"' \
  | sed 's/"//g' \
  | xargs -I {} curl -sL {} -o ReverseNX-Tool.nro
if [ $? -ne 0 ]; then
    echo "ReverseNX-Tool download\033[31m failed\033[0m."
else
    echo "ReverseNX-Tool download\033[32m success\033[0m."
    mkdir -p ./switch/ReverseNX-Tool
    mv ReverseNX-Tool.nro ./switch/ReverseNX-Tool
fi

### Fetch lastest Goldleaf from https://github.com/XorTroll/Goldleaf/releases/latest
curl -H "$API_AUTH" -sL https://api.github.com/repos/XorTroll/Goldleaf/releases/latest \
  | jq '.tag_name' \
  | xargs -I {} echo Goldleaf {} >> ../description.txt

### Fetch lastest Safe_Reboot_Shutdown from https://github.com/dezem/Safe_Reboot_Shutdown/releases/latest
curl -H "$API_AUTH" -sL https://api.github.com/repos/dezem/Safe_Reboot_Shutdown/releases/latest \
  | jq '.tag_name' \
  | xargs -I {} echo Safe_Reboot_Shutdown {} >> ../description.txt

### Fetch lastest Firmware-Dumper from https://github.com/mrdude2478/Switch-Firmware-Dumper/releases
#curl -H "$API_AUTH" -sL https://api.github.com/repos/mrdude2478/Switch-Firmware-Dumper/releases/latest \
#  | jq '.tag_name' \
#  | xargs -I {} echo Firmware-Dumper {} >> ../description.txt
#curl -H "$API_AUTH" -sL https://api.github.com/repos/mrdude2478/Switch-Firmware-Dumper/releases/latest \
#  | grep -oP '"browser_download_url": "\Khttps://[^"]*Firmware-Dumper.nro"' \
#  | sed 's/"//g' \
#  | xargs -I {} curl -sL {} -o Firmware-Dumper.nro
#if [ $? -ne 0 ]; then
#    echo "Firmware-Dumper download\033[31m failed\033[0m."
#else
#    echo "Firmware-Dumper download\033[32m success\033[0m."
#    mkdir -p ./switch/Firmware-Dumper
#    mv Firmware-Dumper.nro ./switch/Firmware-Dumper
#fi

### Fetch lastest Firmware-Dumper【Chinese lang】 from https://github.com/zdm65477730/Switch-Firmware-Dumper/releases/latest
curl -H "$API_AUTH" -sL https://api.github.com/repos/zdm65477730/Switch-Firmware-Dumper/releases/latest \
  | jq '.tag_name' \
  | xargs -I {} echo Firmware-Dumper {} >> ../description.txt

### Fetch lastest nxdumptool(nxdt_rw_poc) from https://github.com/DarkMatterCore/nxdumptool/releases/download/rewrite-prerelease/nxdt_rw_poc.nro
#curl -sL https://github.com/DarkMatterCore/nxdumptool/releases/download/rewrite-prerelease/nxdt_rw_poc.nro -o nxdt_rw_poc.nro
#if [ $? -ne 0 ]; then
#    echo "nxdt_rw_poc download\033[31m failed\033[0m."
#else
#    echo "nxdt_rw_poc download\033[32m success\033[0m."
#    echo nxdumptool-rewrite latest >> ../description.txt
#    mkdir -p ./switch/nxdumptool
#    mv nxdt_rw_poc.nro ./switch/nxdumptool
#fi

###
cat >> ../description.txt << ENDOFFILE
nxdumptool-rewrite latest
ENDOFFILE
###

### Fetch lastest Haku33 from https://github.com/StarDustCFW/Haku33/releases/latest
curl -H "$API_AUTH" -sL https://api.github.com/repos/StarDustCFW/Haku33/releases/latest \
  | jq '.tag_name' \
  | xargs -I {} echo Haku33 {} >> ../description.txt

### Fetch linkalho
#curl -sL https://raw.githubusercontent.com/gzk47/SwitchPlugins/main/nro/linkalho.zip -o linkalho.zip
#if [ $? -ne 0 ]; then
#    echo "linkalho download\033[31m failed\033[0m."
#else
#    echo "linkalho download\033[32m success\033[0m."
#    echo linkalho >> ../description.txt
#    rm linkalho.zip
#fi

###
cat >> ../description.txt << ENDOFFILE
linkalho
ENDOFFILE
###

### Fetch lastest sphaira from https://github.com/ITotalJustice/sphaira/releases/latest
curl -H "$API_AUTH" -sL https://api.github.com/repos/ITotalJustice/sphaira/releases/latest \
  | jq '.tag_name' \
  | xargs -I {} echo sphaira {} >> ../description.txt
  
# -------------------------------------------

###
cat >> ../description.txt << ENDOFFILE
 
------------------------------
 
特斯拉中文版插件：（纯净版 没有特斯拉插件）
 
ENDOFFILE
###

### Fetch nx-ovlloader
#curl -sL https://raw.githubusercontent.com/gzk47/SwitchPlugins/main/plugins/nx-ovlloader.zip -o nx-ovlloader.zip
#if [ $? -ne 0 ]; then
#    echo "nx-ovlloader download\033[31m failed\033[0m."
#else
#    echo "nx-ovlloader download\033[32m success\033[0m."
#    unzip -oq nx-ovlloader.zip
#    rm nx-ovlloader.zip
#fi

## Fetch lastest nx-ovlloader from https://github.com/zdm65477730/nx-ovlloader/releases/latest
curl -H "$API_AUTH" -sL https://api.github.com/repos/zdm65477730/nx-ovlloader/releases/latest \
  | jq '.tag_name' \
  | xargs -I {} echo nx-ovlloader {} >> ../description.txt
curl -H "$API_AUTH" -sL https://api.github.com/repos/zdm65477730/nx-ovlloader/releases/latest \
  | grep -oP '"browser_download_url": "\Khttps://[^"]*nx-ovlloader[^"]*.zip"' \
  | sed 's/"//g' \
  | xargs -I {} curl -sL {} -o nx-ovlloader.zip
if [ $? -ne 0 ]; then
    echo "nx-ovlloader download\033[31m failed\033[0m."
else
    echo "nx-ovlloader download\033[32m success\033[0m."
    unzip -oq nx-ovlloader.zip
    rm nx-ovlloader.zip
fi

### Write config.ini in /config/tesla
cat > ./config/tesla/config.ini << ENDOFFILE
[tesla]
key_combo=L+DDOWN
ENDOFFILE
if [ $? -ne 0 ]; then
    echo "Writing config.ini in ./config/tesla\033[31m failed\033[0m."
else
    echo "Writing config.ini in ./config/tesla\033[32m success\033[0m."
fi

### Fetch Tesla-Menu
#curl -sL #https://raw.githubusercontent.com/gzk47/SwitchPlugins/main/plugins/Tesla-Menu.zip -o Tesla-Menu.zip
#if [ $? -ne 0 ]; then
#    echo "Tesla-Menu download\033[31m failed\033[0m."
#else
#    echo "Tesla-Menu download\033[32m success\033[0m."
#    unzip -oq Tesla-Menu.zip
#    rm Tesla-Menu.zip
#fi

#保留压缩包Tesla-Menu.zip
### Fetch lastest Tesla-Menu from https://github.com/zdm65477730/Tesla-Menu/releases/latest
#curl -H "$API_AUTH" -sL https://api.github.com/repos/zdm65477730/Tesla-Menu/releases/latest \
#  | jq '.tag_name' \
#  | xargs -I {} echo Tesla-Menu {} >> ../description.txt
curl -H "$API_AUTH" -sL https://api.github.com/repos/zdm65477730/Tesla-Menu/releases/latest \
  | grep -oP '"browser_download_url": "\Khttps://[^"]*Tesla-Menu[^"]*.zip"' \
  | sed 's/"//g' \
  | xargs -I {} curl -sL {} -o Tesla-Menu.zip
if [ $? -ne 0 ]; then
    echo "Tesla-Menu download\033[31m failed\033[0m."
else
    echo "Tesla-Menu download\033[32m success\033[0m."
#    unzip -oq Tesla-Menu.zip
#    rm Tesla-Menu.zip
fi

### Write sort.cfg in /config/Tesla-Menu/sort.cfg
#cat > ./config/Tesla-Menu/sort.cfg << ENDOFFILE
#ovl-sysmodules
#StatusMonitor
#EdiZon
#ReverseNX-RT
#sys-clk
#emuiibo
#ldn_mitm
#QuickNTP
#SysDVR
#Fizeau
#Zing
#ENDOFFILE

### Fetch Ultrahand-Overlay
## Fetch latest Ultrahand-Overlay from https://github.com/zdm65477730/Ultrahand-Overlay
curl -H "$API_AUTH" -sL https://api.github.com/repos/zdm65477730/Ultrahand-Overlay/releases/latest \
  | jq '.tag_name' \
  | xargs -I {} echo Ultrahand-Overlay {} >> ../description.txt
curl -H "$API_AUTH" -sL https://api.github.com/repos/zdm65477730/Ultrahand-Overlay/releases/latest \
  | grep -oP '"browser_download_url": "\Khttps://[^"]*Ultrahand[^"]*.zip"' \
  | sed 's/"//g' \
  | xargs -I {} curl -sL {} -o Ultrahand.zip
if [ $? -ne 0 ]; then
    echo "Ultrahand-Overlay download\033[31m failed\033[0m."
else
    echo "Ultrahand-Overlay download\033[32m success\033[0m."
    unzip -oq Ultrahand.zip
    rm Ultrahand.zip
fi

### Write config.ini in /config/Ultrahand
cat > ./config/Ultrahand/config.ini << ENDOFFILE
[ultrahand]
default_lang=zh-cn
key_combo=L+DDOWN
ENDOFFILE
if [ $? -ne 0 ]; then
    echo "Writing config.ini in ./config/Ultrahand\033[31m failed\033[0m."
else
    echo "Writing config.ini in ./config/Ultrahand\033[32m success\033[0m."
fi

### Write overlays.ini in /config/Ultrahand
cat > ./config/Ultrahand/overlays.ini << ENDOFFILE
[ovl-sysmodules.ovl]
priority=0

[StatusMonitor.ovl]
priority=1

[EdiZon.ovl]
priority=2

[ReverseNX-RT.ovl]
priority=3

[sys-clk.ovl]
priority=4

[emuiibo.ovl]
priority=5

[ldn_mitm.ovl]
priority=6

[QuickNTP.ovl]
priority=7

[SysDVR.ovl]
priority=8

[FPSLocker.ovl]
priority=9

[sys-patch-overlay.ovl]
priority=10
ENDOFFILE
if [ $? -ne 0 ]; then
    echo "Writing overlays.ini in ./config/Ultrahand\033[31m failed\033[0m."
else
    echo "Writing overlays.ini in ./config/Ultrahand\033[32m success\033[0m."
fi

### Rename /config/Ultrahand to /config/ultrahand 主题文件夹目前只识别小写
mv ./config/Ultrahand ./config/ultrahand

### Fetch ovl-sysmodules
#curl -sL https://raw.githubusercontent.com/gzk47/SwitchPlugins/main/plugins/ovl-sysmodules.zip -o ovl-sysmodules.zip
#if [ $? -ne 0 ]; then
#    echo "ovl-sysmodules download\033[31m failed\033[0m."
#else
#    echo "ovl-sysmodules download\033[32m success\033[0m."
#    unzip -oq ovl-sysmodules.zip
#    rm ovl-sysmodules.zip
#fi

## Fetch lastest ovl-sysmodules from https://github.com/zdm65477730/ovl-sysmodules/releases/latest
curl -H "$API_AUTH" -sL https://api.github.com/repos/zdm65477730/ovl-sysmodules/releases/latest \
  | jq '.tag_name' \
  | xargs -I {} echo ovl-sysmodules {} >> ../description.txt
curl -H "$API_AUTH" -sL https://api.github.com/repos/zdm65477730/ovl-sysmodules/releases/latest \
  | grep -oP '"browser_download_url": "\Khttps://[^"]*ovl-sysmodules[^"]*.zip"' \
  | sed 's/"//g' \
  | xargs -I {} curl -sL {} -o ovl-sysmodules.zip
if [ $? -ne 0 ]; then
    echo "ovl-sysmodules download\033[31m failed\033[0m."
else
    echo "ovl-sysmodules download\033[32m success\033[0m."
    unzip -oq ovl-sysmodules.zip
    rm ovl-sysmodules.zip
fi

### Write config.ini in /config/ovl-sysmodules/config.ini
cat > ./config/ovl-sysmodules/config.ini << ENDOFFILE
[ovl-sysmodules]
powerControlEnabled=1
wifiControlEnabled=1
sysmodulesControlEnabled=1
bootFileControlEnabled=1
hekateRestartControlEnabled=0
consoleRegionControlEnabled=1
ENDOFFILE

### Fetch StatusMonitor
#curl -sL #https://raw.githubusercontent.com/gzk47/SwitchPlugins/main/plugins/StatusMonitor.zip -o StatusMonitor.zip
#if [ $? -ne 0 ]; then
#    echo "StatusMonitor download\033[31m failed\033[0m."
#else
#    echo "StatusMonitor download\033[32m success\033[0m."
#    unzip -oq StatusMonitor.zip
#    rm StatusMonitor.zip
#fi

## Fetch lastest Status-Monitor-Overlay from https://github.com/zdm65477730/Status-Monitor-Overlay/releases/latest
curl -H "$API_AUTH" -sL https://api.github.com/repos/zdm65477730/Status-Monitor-Overlay/releases/latest \
  | jq '.tag_name' \
  | xargs -I {} echo StatusMonitor {} >> ../description.txt
curl -H "$API_AUTH" -sL https://api.github.com/repos/zdm65477730/Status-Monitor-Overlay/releases/latest \
  | grep -oP '"browser_download_url": "\Khttps://[^"]*StatusMonitor[^"]*.zip"' \
  | sed 's/"//g' \
  | xargs -I {} curl -sL {} -o StatusMonitor.zip
if [ $? -ne 0 ]; then
    echo "StatusMonitor download\033[31m failed\033[0m."
else
    echo "StatusMonitor download\033[32m success\033[0m."
    unzip -oq StatusMonitor.zip
    rm StatusMonitor.zip
fi

### Fetch EdiZon
#curl -sL https://raw.githubusercontent.com/gzk47/SwitchPlugins/main/plugins/EdiZon.zip -o EdiZon.zip
#if [ $? -ne 0 ]; then
#    echo "EdiZon download\033[31m failed\033[0m."
#else
#    echo "EdiZon download\033[32m success\033[0m."
#    unzip -oq EdiZon.zip
#    rm EdiZon.zip
#fi

## Fetch lastest EdiZon-Overlay from https://github.com/zdm65477730/EdiZon-Overlay/releases/latest
curl -H "$API_AUTH" -sL https://api.github.com/repos/zdm65477730/EdiZon-Overlay/releases/latest \
  | jq '.tag_name' \
  | xargs -I {} echo EdiZon {} >> ../description.txt
curl -H "$API_AUTH" -sL https://api.github.com/repos/zdm65477730/EdiZon-Overlay/releases/latest \
  | grep -oP '"browser_download_url": "\Khttps://[^"]*EdiZon[^"]*.zip"' \
  | sed 's/"//g' \
  | xargs -I {} curl -sL {} -o EdiZon.zip
if [ $? -ne 0 ]; then
    echo "EdiZon download\033[31m failed\033[0m."
else
    echo "EdiZon download\033[32m success\033[0m."
    unzip -oq EdiZon.zip
    rm EdiZon.zip
fi

### Fetch ReverseNX-RT
#curl -sL https://raw.githubusercontent.com/gzk47/SwitchPlugins/main/plugins/ReverseNX-RT.zip -o ReverseNX-RT.zip
#if [ $? -ne 0 ]; then
#    echo "ReverseNX-RT download\033[31m failed\033[0m."
#else
#    echo "ReverseNX-RT download\033[32m success\033[0m."
#    unzip -oq ReverseNX-RT.zip
#    rm ReverseNX-RT.zip
#    rm -rf SaltySD/patches
#fi

## Fetch lastest ReverseNX-RT from https://github.com/zdm65477730/ReverseNX-RT/releases/latest
curl -H "$API_AUTH" -sL https://api.github.com/repos/zdm65477730/ReverseNX-RT/releases/latest \
  | jq '.tag_name' \
  | xargs -I {} echo ReverseNX-RT {} >> ../description.txt
curl -H "$API_AUTH" -sL https://api.github.com/repos/zdm65477730/ReverseNX-RT/releases/latest \
  | grep -oP '"browser_download_url": "\Khttps://[^"]*ReverseNX-RT[^"]*.zip"' \
  | sed 's/"//g' \
  | xargs -I {} curl -sL {} -o ReverseNX-RT.zip
if [ $? -ne 0 ]; then
    echo "ReverseNX-RT download\033[31m failed\033[0m."
else
    echo "ReverseNX-RT download\033[32m success\033[0m."
    unzip -oq ReverseNX-RT.zip
    rm ReverseNX-RT.zip
    rm -rf SaltySD/patches
fi

### Fetch lastest FPSLocker-Warehouse from https://github.com/masagrator/FPSLocker-Warehouse
git clone https://github.com/masagrator/FPSLocker-Warehouse
if [ $? -ne 0 ]; then
    echo "FPSLocker-Warehouse download\033[31m failed\033[0m."
else
    echo "FPSLocker-Warehouse download\033[32m success\033[0m."
    rm -rf SaltySD/plugins/FPSLocker/patches
    mv -f FPSLocker-Warehouse/SaltySD/plugins/FPSLocker/patches ./SaltySD/plugins/FPSLocker/
    rm -rf FPSLocker-Warehouse
fi

### Fetch sys-clk
#curl -sL https://raw.githubusercontent.com/gzk47/SwitchPlugins/main/plugins/sys-clk.zip -o sys-clk.zip
#if [ $? -ne 0 ]; then
#    echo "sys-clk download\033[31m failed\033[0m."
#else
#    echo "sys-clk download\033[32m success\033[0m."
#    unzip -oq sys-clk.zip
#    rm sys-clk.zip
#fi

## Fetch lastest sys-clk from https://github.com/zdm65477730/sys-clk/releases/latest
curl -H "$API_AUTH" -sL https://api.github.com/repos/zdm65477730/sys-clk/releases/latest \
  | jq '.tag_name' \
  | xargs -I {} echo sys-clk {} >> ../description.txt
curl -H "$API_AUTH" -sL https://api.github.com/repos/zdm65477730/sys-clk/releases/latest \
  | grep -oP '"browser_download_url": "\Khttps://[^"]*sys-clk[^"]*.zip"' \
  | sed 's/"//g' \
  | xargs -I {} curl -sL {} -o sys-clk.zip
if [ $? -ne 0 ]; then
    echo "sys-clk download\033[31m failed\033[0m."
else
    echo "sys-clk download\033[32m success\033[0m."
    unzip -oq sys-clk.zip
    rm sys-clk.zip
fi

### Fetch emuiibo
#curl -sL https://raw.githubusercontent.com/gzk47/SwitchPlugins/main/plugins/emuiibo.zip -o emuiibo.zip
#if [ $? -ne 0 ]; then
#    echo "emuiibo download\033[31m failed\033[0m."
#else
#    echo "emuiibo download\033[32m success\033[0m."
#    unzip -oq emuiibo.zip
#    rm emuiibo.zip
#fi

## Fetch lastest emuiibo from https://github.com/zdm65477730/emuiibo/releases/latest
curl -H "$API_AUTH" -sL https://api.github.com/repos/zdm65477730/emuiibo/releases/latest \
  | jq '.tag_name' \
  | xargs -I {} echo emuiibo {} >> ../description.txt
curl -H "$API_AUTH" -sL https://api.github.com/repos/zdm65477730/emuiibo/releases/latest \
  | grep -oP '"browser_download_url": "\Khttps://[^"]*emuiibo[^"]*.zip"' \
  | sed 's/"//g' \
  | xargs -I {} curl -sL {} -o emuiibo.zip
if [ $? -ne 0 ]; then
    echo "emuiibo download\033[31m failed\033[0m."
else
    echo "emuiibo download\033[32m success\033[0m."
    unzip -oq emuiibo.zip
    rm emuiibo.zip
fi

### Fetch ldn_mitm
#curl -sL https://raw.githubusercontent.com/gzk47/SwitchPlugins/main/plugins/ldn_mitm.zip -o ldn_mitm.zip
#if [ $? -ne 0 ]; then
#    echo "ldn_mitm download\033[31m failed\033[0m."
#else
#    echo "ldn_mitm download\033[32m success\033[0m."
#    unzip -oq ldn_mitm.zip
#    rm ldn_mitm.zip
#fi

## Fetch lastest ldn_mitm from https://github.com/zdm65477730/ldn_mitm/releases/latest
curl -H "$API_AUTH" -sL https://api.github.com/repos/zdm65477730/ldn_mitm/releases/latest \
  | jq '.tag_name' \
  | xargs -I {} echo ldn_mitm {} >> ../description.txt
curl -H "$API_AUTH" -sL https://api.github.com/repos/zdm65477730/ldn_mitm/releases/latest \
  | grep -oP '"browser_download_url": "\Khttps://[^"]*ldn_mitm[^"]*.zip"' \
  | sed 's/"//g' \
  | xargs -I {} curl -sL {} -o ldn_mitm.zip
if [ $? -ne 0 ]; then
    echo "ldn_mitm download\033[31m failed\033[0m."
else
    echo "ldn_mitm download\033[32m success\033[0m."
    unzip -oq ldn_mitm.zip
    rm ldn_mitm.zip
fi

### Fetch QuickNTP
#curl -sL https://raw.githubusercontent.com/gzk47/SwitchPlugins/main/plugins/QuickNTP.zip -o QuickNTP.zip
#if [ $? -ne 0 ]; then
#    echo "QuickNTP download\033[31m failed\033[0m."
#else
#    echo "QuickNTP download\033[32m success\033[0m."
#    unzip -oq QuickNTP.zip
#    rm QuickNTP.zip
#fi

## Fetch lastest QuickNTP from https://github.com/zdm65477730/QuickNTP/releases/latest
curl -H "$API_AUTH" -sL https://api.github.com/repos/zdm65477730/QuickNTP/releases/latest \
  | jq '.tag_name' \
  | xargs -I {} echo QuickNTP {} >> ../description.txt
curl -H "$API_AUTH" -sL https://api.github.com/repos/zdm65477730/QuickNTP/releases/latest \
  | grep -oP '"browser_download_url": "\Khttps://[^"]*QuickNTP[^"]*.zip"' \
  | sed 's/"//g' \
  | xargs -I {} curl -sL {} -o QuickNTP.zip
if [ $? -ne 0 ]; then
    echo "QuickNTP download\033[31m failed\033[0m."
else
    echo "QuickNTP download\033[32m success\033[0m."
    unzip -oq QuickNTP.zip
    rm QuickNTP.zip
fi

### sysDvr
#curl -sL https://raw.githubusercontent.com/gzk47/SwitchPlugins/main/plugins/SysDVR.zip -o SysDVR.zip
#if [ $? -ne 0 ]; then
#    echo "SysDVR download\033[31m failed\033[0m."
#else
#    echo "SysDVR download\033[32m success\033[0m."
#    unzip -oq SysDVR.zip
#    rm SysDVR.zip
#fi

## Fetch lastest sysdvr-overlay from https://github.com/zdm65477730/sysdvr-overlay/releases/latest
curl -H "$API_AUTH" -sL https://api.github.com/repos/zdm65477730/sysdvr-overlay/releases/latest \
  | jq '.tag_name' \
  | xargs -I {} echo SysDVR {} >> ../description.txt
curl -H "$API_AUTH" -sL https://api.github.com/repos/zdm65477730/sysdvr-overlay/releases/latest \
  | grep -oP '"browser_download_url": "\Khttps://[^"]*SysDVR[^"]*.zip"' \
  | sed 's/"//g' \
  | xargs -I {} curl -sL {} -o SysDVR.zip
if [ $? -ne 0 ]; then
    echo "SysDVR download\033[31m failed\033[0m."
else
    echo "SysDVR download\033[32m success\033[0m."
    unzip -oq SysDVR.zip
    rm SysDVR.zip
fi

#### Fetch Fizeau
#curl -sL https://raw.githubusercontent.com/gzk47/SwitchPlugins/main/plugins/Fizeau.zip -o Fizeau.zip
#if [ $? -ne 0 ]; then
#    echo "Fizeau download\033[31m failed\033[0m."
#else
#    echo "Fizeau download\033[32m success\033[0m."
#    unzip -oq Fizeau.zip
#    rm Fizeau.zip
#fi

#### Fetch Zing
#curl -sL https://raw.githubusercontent.com/gzk47/SwitchPlugins/main/plugins/Zing.zip -o Zing.zip
#if [ $? -ne 0 ]; then
#    echo "Zing download\033[31m failed\033[0m."
#else
#    echo "Zing download\033[32m success\033[0m."
#    unzip -oq Zing.zip
#    rm Zing.zip
#fi

#### Fetch sys-tune
#curl -sL https://raw.githubusercontent.com/gzk47/SwitchPlugins/main/plugins/sys-tune.zip -o sys-tune.zip
#if [ $? -ne 0 ]; then
#    echo "sys-tune download\033[31m failed\033[0m."
#else
#    echo "sys-tune download\033[32m success\033[0m."
#    unzip -oq sys-tune.zip
#    rm sys-tune.zip
#fi

###
#cat >> ../description.txt << ENDOFFILE

#nx-ovlloader
#Tesla-Menu
#ovl-sysmodules
#StatusMonitor
#EdiZon
#ReverseNX-RT
#sys-clk
#emuiibo
#ldn_mitm
#QuickNTP
#SysDVR

#ENDOFFILE
###

### Fetch MissionControl from https://github.com//ndeadly/MissionControl/releases/latest
curl -H "$API_AUTH" -sL https://api.github.com/repos/ndeadly/MissionControl/releases/latest \
  | jq '.tag_name' \
  | xargs -I {} echo MissionControl {} >> ../description.txt
curl -H "$API_AUTH" -sL https://api.github.com/repos/ndeadly/MissionControl/releases/latest \
  | grep -oP '"browser_download_url": "\Khttps://[^"]*MissionControl[^"]*.zip"' \
  | sed 's/"//g' \
  | xargs -I {} curl -sL {} -o MissionControl.zip
if [ $? -ne 0 ]; then
    echo "MissionControl download\033[31m failed\033[0m."
else
    echo "MissionControl download\033[32m success\033[0m."
    unzip -oq MissionControl.zip
    rm MissionControl.zip
fi

## Fetch lastest sys-con from https://github.com/o0Zz/sys-con/releases/latest
curl -H "$API_AUTH" -sL https://api.github.com/repos/o0Zz/sys-con/releases/latest \
  | jq '.name' \
  | xargs -I {} echo sys-con {} >> ../description.txt
curl -H "$API_AUTH" -sL https://api.github.com/repos/o0Zz/sys-con/releases/latest \
  | grep -oP '"browser_download_url": "\Khttps://[^"]*sys-con[^"]*.zip"' \
  | sed 's/"//g' \
  | xargs -I {} curl -sL {} -o sys-con.zip
if [ $? -ne 0 ]; then
    echo "sys-con download\033[31m failed\033[0m."
else
    echo "sys-con download\033[32m success\033[0m."
    unzip -oq sys-con.zip
    rm sys-con.zip
fi

# -------------------------------------------

###
cat >> ../description.txt << ENDOFFILE
 
------------------------------
 
极限超频替换包：（ 覆盖到【特斯拉版】心悦整合包上替换 ）
 
ENDOFFILE
###

### Fetch latest EOS-OC-Suite sys-clk.zip from https://github.com/halop/OC_Toolkit_SC_EOS/releases/latest
curl -H "$API_AUTH" -sL https://api.github.com/repos/halop/OC_Toolkit_SC_EOS/releases/latest \
  | jq '.tag_name' \
  | xargs -I {} echo EOS{}-OC-Suite >> ../description.txt
 
# -------------------------------------------


# -------------------------------------------

### Delete unneeded files
rm -f bootloader/res/icon_payload.bmp
rm -f bootloader/res/icon_switch.bmp
rm -f switch/haze.nro
rm -f switch/reboot_to_hekate.nro
rm -f switch/reboot_to_payload.nro
rm -rf mods

### Delete boot2 files
rm -f atmosphere/contents/00FF0000A53BB665/flags/*.*
#00FF0000A53BB665--SysDVR
rm -f atmosphere/contents/00FF0000636C6BFF/flags/*.*
#00FF0000636C6BFF--sys-clk
rm -f atmosphere/contents/0000000000534C56/flags/*.*
#0000000000534C56--SaltyNX
rm -f atmosphere/contents/010000000000bd00/flags/*.*
#010000000000bd00--MissionControl
rm -f atmosphere/contents/0100000000000F12/flags/*.*
#0100000000000f12--Fizeau
rm -f atmosphere/contents/0100000000000352/flags/*.*
#0100000000000352--emuiibo
rm -f atmosphere/contents/690000000000000D/flags/*.*
#690000000000000D--sys-con
rm -f atmosphere/contents/4200000000000010/flags/*.*
#4200000000000010--ldn_mitm

# -------------------------------------------


### Fetch readme
curl -sL https://raw.githubusercontent.com/gzk47/SwitchPlugins/main/sys/readme.txt -o readme.txt
if [ $? -ne 0 ]; then
    echo "readme download\033[31m failed\033[0m."
else
    echo "readme download\033[32m success\033[0m."
    mv readme.txt ZDM特斯拉插件v$(date +%Y%m%d).txt

fi


# -------------------------------------------

###
cat >> ../description.txt << ENDOFFILE
 
------------------------------
 
SwitchSD-Pure  为：纯净版
SwitchSD-Tesla 为：特斯拉版
SwitchSD       为：特斯拉版+sys-patch
EOS-OC-Suite   为：极限超频替换包
 
ENDOFFILE
###

# -------------------------------------------

echo ""
echo "\033[32mYour ZDM-Tesla card is prepared!\033[0m"
