import QtQuick
import QtQuick.Window
import QtQuick.Layouts
import Qt.labs.folderlistmodel 
import QtQuick.Controls
import Quickshell.Io
import "../Logic" as Logic
Window {
    id: appWindow
    maximumWidth: 850
    maximumHeight: 400
    width: 750
    visible: true
    title: "Wallpaper"
    color: "#222222"

    property string wallpaperPath: Logic.Paths.home + "/Pictures/Wallpapers"

    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 5
        spacing: 10

        Text {
            text: "Select your Wallpaper"
            font.bold: true
            color: "#FFFFFF"
        }

        FolderListModel {
            id: folderModel
            folder: wallpaperPath
            nameFilters: ["*.jpg", "*.png", "*.jpeg", "*.webp"]
            showDirs: false
            showFiles: true

        }

        Text {
            visible: folderModel.count === 0
            color: "#ccc"
            text: "No Wallpapers found in: " + wallpaperPath
        }
        Process {
            id: setWallpaper
            command: []
            running: false
            onRunningChanged: if (running) console.log("Running:", command)
        }
        GridView {
            id: wallpaperGrid
            Layout.fillWidth: true
            Layout.fillHeight: true
            cellWidth: 180
            cellHeight: 120
            clip: true
            model: folderModel
            delegate: Rectangle {
                id: rect
                width: wallpaperGrid.cellWidth
                height: wallpaperGrid.cellHeight
                radius: 8
                color: "#333"

                Image {
                    anchors.fill: parent
                    source: filePath
                    fillMode: Image.PreserveAspectCrop
                    smooth: true
                }
                MouseArea {
                    anchors.fill: parent
                    hoverEnabled: true
                    onClicked: {
                        var scriptPath = Logic.Paths.home + "/.config/quickshell/scripts/SetWallpaper.sh"
                        if (scriptPath.startsWith("file://")) {
                            scriptPath = scriptPath.substring(7);  
                        }
                        setWallpaper.command = ["bash", scriptPath, filePath]
                        setWallpaper.running = true
                    }
                    onEntered: parent.opacity = 0.85
                    onExited: parent.opacity = 1.0
                }
                
                //Component.onCompleted: console.log("Delegate created for:", filePath)
            }

            ScrollBar.vertical: ScrollBar { policy: ScrollBar.AsNeeded }
        }
    }
}

