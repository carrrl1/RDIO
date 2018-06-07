import QtQuick 2.6
import QtQuick.Window 2.2

Window {
    id: window
    visible: true
    width: 1366
    height: 768
    title: qsTr("RDIO")


    Rectangle {
        id: rectangle
        property bool clicked: false
        x: 0
        y: 0
        width: 192
        height: 384
        color: "#000000"

        function clicked_color(){
            if (clicked) {
                color="#4e5eda"
                clicked=false
            }
            else {
                color="#000000"
                clicked=true
            }
        }

        MouseArea {
            id: mouseArea
            x: 0
            y: 0
            width: 192
            height: 384
            onClicked: rectangle.clicked_color()
        }

        Image {
            id: image
            x: 24
            y: 120
            width: 144
            height: 144
            fillMode: Image.PreserveAspectFit
            anchors.verticalCenter: rectangle.verticalCenter
            anchors.horizontalCenter: rectangle1.horizontalCenter
            source: "icn/radio-icon.png"
        }
    }

    Rectangle {
        id: rectangle1
        property bool clicked: false
        x: 0
        y: 384
        width: 192
        height: 384
        color: "#000000"

        function clicked_color(){
            if (clicked) {
                color="#4e5eda"
                clicked=false
            }
            else {
                color="#000000"
                clicked=true
            }
        }

        MouseArea {
            id: mouseArea1
            x: 0
            y: 0
            width: 192
            height: 384
            onClicked: rectangle1.clicked_color()
        }

        Image {
            id: image1
            x: 24
            y: 120
            width: 144
            height: 144
            fillMode: Image.PreserveAspectFit
            anchors.right: image.right
            anchors.left: image.left
            anchors.horizontalCenter: rectangle1.horizontalCenter
            anchors.verticalCenter: rectangle1.verticalCenter
            source: "icn/music-icon.png"
        }
    }

}
