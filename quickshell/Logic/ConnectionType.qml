// Ethernet.qml
pragma Singleton

import Quickshell
import Quickshell.Io
import QtQuick

Singleton {
    id: root

    property string connection
    property bool connected: false
    property bool ethConnected: false

    property bool wifiConnected: false
    property string wifiInterface: ""
    property int signalStrengthInPer: 0

    Process {
        id: wifiProc
        command: ["nmcli", "-f", "IN-USE,SSID,SIGNAL", "device", "wifi"]
        running: true

        stdout: StdioCollector {
            onStreamFinished: {
                var lines = this.text.replace(/\r/g, "").split("\n");

                var data = [];
                for (var i = 0; i < lines.length; i++) {
                    var parts = lines[i].split(/\s+/);
                    data.push(parts);
                }            

                for(var i = 0; i < data.length; i++) {
					if(data[i][0]/*.indexOf("*") !== -1*/ === "*") {
						root.signalStrengthInPer = parseInt(data[i][2])
						return
					}
                }
            }
        }
    }
    Process {
        id: ethProc
        command: ["nmcli", "-t", "-f", "TYPE,STATE,DEVICE", "device"]
        running: true

        stdout: StdioCollector {
            onStreamFinished: {
                var lines = this.text.split("\n");

                var data = [];
                for (var i = 0; i < lines.length; i++) {
                    var parts = lines[i].split(":");
                    data.push(parts);
                }            

                for(var i = 0; i < data.length; i++) {
                    if(data[i][0] === "ethernet" && data[i][1] === "connected") {
                        root.ethConnected = true
                    } else if(data[i][0] === "ethernet" && data[i][1] === "disconnected") {
                        root.ethConnected = false
                    }

                    if(data[i][0] === "wifi" && data[i][1] === "connected") {
                        root.wifiConnected = true
                        root.wifiInterface = data[i][2]
                    } else if(data[i][0] === "wifi" && data[i][1] === "connected") {
                        root.wifiConnected = false
                    }
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
            //connProc.running = true
            if(root.wifiConnected) {
				wifiProc.running = true

				if(root.signalStrengthInPer >= 90) {
					root.connection = Paths.wifiHigh
				} else if(root.signalStrengthInPer >= 50) {
					root.connection = Paths.wifiGood
				} else {
					root.connection = Paths.wifiLow
				}
            } else if (root.ethConnected) {
                root.connection = Paths.ethernetConnected
            } else {
                root.connection = Paths.ethernetDisconnected
            }
        }
    }
    Process { id: openNetworkManager; command: ["nm-connection-editor"] }
    function openManager() {
        openNetworkManager.running = true
    }
}

