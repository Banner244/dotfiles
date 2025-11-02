import QtQuick
import QtQuick.Layouts
import Quickshell.Io
import "../Logic/" as Logic

RowLayout {
    id: spotifyBar
    spacing: 4

    property int fontSize: 16 
    
    // Spotify Icon
    Image {
        source: Logic.Paths.spotify
    }

    Process { id: toggleProc; command: ["playerctl", "play-pause", "-p", "spotify"] }
    Process { id: prevProc; command: ["playerctl", "previous", "-p", "spotify"] }
    Process { id: nextProc; command: ["playerctl", "next", "-p", "spotify"] }

    // Song Title 
    Text {
        text: Logic.SpotifyData.songTitle.length > 15 ? Logic.SpotifyData.songTitle.slice(0, 15) + "…" : Logic.SpotifyData.songTitle
        color: "white"
        font.pixelSize: spotifyBar.fontSize - 4 
        verticalAlignment: Text.AlignVCenter
        elide: Text.ElideRight
    }

    // Previous Button
    Image {
        id: buttonPrev
        source: Logic.Paths.mediaPrevious
        //text: "⏮"
        //font.pixelSize: spotifyBar.fontSize 
        //background: Rectangle { color: "transparent" }
        //Hover
        MouseArea {
            anchors.fill: parent
            hoverEnabled: true
            onEntered: buttonPrev.scale = 1.1
            onExited: buttonPrev.scale = 1.0
            // Call Previous Song
            onClicked: prevProc.running = true
        }
    }

    // Play/Pause Button
    Image {
        id: buttonPP
        source: Logic.SpotifyData.playing ? Logic.Paths.mediaPause : Logic.Paths.mediaPlay
        //text: SpotifyData.playing ? "⏸" : "▶"
        //font.pixelSize: spotifyBar.fontSize
        //background: Rectangle { color: "transparent" }
        //Hover
        MouseArea {
            anchors.fill: parent
            hoverEnabled: true
            onEntered: buttonPP.scale = 1.1
            onExited: buttonPP.scale = 1.0
            // Stop/Play Song
            onClicked: toggleProc.running = true
        }
    }

    // Next Button
    Image {
        id: buttonNext
        source: Logic.Paths.mediaNext
        //text: "⏭"
        //font.pixelSize: spotifyBar.fontSize
        //background: Rectangle { color: "transparent" }
        //Hover
        MouseArea {
            anchors.fill: parent
            hoverEnabled: true
            onEntered: buttonNext.scale = 1.1
            onExited: buttonNext.scale = 1.0
            // Play next Song
            onClicked: nextProc.running = true
        }
    }
}

