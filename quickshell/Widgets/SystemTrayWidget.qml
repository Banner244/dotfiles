import QtQuick
import Quickshell
import Quickshell.Services.SystemTray
import Quickshell.Widgets 
import QtQuick.Layouts
import "../Logic/" as Logic
RowLayout {
    id: trayRoot
    property var panelWindow
    anchors.fill: parent
    spacing: 6
    // Repeater for the SystemTray.items
    Repeater {
        model: SystemTray.items

        delegate: Item{
            id: delegateRoot
            required property var modelData
            width: 28
            height: 24

            IconImage {
                id: trayIcon
                anchors.centerIn: parent
                implicitWidth: 18; implicitHeight: 18
                source: delegateRoot.resolveIcon()
            }
            // show icon Icon (modelData.icon is Path/URL)
            function resolveIcon() {
                var title = (delegateRoot.modelData.title || "").toLowerCase()

                
                if (title.indexOf("spotify") !== -1) {
                    return Logic.Paths.spotify
                }
                if (title.indexOf("steam") !== -1) {
                    return Logic.Paths.steam
                }

                
                var icon = delegateRoot.modelData.icon
                if (icon && icon !== "") {
                    // if it contains  "?path=" → Pfad extract
                    var m = icon.match(/path=([^&]+)/)
                    if (m && m[1]) {
                        try { return "file://" + decodeURIComponent(m[1]) } catch(e) { return "file://" + m[1] }
                    }

                    if (icon.indexOf("file://") === 0) return icon
                    if (icon.indexOf("/") === 0) return "file://" + icon

                    return icon
                }

                // 3) Generic Fallback
                return "file:///usr/share/icons/hicolor/24x24/apps/application-default-icon.png"
            }

            MouseArea {
                anchors.fill: parent
                acceptedButtons: Qt.LeftButton | Qt.RightButton
                hoverEnabled: true

                onPressed: (mouse) => {
                    if (mouse.button === Qt.LeftButton) {
                        if (!delegateRoot.modelData.onlyMenu) {
                            delegateRoot.modelData.activate()
                        } else if (delegateRoot.modelData.hasMenu) {
                            menuAnchor.open()
                        }
                    } else if (mouse.button === Qt.RightButton) {
                        if (delegateRoot.modelData.hasMenu) {
                            menuAnchor.open()
                        }
                    }
                }
            }

            QsMenuAnchor {
              id: menuAnchor
                menu: delegateRoot.modelData.menu
                anchor.window: trayRoot.panelWindow
                anchor.item: delegateRoot
            }
        } // delegate
    } // Repeater
} // RowLayout
