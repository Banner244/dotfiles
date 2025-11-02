import QtQuick
import QtQuick.Layouts

Window {
    id: calendar

    property var today: new Date()
    property int currentYear: today.getFullYear()
    property int currentMonth: today.getMonth()
    property int currentDay: today.getDate()

    property real scaleFactor: screen.devicePixelRatio

    visible: false
    flags: Qt.Popup | Qt.FramelessWindowHint | Qt.WindowStaysOnTopHint
    color: "transparent"

    Rectangle {
        anchors.fill: parent
        color: "#2c2c2c"
        radius: 10 * scaleFactor
        border.color: "#555555"
        border.width: 1 * scaleFactor

        ColumnLayout {
            id: layout
            anchors.centerIn: parent
            anchors.margins: 10 * scaleFactor
            spacing: 6 * scaleFactor
            Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter

            RowLayout {
                Layout.alignment: Qt.AlignHCenter
                Text {
                    text: Qt.formatDate(new Date(currentYear, currentMonth), "MMMM yyyy")
                    color: "white"
                    font.bold: true
                    font.pixelSize: 14 * scaleFactor
                }
            }

            // Weekday-Header
            GridLayout {
                columns: 7
                columnSpacing: 6 * scaleFactor
                Layout.alignment: Qt.AlignHCenter

                Repeater {
                    model: ["Mo","Di","Mi","Do","Fr","Sa","So"]
                    delegate: Text {
                        text: modelData
                        color: "#aaa"
                        font.bold: true
                        font.pixelSize: 11 * scaleFactor
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                        Layout.preferredWidth: 28 * scaleFactor
                        Layout.preferredHeight: 20 * scaleFactor
                    }
                }
            }

            // Days of the month
            GridLayout {
                id: gridRoot
                columns: 7
                columnSpacing: 6 * scaleFactor
                rowSpacing: 6 * scaleFactor
                Layout.alignment: Qt.AlignHCenter

                property int daysInMonth: new Date(calendar.currentYear, calendar.currentMonth + 1, 0).getDate()

                property int startIndex: (function() {
                    var d = new Date(calendar.currentYear, calendar.currentMonth, 1).getDay(); 
                    return (d + 6) % 7; 
                })()
                property int todayDay: (calendar.currentYear === calendar.today.getFullYear()
                                         && calendar.currentMonth === calendar.today.getMonth())
                                        ? calendar.today.getDate() : -1

                Repeater {
                    model: gridRoot.startIndex + gridRoot.daysInMonth
                    delegate: Rectangle {
                        id: dayRect
                        width: 28 * scaleFactor
                        height: 28 * scaleFactor
                        radius: 4 * scaleFactor

                        property int dayNum: index - gridRoot.startIndex + 1

                        // Background for existing days
                        color: (dayNum >= 1 && dayNum <= gridRoot.daysInMonth)
                            ? (dayNum === gridRoot.todayDay ? "#4CAF50" : "#555555")
                            : "transparent"

                        Text {
                            anchors.centerIn: parent
                            text: (dayNum >= 1 && dayNum <= gridRoot.daysInMonth) ? dayNum.toString() : ""
                            color: "#fff"
                            font.pixelSize: 11 * scaleFactor
                        }

                        MouseArea {
                            anchors.fill: parent
                            hoverEnabled: true
                            onEntered: dayRect.scale = 1.08
                            onExited: dayRect.scale = 1.0
                            onClicked: {
                                if (dayNum >= 1 && dayNum <= gridRoot.daysInMonth) {
                                    console.log("Day clicked:", dayNum, calendar.currentMonth + 1, calendar.currentYear)
                                }
                            }
                        }
                    }
                }
            }
        }
    }

    Component.onCompleted: {
        // dynamic Window-Size
        calendar.width = layout.implicitWidth + (20 * scaleFactor)
        calendar.height = layout.implicitHeight + (20 * scaleFactor)
    }
}

