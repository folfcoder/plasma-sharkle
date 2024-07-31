import QtQuick 2.15
import QtQuick.Layouts 1.1
import QtQuick.Controls 2.5
import QtMultimedia 6.7

import org.kde.plasma.plasmoid 2.0
import org.kde.plasma.core as PlasmaCore

PlasmoidItem {
    Plasmoid.backgroundHints: PlasmaCore.Types.NoBackground
    fullRepresentation: Item {
        Layout.minimumWidth: 100
        Layout.minimumHeight: 100
        Layout.preferredWidth: 200
        Layout.preferredHeight: 200

        property int imageIndex: 0
        property int talkIndex: 0
        property int soundIndex: 0
        property bool isIdle: true
        property string sharkleColor: Plasmoid.configuration.sharkleColor.toLowerCase()

        Timer {
            id: animationTimer
            interval: 100
            running: true
            repeat: true
            onTriggered: {
                // Loop frame 0 to 7
                imageIndex = (imageIndex + 1) % 8

                // Loop frame 0 to 1, every 8 iterations
                talkIndex = imageIndex == 0 ? !talkIndex : talkIndex
            }
        }

        Timer {
            id: idleTimer
            interval: 1600
            running: false
            repeat: false
            onTriggered: {
                // Set animation to idle
                imageIndex = 0
                isIdle = true
            }
        }

        MediaPlayer {
            id: mediaplayer
            source: "../sounds/" + soundIndex + ".wav"
            // On first .play() call, applet freezes so this is a temporary fix I guess
            autoPlay: true
            audioOutput: AudioOutput {
                muted: true
            }
        }
        MouseArea {
            anchors.fill: parent
            onClicked: {
                // Set animation to hello
                isIdle = false
                idleTimer.restart()

                // Play sound
                soundIndex = (soundIndex + 1) % 8
                mediaplayer.audioOutput.muted = false
                mediaplayer.play()
            }
        }

        Item {
            id: imageContainer
            width: Math.min(parent.width, parent.height)
            height: Math.min(parent.width, parent.height)
            Image {
                id: idleImage
                anchors.fill: parent
                source: "../images/" + sharkleColor + "/idle/" + imageIndex + ".png"
                visible: isIdle
            }
            Image {
                id: helloImage
                anchors.fill: parent
                source: "../images/" + sharkleColor + "/hello/" + (imageIndex%4) + ".png"
                visible: !isIdle
            }
            Image {
                id: talkImage
                width: parent.width
                height: parent.height
                anchors.right: idleImage.left
                anchors.rightMargin: -60*(Math.min(parent.width, parent.height)/200)
                anchors.bottom: idleImage.top
                anchors.bottomMargin: -60*(Math.min(parent.width, parent.height)/200)

                source: "../images/" + sharkleColor + "/talk/" + (talkIndex) + ".png"
                visible: !isIdle
            }
        }
    }
}
