import QtQuick 2.15
import QtQuick.Layouts 1.15

Rectangle {
    id: hoverBtn
    property string text: ""    
    signal clicked

    Layout.fillWidth: true
    radius: 6
    implicitWidth: label.implicitWidth   
    implicitHeight: label.implicitHeight  
    color: "#DDD"

    Text {
        id: label
        anchors.centerIn: parent
        text: hoverBtn.text      
        color: "#222"
    }

    MouseArea {
        id: hoverArea
        anchors.fill: parent
        hoverEnabled: true

        onEntered: hoverBtn.color = "#777"
        onExited:  hoverBtn.color = "#DDD"
        onClicked: hoverBtn.clicked() // link Signal 
    }
}

