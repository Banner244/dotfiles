pragma Singleton
import QtQuick 
import Quickshell.Io
import Quickshell

Singleton {
    id: audioRoot

    property int volume: 0
    property bool muted: false
    property int micVolume: 0
    property bool micMuted: false
    property bool volumeInitialized: false
    property bool micVolumeInitialized: false

    // ---------------- Timer for Volume-Update ----------------
    Timer {
        interval: 1000
        running: true
        repeat: true
        onTriggered: {
            volProc.running = true
            micVolProc.running = true
        }
    }

    // ---------------- Processes: Speaker ----------------
    Process {
        id: volProc
        command: ["wpctl", "get-volume", "@DEFAULT_AUDIO_SINK@"]
        running: true
        stdout: StdioCollector {
            onStreamFinished: {
                let parts = this.text.trim().split(" ")
                if(parts.length > 1) {
                    audioRoot.volume = Math.round(parseFloat(parts[1])*100)
                    audioRoot.volumeInitialized = true
                }
            }
        }
    }

    Process { id: muteProc; command: ["wpctl", "set-mute", "@DEFAULT_AUDIO_SINK@", "toggle"] }

    // ---------------- Processes: Mic ----------------
    Process {
        id: micVolProc
        command: ["wpctl", "get-volume", "@DEFAULT_AUDIO_SOURCE@"]
        running: true
        stdout: StdioCollector {
            onStreamFinished: {
                let parts = this.text.trim().split(" ")
                if(parts.length > 1) {
                    audioRoot.micVolume = Math.round(parseFloat(parts[1])*100)
                    audioRoot.micVolumeInitialized = true
                }
            }
        }
    }

    Process { id: muteMicProc; command: ["wpctl", "set-mute", "@DEFAULT_AUDIO_SOURCE@", "toggle"] }

    // ---------------- Init ----------------
    Component.onCompleted: {
        volProc.running = true
        micVolProc.running = true
    }
}
