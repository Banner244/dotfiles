import QtQuick 
import QtQuick.Layouts 
import "../Logic/" as Logic

RowLayout {
    id: cpuRoot
    spacing: 4

    // Icon
    Image {
        id: cpuIcon
        source: Logic.Paths.cpu
    }

    // Text
    Text {
        text: Logic.CPUData.usage + "%"
        font.pixelSize: 12 
        color: "white"
        font.bold: true
    }
}

