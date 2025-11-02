pragma Singleton

import Quickshell
import Quickshell.Io
import QtQuick

Singleton {
    id: blueMan 

    property string statusImage: Paths.bluetoothDisconnected
    property bool active: false
    property bool deviceFound: false

    Process {
        id: checkBluetooth
        command: ["bash", "-c", "rfkill list bluetooth | grep -E 'Soft|Hard'"]

        stdout: StdioCollector {
            onStreamFinished: {
                let softBlocked = this.text.includes("Soft blocked: yes")
                let hardBlocked = this.text.includes("Hard blocked: yes")

                if (hardBlocked || this.text === "" ){
                    statusImage = Paths.bluetoothDisconnected
                    blueMan.active = false
                    blueMan.deviceFound = false
                }
                else if (softBlocked){
                    statusImage = Paths.bluetoothDisconnected
                    blueMan.active = false
                    blueMan.deviceFound = true
                }
                else{
                    statusImage = Paths.bluetoothConnected
                    blueMan.active = true
                    blueMan.deviceFound = true
                }
            }
        }
    }
    Process { id: enableBt; command: ["rfkill", "unblock", "bluetooth"] }
    function enableBluetooth() {
        enableBt.running = true
    }
    Process { id: disableBt; command: ["rfkill", "block", "bluetooth"] }
    function disableBluetooth() {
        disableBt.running = true
    }
    Process { id: openBlueman; command: ["blueman-manager"] }
    function openManager() {
        openBlueman.running = true
    }

    //Component.onCompleted: checkBluetooth.running = true
    // Timer for both Processes
    Timer {
        interval: 1000
        running: true
        repeat: true
        onTriggered: {
            checkBluetooth.running = true
        }
    }
}

