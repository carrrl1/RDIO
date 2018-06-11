import QtQuick 2.6
import QtQuick.Window 2.2
import QtAudioEngine 1.1

Window {
    id: rdioMainWindow
    visible: true
    width: 1366
    height: 768
    color: "#072041"
    title: qsTr("RDIO")


    Rectangle {
        id: menuBar
        x: 9
        y: 0
        width: 192
        height: 768
        color: "#7c5e3a"
        radius: 49

    }

    Item {
        id: radioWindow
        x: 204
        y: 1
        width: 1162
        height: 767
        visible: true

        property real frequenc: 95.5
        function radio_forward(){
            if (frequenc < 108) {
                frequenc+=0.1
                frequenc=frequenc.toFixed(1)
            }
        }
        function radio_backward(){
            if (frequenc > 87.5) {
                frequenc-=0.1
                frequenc=frequenc.toFixed(1)
            }
        }

        property bool clicked: false
        function clicked_visible(){
            if (clicked) {
                visible=false
                clicked=false
            }
            else {
                visible=true
                clicked=true
            }
        }


        Item {
            id: radioBackward
            x: 149
            y: 589
            width: 174
            height: 144

            MouseArea {
                id: mouseAreaBackward
                x: 0
                y: 0
                width: 144
                height: 144
                onClicked: radioWindow.radio_backward();
            }

            Image {
                id: image
                width: 144
                height: 144
                source: "icn/fast_backward.png"
            }
        }

        Item {
            id: radioForward
            x: 806
            y: 589
            width: 174
            height: 144
            Image {
                id: radioImgForward
                x: 0
                y: 0
                width: 144
                height: 144
                anchors.horizontalCenterOffset: 350
                anchors.verticalCenter: rdioMainWindow.verticalCenter
                anchors.horizontalCenter: rdioMainWindow.horizontalCenter
                anchors.verticalCenterOffset: 195
                fillMode: Image.PreserveAspectFit
                source: "icn/fast_forward.png"
            }

            MouseArea {
                id: mouseAreaForward
                x: 0
                y: 0
                width: 144
                height: 144
                onClicked: radioWindow.radio_forward();
            }
        }

        Item {
            id: radioFrec
            x: 130
            y: 183
            width: 860
            height: 378

            Rectangle {
                id: greyR
                x: -20
                y: -23
                width: 890
                height: 378
                color: "#6a6868"
                radius: 25
            }

            Rectangle {
                id: whiteR
                x: 0
                y: 0
                width: 850
                height: 332
                color: "#ffffff"
                radius: 5
            }

            Text {
                id: frequency
                x: 65
                y: 38
                color: "#4f3939"
                text: radioWindow.frequenc
                horizontalAlignment: Text.AlignHCenter
                font.pixelSize: 218
            }

            Text {
                id: mhz
                x: 614
                y: 191
                color: "#4f3939"
                text: "MHz"
                horizontalAlignment: Text.AlignHCenter
                font.pixelSize: 100
            }


        }





    }

    Item {
        id: radioButton
        x: 27
        y: 232
        width: 174
        height: 144


        Image {
            id: radioImg
            x: 0
            y: 0
            width: 144
            height: 144
            anchors.horizontalCenterOffset: -1602
            anchors.verticalCenterOffset: -944
            fillMode: Image.PreserveAspectFit
            anchors.verticalCenter: rdioMainWindow.verticalCenter
            anchors.horizontalCenter: rdioMainWindow.horizontalCenter
            source: "icn/radio-icon.png"
        }

        MouseArea {
            id: mouseArearadioButton
            x: 0
            y: 0
            width: 144
            height: 144
            onClicked: radioWindow.clicked_visible()
        }
    }

    Item {
        id: mp3Button
        x: 27
        y: 429
        width: 174
        height: 144
        Image {
            id: mp3Img
            x: 0
            y: 0
            width: 144
            height: 144
            anchors.verticalCenter: rdioMainWindow.verticalCenter
            anchors.horizontalCenter: rdioMainWindow.horizontalCenter
            anchors.verticalCenterOffset: -944
            fillMode: Image.PreserveAspectFit
            anchors.horizontalCenterOffset: -1602
            source: "icn/music-icon.png"
        }

        MouseArea {
            id: mouseAreamp3Button
            x: 0
            y: 0
            width: 142
            height: 144
        }
    }





}
