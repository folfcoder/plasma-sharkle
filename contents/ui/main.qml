import QtQuick 2.12
import QtQuick.Layouts 1.12
import QtQuick.Controls 2.5
import QtMultimedia 5.15

import org.kde.plasma.plasmoid 2.0
import org.kde.plasma.core 2.0 as PlasmaCore
import org.kde.plasma.components 3.0 as PlasmaComponents3

Item {
    Plasmoid.backgroundHints: "NoBackground"
    Plasmoid.fullRepresentation: Item {
        Layout.minimumWidth: 100
        Layout.minimumHeight: 100
        Layout.preferredWidth: 200
        Layout.preferredHeight: 200

        property int imageIndex: 0
        property int talkIndex: 0
        property int soundIndex: 0
        property bool isIdle: true

        Item {
            width: Math.min(parent.width, parent.height)
            height: Math.min(parent.width, parent.height)
            Image {
                id: idle
                anchors.fill: parent
                source: "../images/idle/" + imageIndex + ".png"
                visible: isIdle
            }
            Image {
                id: hello
                anchors.fill: parent
                source: "../images/hello/" + (imageIndex%4) + ".png"
                visible: !isIdle
            }
            Image {
                id: talk
                width: parent.width
                height: parent.height
                anchors.right: idle.left
                anchors.rightMargin: -60
                anchors.bottom: idle.top
                anchors.bottomMargin: -60

                source: "../images/talk/" + (talkIndex) + ".png"
                visible: !isIdle
            }
            Timer {
                interval: 100
                running: true
                repeat: true
                onTriggered: {
                    // Loop 0 to 7
                    imageIndex = (imageIndex + 1) % 8

                    // Loop 0 to 1, change every 8 frames
                    talkIndex = imageIndex == 0 ? !talkIndex : talkIndex
                }
            }
            Timer {
                id: idleTimer
                interval: 1600
                running: false
                repeat: false
                onTriggered: {
                    // Set to idle
                    imageIndex = 0
                    isIdle = true
                }
            }
            MediaPlayer {
                id: mediaplayer
                source: "../sounds/" + soundIndex + ".wav"
            }
            MouseArea {
                anchors.fill: parent
                onClicked: {
                    // Set to hello
                    isIdle = false
                    idleTimer.restart()

                    // Play sound
                    soundIndex = (soundIndex + 1) % 8
                    mediaplayer.play()
                }
            }
        }
    }
}

