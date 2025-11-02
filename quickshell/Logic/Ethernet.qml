// Ethernet.qml
pragma Singleton

import Quickshell
import Quickshell.Io
import QtQuick

Singleton {
    id: root

    property string connection
    property string download: "0 B/s"
    property string upload: "0 B/s"

    // Check Connection
    Process {
        id: ethProc
        command: ["nmcli", "g"]
        running: true

        stdout: StdioCollector {
            onStreamFinished: {
                if (this.text.indexOf("full") !== -1) {
                    root.connection = Paths.ethernetConnected
                } else {
                    root.connection = Paths.ethernetDisconnected
                }
            }
        }
    }

    // Network traffic
    Process {
        id: netProc 
        command: ["ifstat"]  
        stdout: StdioCollector {
            onStreamFinished: {
                var output = this.text 
                var lines = output.trim().split("\n")
                if (lines.length >= 5) {
                    var values = lines[5].trim().split(/\s+/)
                    var tempDownload = toNumber(values[5])
                    var tempUpload= toNumber(values[7])

                    download = formatSpeed(tempDownload)
                    upload = formatSpeed(tempUpload)
                }
            }
        }
    }
    // Timer for both Processes
    Timer {
        interval: 1000
        running: true
        repeat: true
        onTriggered: {
            ethProc.running = true
            netProc.running = true 
        }
    }
 
    function formatSpeed(bytesPerSec) {
        if (bytesPerSec < 1024)
            return bytesPerSec + " B/s"
        else if (bytesPerSec < 1024 * 1024)
            return Math.round(bytesPerSec / 1024) + " kB/s"
        else
            return (bytesPerSec / (1024*1024)).toFixed(1) + " MB/s"
    }

    function toNumber(value) {
        if (typeof value === "string" && value.endsWith("K")) {
            value = value.slice(0, -1);
            return parseFloat(value) * 1000;
        } else {
            return parseFloat(value);
        }
    }
}

