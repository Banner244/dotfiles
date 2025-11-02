pragma Singleton
import Quickshell
import QtQuick
import Quickshell.Io

Singleton {
    id: spotifyData 
    property string songTitle: "—"
    property string artist: "—"
    property bool playing: false

    Timer {
        interval: 220
        running: true
        repeat: true
        onTriggered: {
            statusProc.running = true
            songProc.running = true
        }
    }

    Process {
        id: statusProc
        command: ["playerctl", "status", "-p", "spotify"]
        running: false
        stdout: StdioCollector {
            onStreamFinished: {
                spotifyData.playing = this.text.trim() === "Playing"
            }
        }
    }

    Process {
        id: songProc
        command: ["playerctl", "metadata", "title", "-p", "spotify"]
        running: false
        stdout: StdioCollector {
            onStreamFinished: {
                spotifyData.songTitle = this.text.trim() || "—"
            }
        }
    }
}

