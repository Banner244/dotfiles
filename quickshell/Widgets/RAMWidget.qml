import QtQuick 
import QtQuick.Layouts 
import "../Logic/" as Logic

RowLayout {
    spacing: 4
    Image {
        source: Logic.Paths.ram
    }
    Text {
        text: Logic.RAM.text
        font.pixelSize: 12
        color: "white"
        font.bold: true
    }
}

