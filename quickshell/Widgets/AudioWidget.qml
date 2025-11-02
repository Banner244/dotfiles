import QtQuick 
import QtQuick.Layouts
import "../Logic" as Logic
import "../Popups" as Popups
Item {
    id: widgetRoot
    width: 18 
    height: 18 


    RowLayout {
        id: audioRow
        //spacing: 1
        anchors.centerIn: parent
        Image {
            id: speakerIcon
            source: Logic.AudioData.muted ? Logic.Paths.audioMuted:
                    Logic.AudioData.volume < 30 ? Logic.Paths.audioLow: 
                    Logic.AudioData.volume < 60 ? Logic.Paths.audioMedium :
                                   Logic.Paths.audioHigh
        }

        Image {
            anchors.centerIn: parent
            id: micIcon
            source: Logic.AudioData.micMuted ? Logic.Paths.micMuted :
                    Logic.AudioData.micVolume < 30 ? Logic.Paths.micLow: 
                    Logic.AudioData.micVolume < 60 ? Logic.Paths.micMedium :
                                   Logic.Paths.micHigh
                               }

        MouseArea {
            anchors.fill: speakerIcon
            onClicked: {
                popup.x = widgetRoot.mapToGlobal(Qt.point(0, widgetRoot.width/2)).x - popup.width/2
                popup.y = widgetRoot.mapToGlobal(Qt.point(0, widgetRoot.height)).y
                popup.visible = !popup.visible 
            }
            hoverEnabled: true
            onEntered: audioRow.scale = 1.1
            onExited: audioRow.scale = 1.0
        }
        MouseArea {
            anchors.fill: micIcon
            onClicked: {
                popup.x = widgetRoot.mapToGlobal(Qt.point(0, widgetRoot.width/2)).x - popup.width/2
                popup.y = widgetRoot.mapToGlobal(Qt.point(0, widgetRoot.height)).y
                popup.visible = !popup.visible 
            }
            hoverEnabled: true
            onEntered: audioRow.scale = 1.1
            onExited: audioRow.scale = 1.0
        }
    }

    Popups.AudioSliderPopup {
        id: popup
    }
}
