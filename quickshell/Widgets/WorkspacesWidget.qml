// WorkspaceWidget.qml
import QtQuick
import Quickshell.Hyprland
import QtQuick.Layouts

RowLayout {
  id: workspaceRoot
  spacing: 6
  Repeater {
  model: Hyprland.workspaces
    delegate: Rectangle {
      id: wsRect
      width: 28
      height: 20
      radius: 6

      required property var modelData

      // Dinamic Color Binding
      color: hoverArea.containsMouse
             ? "#877"   // Hover
             : (Hyprland.focusedWorkspace && Hyprland.focusedWorkspace.id === modelData.id
                ? "#FFF"  // Activ
                : "#777")     // Inactiv

      Text {
          anchors.centerIn: parent
          text: modelData.name === "special:magic" ? "🥸" : modelData.name
          font.bold: true
          font.pixelSize: 12
          color: "#112"
      }

      MouseArea {
          id: hoverArea
          anchors.fill: parent
          hoverEnabled: true
          onClicked: Hyprland.dispatch("workspace name:" + modelData.name)
      }
    }
  }
}

