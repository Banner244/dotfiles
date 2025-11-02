// RAM.qml
pragma Singleton

import QtQuick
import Quickshell
import Quickshell.Io

Singleton {
    id: ram

    property string used: "0"
    property string total: "0"
    property string text: "0 / 0 GB"

    Process {
        id: memProc
        command: ["cat", "/proc/meminfo"]
        running: true

        stdout: StdioCollector {
            onStreamFinished: {
                let lines = this.text.split("\n")
                let memTotal = 0
                let memFree = 0
                let buffers = 0
                let cached = 0

                for (let i = 0; i < lines.length; i++) {
                    let line = lines[i]
                    if (line.startsWith("MemTotal")) memTotal = parseInt(line.split(/\s+/)[1])
                    else if (line.startsWith("MemFree")) memFree = parseInt(line.split(/\s+/)[1])
                    else if (line.startsWith("Buffers")) buffers = parseInt(line.split(/\s+/)[1])
                    else if (line.startsWith("Cached")) cached = parseInt(line.split(/\s+/)[1])
                }

                if (memTotal > 0) {
                    let usedKB = memTotal - (memFree + buffers + cached)
                    let usedGB = usedKB / (1024 * 1024)
                    let totalGB = memTotal / (1024 * 1024)
                    ram.used = usedGB.toFixed(1)
                    ram.total = totalGB.toFixed(1)
                    ram.text = `${ram.used} / ${ram.total} GB`
                }
            }
        }
    }

    Timer {
        interval: 2000
        running: true
        repeat: true
        onTriggered: memProc.running = true
    }
}

