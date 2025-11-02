// Paths.qml
pragma Singleton
import QtQuick
import Qt.labs.platform

QtObject {
    readonly property string home: StandardPaths.writableLocation(StandardPaths.HomeLocation)

    readonly property string audioMuted: home + "/.icons/Papirus-Dark/24x24/panel/audio-volume-muted.svg" 
    readonly property string audioLow: home + "/.icons/Papirus-Dark/24x24/panel/audio-volume-low.svg"
    readonly property string audioMedium: home + "/.icons/Papirus-Dark/24x24/panel/audio-volume-medium.svg"
    readonly property string audioHigh: home + "/.icons/Papirus-Dark/24x24/panel/audio-volume-high.svg"

    readonly property string micMuted: home + "/.icons/Papirus-Dark/24x24/panel/mic-volume-muted.svg"
    readonly property string micLow: home + "/.icons/Papirus-Dark/24x24/panel/mic-volume-low.svg"
    readonly property string micMedium: home + "/.icons/Papirus-Dark/24x24/panel/mic-volume-medium.svg"
    readonly property string micHigh: home + "/.icons/Papirus-Dark/24x24/panel/mic-volume-high.svg"

    readonly property string ethernetConnected: home + "/.icons/Papirus-Dark/24x24/panel/network-wired-activated.svg"
    readonly property string ethernetDisconnected: home + "/.icons/Papirus-Dark/24x24/panel/network-wired-unavailable.svg"
    readonly property string bluetoothConnected: home + "/.icons/Papirus-Dark/24x24/panel/bluetooth-active.svg"
    readonly property string bluetoothDisconnected: home + "/.icons/Papirus-Dark/24x24/panel/bluetooth-disabled.svg"
    readonly property string wifiHigh: home + "/.icons/Papirus-Dark/24x24/panel/both-high-signal.svg"
    readonly property string wifiGood: home + "/.icons/Papirus-Dark/24x24/panel/both-good-signal.svg"
    readonly property string wifiLow: home + "/.icons/Papirus-Dark/24x24/panel/both-low-signal.svg"

    readonly property string cpu: home + "/.icons/Papirus-Dark/24x24/panel/indicator-sensors-cpu.svg"
    //readonly property string cpu: home + "/.icons/Papirus-Dark/24x24/panel/cpufreq-icon.svg"
    readonly property string ram: home + "/.icons/Papirus-Dark/24x24/panel/indicator-sensors-memory.svg"

    readonly property string miniCalendar: home + "/.icons/Papirus-Dark/24x24/panel/mini-calendar.svg"

    readonly property string mediaPause: home + "/.icons/Papirus-Dark/24x24/actions/gtk-media-pause.svg"
    readonly property string mediaPlay: home + "/.icons/Papirus-Dark/24x24/actions/gtk-media-play-ltr.svg"
    readonly property string mediaPrevious: home + "/.icons/Papirus-Dark/24x24/actions/gtk-media-previous-ltr.svg"
    readonly property string mediaNext: home + "/.icons/Papirus-Dark/24x24/actions/gtk-media-previous-rtl.svg"

    readonly property string steam: home + "/.icons/Papirus-Dark/24x24/apps/steam.svg"
    readonly property string spotify: home + "/.icons/Papirus-Dark/24x24/apps/spotify.svg"

    readonly property string shutdown: home + "/.config/quickshell/icons/adwaita/actions/system-shutdown-symbolic.svg"
    readonly property string suspend: home + "/.config/quickshell/icons/adwaita/actions/media-playback-pause-symbolic.svg"
    readonly property string reboot: home + "/.config/quickshell/icons/adwaita/actions/system-reboot-symbolic.svg"
    readonly property string lock: home + "/.config/quickshell/icons/adwaita/status/system-lock-screen-symbolic.svg"

    readonly property string wallpaper: home + "/.config/quickshell/icons/adwaita/categories/applications-graphics-symbolic.svg"
}
