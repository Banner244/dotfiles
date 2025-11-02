import QtQuick 2.15
import QtQuick.Layouts 1.15

Rectangle {
    id: hoverBtn
    property string source: ""    
    signal clicked

    Layout.fillWidth: true
    radius: 6
    //width: 28
    //height: 25
    implicitWidth: label.implicitWidth   
    implicitHeight: label.implicitHeight  
    color: "#DDD"
    Image{
        id: label
        anchors.centerIn: parent
        source: hoverBtn.source 
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

