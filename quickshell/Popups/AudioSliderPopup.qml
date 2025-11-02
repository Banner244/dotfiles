import QtQuick 
import QtQuick.Controls 
import QtQuick.Layouts 
import Quickshell.Io
import "../Elements" as Elements
import "../Logic/" as Logic
Window {
    id: sliderPopup
    visible: false
    flags: Qt.Popup | Qt.FramelessWindowHint | Qt.WindowStaysOnTopHint
    color: "transparent" 

    // ---------------- Scaling----------------
    
    property real scaleFactor: screen.devicePixelRatio

    Process { id: setVolumeProc; command: ["wpctl", "set-volume", "@DEFAULT_AUDIO_SINK@", Logic.AudioData.volume + "%"] }
    Process { id: setMicVolumeProc; command: ["wpctl", "set-volume", "@DEFAULT_AUDIO_SOURCE@", Logic.AudioData.micVolume + "%"] }    
    Process { id: openAudioSettings; command: ["pavucontrol"] }    

    Rectangle {
        anchors.fill: parent
        color: "#2c2c2c"
        radius: 10
        border.color: "#555555"
        border.width: 1

        ColumnLayout {
            id: layout
            anchors.centerIn: parent
            anchors.margins: 10
            spacing: 8

            // ---------------- Speaker ----------------
            RowLayout {
                spacing: 8
                Layout.fillWidth: true
                Image {
                    source: Paths.audioHigh
                }
                Slider {
                    id: volumeSlider
                    from: 0
                    to: 100
                    value: Logic.AudioData.volume 
                    Layout.fillWidth: true
                    focus: true
                    background: Rectangle {
                        implicitHeight: 6 * sliderPopup.scaleFactor
                        radius: 3
                        color: "#333"
                        anchors.verticalCenter: parent.verticalCenter

                        Rectangle {
                            width: parent.width * volumeSlider.visualPosition
                            height: parent.height
                            radius: 3
                            color: "#888"
                        }
                    }

                    handle: Rectangle {
                        width: 15 * sliderPopup.scaleFactor
                        height: 15 * sliderPopup.scaleFactor
                        radius: 9
                        color: "#555"
                        // setting position of the handle
                        x: volumeSlider.leftPadding
                           + volumeSlider.visualPosition * (volumeSlider.availableWidth - width)
                        y: volumeSlider.height / 2 - height / 2

                    }

                    onValueChanged: {
                        if (Math.round(Logic.AudioData.volume) !== Math.round(value)) {
                            Logic.AudioData.volume = value
                            setVolumeProc.running = true
                        }
                    }
                }

                Text {
                    text: Logic.AudioData.muted ? "Muted" : Logic.AudioData.volume + "%"
                    color: "white"
                    font.bold: true
                    font.pixelSize: 14 * sliderPopup.scaleFactor
                }
            }

            // ---------------- Mic ----------------
            RowLayout {
                spacing: 8
                Layout.fillWidth: true
                Image {
                    source: Paths.micHigh
                }
                Slider {
                    id: micVolumeSlider
                    Layout.fillWidth: true
                    from: 0
                    to: 100
                    value: Logic.AudioData.micVolume

                    background: Rectangle {
                        implicitHeight: 6 * sliderPopup.scaleFactor
                        radius: 3
                        color: "#333"
                        anchors.verticalCenter: parent.verticalCenter

                        Rectangle {
                            width: parent.width * micVolumeSlider.visualPosition
                            height: parent.height
                            radius: 3
                            color: "#888"
                        }
                    }

                    handle: Rectangle {
                        width: 15 * sliderPopup.scaleFactor
                        height: 15 * sliderPopup.scaleFactor
                        radius: 9
                        color: "#555"
                        // setting position of the handle
                        x: micVolumeSlider.leftPadding
                           + micVolumeSlider.visualPosition * (micVolumeSlider.availableWidth - width)
                        y: micVolumeSlider.height / 2 - height / 2

                    }
                    onValueChanged: {
                        if (Math.round(Logic.AudioData.micVolume) !== Math.round(value)) {
                            Logic.AudioData.micVolume = value
                            setMicVolumeProc.running = true
                        }
                    }
                }
                Text {
                    text: Logic.AudioData.micMuted ? "Muted" : Logic.AudioData.micVolume + "%"
                    color: "white"
                    font.bold: true
                    font.pixelSize: 14 * sliderPopup.scaleFactor
                }
            }

            // ---------------- Audio Settings Button ----------------
            Elements.HoverButton {
                text: "Settings"
                Layout.alignment: Qt.AlignHCenter
                onClicked: openAudioSettings.running = true
                // Beispiel: leicht skalierte Höhe
                implicitHeight: 28 * sliderPopup.scaleFactor
                implicitWidth: 150 * sliderPopup.scaleFactor
            }
        }
            // ---------------- Dynamic Size----------------
        Component.onCompleted: {
            sliderPopup.width = layout.implicitWidth + (10 * sliderPopup.scaleFactor)
            sliderPopup.height = layout.implicitHeight + (10 * sliderPopup.scaleFactor)
        }
    }
}
