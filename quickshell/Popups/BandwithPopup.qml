import QtQuick 
import "../Logic" as Logic
Window {
    id: popupWindow
    //width: 245
    //height: 50
    visible: false
    flags: Qt.Popup | Qt.FramelessWindowHint | Qt.WindowStaysOnTopHint
    color: "transparent" 

    property real scaleFactor: screen.devicePixelRatio

    Rectangle {
        id: layout
      anchors.fill: parent
      color: "#2c2c2c"
      radius: 10
      border.color: "#555555"
      border.width: 1
      Text {
          id: textBandwith
          anchors.centerIn: parent
          text: Logic.Ethernet.download + "    " + Logic.Ethernet.upload + " " 
          color: "white"
          font.bold: true
          font.pixelSize: 14 * popupWindow.scaleFactor
          onTextChanged: {
              popupWindow.adjustWindowSize()
          }
      }
      // ---------------- Dynamic Size ----------------
        Component.onCompleted: {
            popupWindow.adjustWindowSize()
        }
  }
    function adjustWindowSize() {
        // dynamic window size
        popupWindow.width = textBandwith.implicitWidth + (20 * popupWindow.scaleFactor)
        popupWindow.height = textBandwith.implicitHeight + (20 * popupWindow.scaleFactor)
    }
}
