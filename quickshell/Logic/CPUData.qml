// Time.qml
pragma Singleton

import Quickshell
import QtQuick
import Quickshell.Io

Singleton {
    id: cpuRoot

    property int usage: 0
    property int prevIdle: 0
    property int prevTotal: 0

    Timer {
        interval: 1000
        running: true
        repeat: true
        onTriggered: readCpu.running = true
    }

    Process {
        id: readCpu
        command: ["bash", "-c", "head -n1 /proc/stat"]
        running: false
        stdout: StdioCollector {
            onStreamFinished: {
                let parts = this.text.trim().split(/\s+/)
                if (parts[0] !== "cpu") return

                let user = parseInt(parts[1])
                let nice = parseInt(parts[2])
                let system = parseInt(parts[3])
                let idle = parseInt(parts[4])
                let iowait = parseInt(parts[5])
                let irq = parseInt(parts[6])
                let softirq = parseInt(parts[7])
                let steal = parseInt(parts[8] || 0)

                let idleTime = idle + iowait
                let totalTime = user + nice + system + idle + iowait + irq + softirq + steal

                let totalDelta = totalTime - prevTotal
                let idleDelta = idleTime - prevIdle

                let cpuUsage = 0
                if (totalDelta > 0) cpuUsage = Math.round((totalDelta - idleDelta) * 100 / totalDelta)

                usage = cpuUsage
                prevTotal = totalTime
                prevIdle = idleTime
            }
        }
    }
}


