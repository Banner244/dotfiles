import Quickshell
import QtQuick
import QtQuick.Layouts
import "Widgets" as Widgets
import "Logic" as Logic

Scope {
    Variants {
        model: Quickshell.screens
        
        PanelWindow {
            id: panel
            required property var modelData
            screen: modelData
            
            // ---------- Position & Scaling  ----------
            anchors.top: true
            color: "transparent"
            //margins.top: 2

            height: 34 * (screen.devicePixelRatio > 0 ? screen.devicePixelRatio : 1)
            width: modelData.width * 0.9

            // ---------------- Background ----------------
            Rectangle {
                anchors.fill: parent
                color: "#222222" 
                radius: 8 
                opacity: 1
                border.color: "#2F2F2F"
                border.width: 3
            }

            // ---------------- Widgets ----------------
            RowLayout {
                uniformCellSizes: true
                anchors.fill: parent
                spacing: 10

                anchors.leftMargin: 7 * screen.devicePixelRatio
                anchors.rightMargin: 7 * screen.devicePixelRatio
                
                // ---------------- Left ----------------
                RowLayout {
                    spacing: 20
                    
                    RowLayout {  Widgets.WorkspacesWidget { } }
                    RowLayout {
                        Widgets.SystemTrayWidget { 
                            panelWindow: panel
                        } 
                    }
                }
                // ---------------- Center Left----------------
                RowLayout {
                    Layout.alignment: Qt.AlignHCenter
                    spacing: 5
   
                    RowLayout { Widgets.SpotifyWidget{ } }
                }
                // ---------------- Center ----------------
                RowLayout {
                    Layout.alignment: Qt.AlignHCenter
                    spacing: 5
                    RowLayout { Widgets.ClockWidget{ } }
                    RowLayout { Widgets.CalendarWidget{ } }
                    
                }
                // ---------------- Center Right----------------
                RowLayout {
                    Layout.alignment: Qt.AlignHCenter
                    spacing: 15
   
                    RowLayout { Widgets.CPUWidget{ } }
                    RowLayout { Widgets.RAMWidget{ } }

                }
                // ---------------- Right----------------
                RowLayout {
                    Layout.alignment: Qt.AlignRight
                    spacing: 25
                    RowLayout {  Widgets.AudioWidget{ } }

                    /* ######## Bluetooth ######## */
                    Loader {
                        id:bluetoothLoader
                        active: Logic.BluetoothManager.deviceFound
                        visible: active && item !== null
                        sourceComponent: RowLayout{ Widgets.BluetoothWidget{ } }
                    }
                    // Check every 2 sec. if device is found
                    Timer {
                        interval: 2000     // 2 Sek
                        running: true
                        repeat: true
                        onTriggered: {
                            bluetoothLoader.active = Logic.BluetoothManager.deviceFound
                        }
                    }
                    /* ################ */

                    RowLayout { Widgets.InternetWidget{ } }
                }
            }
        }
    }
}

