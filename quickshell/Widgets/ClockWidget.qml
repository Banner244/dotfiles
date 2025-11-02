import QtQuick 
import QtQuick.Layouts
import "../Logic/" as Logic 

RowLayout {
    spacing: 4
    anchors.centerIn: parent
    id: clockRow

    // ---------------- Time Text ----------------
    Text {
        id: timeText
        text: Logic.Time.time
        color: "white"
        font.bold: true
    }
}

