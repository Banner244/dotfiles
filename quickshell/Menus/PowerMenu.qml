import Quickshell
import QtQuick
import QtQuick.Layouts
import Quickshell.Io
import "../Elements" as Elements
import "../Logic/" as Logic

PanelWindow{
    id: powerRoot
    width: 18
    height: 18
    anchors.top: true
    anchors.right: true
    exclusionMode: "Ignore" // Ignoring the "Bar.qml"
    color: "transparent" 

    Text {
        y: 0
        x: 0
        text: " "
    }

    // open popupWindow
    MouseArea {
        anchors.fill: parent
        hoverEnabled: true
        onEntered: {
            popupWindow.showPopup()
        }
    }
    // Popup - Window 
    Window {
        id: popupWindow
        width: 95
        height: 50
        visible: false
        x: 0
        y: 0
        flags: Qt.Popup | Qt.FramelessWindowHint | Qt.WindowStaysOnTopHint
        color: "transparent" 

        // Animation values
        property real animScale: 0.8
        property real animOpacity: 0
        property real animY: 0
        Behavior on animScale { NumberAnimation { duration: 350; easing.type: Easing.InOutQuad } }
        Behavior on animOpacity { NumberAnimation { duration: 350; easing.type: Easing.InOutQuad } }
        Behavior on animY { NumberAnimation { duration: 350; easing.type: Easing.InOutQuad } }

        Rectangle {
          anchors.fill: parent
          color: "#2c2c2c"
          radius: 10
          border.color: "#555555"
          border.width: 1
            scale: popupWindow.animScale
            opacity: popupWindow.animOpacity
            y: popupWindow.animY
        }

        ColumnLayout {                
            anchors.fill: parent
            spacing: 5 
            anchors.margins: 5
            uniformCellSizes: true
            RowLayout {
                uniformCellSizes: true
                spacing: 5 
                Elements.ImageButton {
                    id: powerButton
                    source: Logic.Paths.shutdown 
                    onClicked: shutdownProc.running = true
                    opacity: popupWindow.animOpacity
                    scale: popupWindow.animScale
                }
                Elements.ImageButton {
                    source: Logic.Paths.reboot
                    onClicked: rebootProc.running = true
                    implicitHeight: powerButton.height
                    opacity: popupWindow.animOpacity
                    scale: popupWindow.animScale
                }
            }        
            RowLayout {
                uniformCellSizes: true
                spacing: 5 
                Elements.ImageButton {
                    source: Logic.Paths.lock
                    onClicked: lockProc.running = true
                    implicitHeight: powerButton.height
                    opacity: popupWindow.animOpacity
                    scale: popupWindow.animScale
                }
                Elements.ImageButton {
                    source: Logic.Paths.suspend 
                    onClicked: suspendProc.running = true
                    implicitHeight: powerButton.height
                    opacity: popupWindow.animOpacity
                    scale: popupWindow.animScale 
                }      
            } 
        }
        function showPopup() {
            popupWindow.visible = true
            animScale = 1
            animOpacity = 1
            animY = 0
        }
        onClosing:{
            animScale = 0.8
            animOpacity = 0
            animY = -10
        }

        Process { id: shutdownProc; command: ["shutdown", "now"]; running: false }
        Process { id: rebootProc; command: ["reboot"]; running: false }
        Process { id: suspendProc; command: ["systemctl", "suspend"]; running: false }
        Process { id: lockProc;   command: ["loginctl", "lock-session"]; running: false }
    }
}
