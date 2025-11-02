import QtQuick 
import QtQuick.Layouts
import "../Logic/" as Logic
import "../Popups" as Popups
RowLayout {
    spacing: 4
    anchors.centerIn: parent
    id: row 

    // ---------------- Calender Icon ----------------
    Image {
        id: calendarIcon
        width: 18
        height: 18
        source: Logic.Paths.miniCalendar

        MouseArea {
            anchors.fill: parent
            onClicked: {            
                calendarPopup.visible = !calendarPopup.visible
                calendarPopup.x = calendarIcon.mapToGlobal(Qt.point(0, calendarIcon.width/2)).x - calendarPopup.width/2
                calendarPopup.y = calendarIcon.mapToGlobal(Qt.point(0, calendarIcon.height)).y
            }
            
            hoverEnabled: true
            onEntered: calendarIcon.scale = 1.1
            onExited: calendarIcon.scale = 1.0
        }
    }

    // ---------------- Calender Popup ----------------
    Popups.CalendarPopup {
        id: calendarPopup
    }
}

