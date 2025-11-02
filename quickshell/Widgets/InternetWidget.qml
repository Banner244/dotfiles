// InternetWidget.qml
import QtQuick 
import QtQuick.Layouts 
import "../Logic/" as Logic
import "../Popups" as Popups
import "../Elements" as Elements
Item {
    id: netRoot
    implicitWidth: 18 
    implicitHeight: 18 

    // Symbol
    Image {
        id: img 
        anchors.centerIn: parent
        source: Logic.ConnectionType.connection 
    }

    MouseArea {
        anchors.fill: parent
        onClicked: {
            popupWindow.x = netRoot.mapToGlobal(Qt.point(0, netRoot.width/2)).x - popupWindow.width/2
            popupWindow.y = netRoot.mapToGlobal(Qt.point(0, netRoot.height)).y
            popupWindow.visible = !popupWindow.visible
        }
        hoverEnabled: true
        onEntered: img.scale = 1.1
        onExited: img.scale = 1.0
    }
    /*Popups.BandwithPopup{
        id: popupWindow
    }*/
 Window {
        id: popupWindow
        //width: 245
        //height: 50
        visible: false
        flags: Qt.Popup | Qt.FramelessWindowHint | Qt.WindowStaysOnTopHint
        color: "transparent" 

        property real scaleFactor: screen.devicePixelRatio

        Rectangle {
          anchors.fill: parent
          color: "#2c2c2c"
          radius: 10
          border.color: "#555555"
          border.width: 1
        
          ColumnLayout{
          id: layout
          anchors.centerIn: parent
          spacing : 10
          /*Elements.HoverButton {
              id: statusChangeButton
              text: Logic.BluetoothManager.active ? "Activate" : "Disable"
              onClicked: {

                if(Logic.BluetoothManager.active) {
                  Logic.BluetoothManager.disableBluetooth()
                } else {
                  Logic.BluetoothManager.enableBluetooth()
                }
                popupWindow.visible = false
              }
            }*/
            /*Text {
          anchors.centerIn: parent
              text: Logic.Ethernet.download + "    " + Logic.Ethernet.upload + " " 
            }*/
          Elements.HoverButton {
              id: managerButton
              text: "  Manager  "
              onClicked: {
                Logic.ConnectionType.openManager()
                popupWindow.visible = false
              }
              implicitWidth: 130 * screen.devicePixelRatio          
            }
          // ---------------- Dynamic Size----------------
            Component.onCompleted: {
                popupWindow.adjustWindowSize()
            }
          }
        }

        /*Timer {
            interval: 500
            running: true
            repeat: true
            onTriggered: {
              if(Logic.BluetoothManager.active) {
                statusChangeButton.text = "Disable"
              } else {
                statusChangeButton.text = "Activate"
              }
            }
          }*/
        function adjustWindowSize() {
            // dynamic window size
            popupWindow.width = layout.implicitWidth + (10 * popupWindow.scaleFactor)
            popupWindow.height = layout.implicitHeight + (10 * popupWindow.scaleFactor)
        }
    }
}
