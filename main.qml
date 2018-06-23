import QtQuick 2.6
import QtQuick.Window 2.2
import QtMultimedia 5.0
import Qt.labs.folderlistmodel 2.1

Window {
    id: rdioMainWindow
    visible: true
    visibility: "FullScreen"
    width: 1024
    height: 768
    color: "#072041"
    title: qsTr("RDIO")


    Rectangle {
        id: menuBar
        x: 9
        y: 0
        width: 192
        height: 768
        color: "#584630"
        radius: 49

    }


    Item {
        id: welcomeWindow
        x: 197
        y: 1
        width: 827
        height: 767
        visible: true

        Text {
            id: welcomeText
            x: 15
            y: 266
            color: "#ffffff"
            text: qsTr("Welcome")
            horizontalAlignment: Text.AlignHCenter
            font.pixelSize: 200
        }
    }


    Item {
        id: mp3Window
        x: 204
        y: 1
        width: 820
        height: 767
        visible: false

        function clicked_visible(){
            if (!visible) {
                visible=true
                radioWindow.visible=false
                welcomeWindow.visible=false
            }
        }

        MediaPlayer {
            id: player
        }

        Item {
            id: playLogic

            property int index: -1
            property MediaPlayer mediaPlayer: player
            property FolderListModel items: FolderListModel {
                //Change this folder to music folder realpath
                folder: "file:///Users/charlie/Documents/git/RDIO/music"
                nameFilters: ["*.mp3"]
            }

            function play_pause_method(){
                if(mediaPlayer.playbackState===1){
                    mediaPlayer.pause();
                }else if(mediaPlayer.playbackState===2){
                    mediaPlayer.play();
                }else{
                    setIndex(0);
                }
            }

            function stop_method(){
                if(mediaPlayer.playbackState===1){
                    mediaPlayer.stop();
                }
            }

            function setIndex(i)
            {
                index = i;

                if (index < 0 || index >= items.count)
                {
                    index = -1;
                    mediaPlayer.source = "";
                    console.log("Error playing file no items");
                }
                else{
                    mediaPlayer.source = items.get(index,"fileURL");
                    console.log(items.get(index,"fileURL"));
                    mediaPlayer.play();
                }                
            }

            function next(){
                setIndex(index + 1);
            }

            function previous(){
                setIndex(index - 1);
            }

            function msToTime(duration) {
                var seconds = parseInt((duration/1000)%60);
                var minutes = parseInt((duration/(1000*60))%60);

                minutes = (minutes < 10) ? "0" + minutes : minutes;
                seconds = (seconds < 10) ? "0" + seconds : seconds;

                return minutes + ":" + seconds;
            }

            Connections {
                target: playLogic.mediaPlayer

                onPaused: {
                    mp3PlayPauseImg.source = "icn/mp3-play.svg";
                }

                onPlaying: {
                    mp3PlayPauseImg.source = "icn/mp3-pause.svg";
                }

                onStopped: {
                    mp3PlayPauseImg.source = "icn/mp3-play.svg";
                    if (playLogic.mediaPlayer.status == MediaPlayer.EndOfMedia)
                        playLogic.next();
                }

                onError: {
                    console.log(error+" error string is "+errorString);
                }

                onMediaObjectChanged: {
                    if (playLogic.mediaPlayer.mediaObject)
                        playLogic.mediaPlayer.mediaObject.notifyInterval = 50;
                }
            }
        }

        Rectangle {
            id: mp3Select
            x: -185
            y: 421
            width: 159
            height: 159
            color: "#ffffff"
            radius: 100
            visible: true
        }

        Rectangle {
            id: mp3menu
            x: 32
            y: 75
            width: 768
            height: 436
            color: "#ffffff"
            radius: 34
            visible: true
            z: 1

            Image {
                id: coverImg
                x: 20
                y: 68
                width: 238
                height: 300
                fillMode: Image.PreserveAspectFit
                source: "icn/compact-disc.svg"
            }

            Text {
                id: trackTitle
                x: 275
                y: 104
                width: 485
                height: 80
                color: "#484747"
                text: player.metaData.title ? player.metaData.title : "Song title unavailable"
                font.family: "Tahoma"
                font.pointSize: 45
                font.bold: true
                style: Text.Raised
                styleColor: "#111111"
                wrapMode: Text.Wrap
            }

            Text {
                id: trackArtist
                x: 278
                y: 226
                width: 479
                height: 54
                color: "#081731"
                text: player.metaData.albumTitle ? player.metaData.albumTitle : "Song album title unavailable"
                font.family: "Tahoma"
                font.pointSize: 35
                font.bold: true
                style: Text.Raised
                styleColor: "#111111"
                wrapMode: Text.Wrap
            }
        }


        Item {
            id: mp3PlayPause
            x: 426
            y: 568
            width: 174
            height: 144
            state: "none"

            Image {
                id: mp3PlayPauseImg
                x: 0
                y: 0
                width: 144
                height: 144
                anchors.verticalCenterOffset: -944
                anchors.horizontalCenterOffset: -1602
                source: "icn/mp3-play.svg"
                anchors.horizontalCenter: rdioMainWindow.horizontalCenter
                anchors.verticalCenter: rdioMainWindow.verticalCenter
                fillMode: Image.PreserveAspectFit

                states: [
                    State {
                        name: "pressed"
                        when: mouseAreamp3PlayPause.pressed
                        PropertyChanges {
                            target: mp3PlayPauseImg
                            scale: 0.8
                        }
                    }]
                transitions: [
                    Transition {
                        NumberAnimation {
                            properties: "scale"
                            easing.type: Easing.InOutQuad
                            duration: 100
                        }
                    }]
            }

            MouseArea {
                id: mouseAreamp3PlayPause
                x: 0
                y: 0
                width: 144
                height: 144

                anchors.fill: parent
                onClicked: playLogic.play_pause_method();
                //onClicked: player.play();
                onPressed: mp3PlayPause.state = "pressed"
                onReleased: mp3PlayPause.state = "none"
            }
        }

        Item {
            id: mp3Stop
            x: 231
            y: 580
            width: 154
            height: 120
            state: "none"

            Image {
                id: mp3StopImg
                x: 0
                y: 0
                width: 120
                height: 120
                source: "icn/mp3-stop.svg"
                anchors.verticalCenter: rdioMainWindow.verticalCenter
                anchors.horizontalCenter: rdioMainWindow.horizontalCenter
                anchors.horizontalCenterOffset: -1602
                fillMode: Image.PreserveAspectFit
                anchors.verticalCenterOffset: -944
                states: [
                    State {
                        name: "pressed"
                        when: mouseAreamp3Stop.pressed
                        PropertyChanges {
                            target: mp3StopImg
                            scale: 0.8
                        }
                    }]
                transitions: [
                    Transition {
                        NumberAnimation {
                            properties: "scale"
                            duration: 100
                            easing.type: Easing.InOutQuad
                        }
                    }]
            }

            MouseArea {
                id: mouseAreamp3Stop
                x: 0
                y: 0
                width: 120
                height: 120
                anchors.rightMargin: 54
                anchors.bottomMargin: 24

                anchors.fill: parent
                onClicked: playLogic.stop_method();
                onPressed: mp3Stop.state = "pressed"
                onReleased: mp3Stop.state = "none"
            }

        }

        Item {
            id: mp3Forward
            x: 629
            y: 568
            width: 154
            height: 144
            state: "none"

            Image {
                id: mp3ForwardImg
                x: 0
                y: 0
                width: 144
                height: 144
                anchors.verticalCenterOffset: -944
                anchors.horizontalCenterOffset: -1602
                fillMode: Image.PreserveAspectFit
                source: "icn/mp3-fast-forward.svg"
                anchors.horizontalCenter: rdioMainWindow.horizontalCenter
                anchors.verticalCenter: rdioMainWindow.verticalCenter
                states: [
                    State {
                        name: "pressed"
                        when: mouseAreamp3Forward.pressed
                        PropertyChanges {
                            target: mp3ForwardImg
                            scale: 0.8
                        }
                    }]
                transitions: [
                    Transition {
                        NumberAnimation {
                            duration: 100
                            easing.type: Easing.InOutQuad
                            properties: "scale"
                        }
                    }]
            }

            MouseArea {
                id: mouseAreamp3Forward
                x: 0
                y: 0
                width: 144
                height: 144

                anchors.fill: parent
                onClicked: playLogic.next()
                onPressed: mp3Forward.state = "pressed"
                onReleased: mp3Forward.state = "none"
            }
        }

        Item {
            id: mp3Backward
            x: 32
            y: 568
            width: 174
            height: 144
            state: "none"

            Image {
                id: mp3BackwardImg
                x: 0
                y: 0
                width: 144
                height: 144
                anchors.verticalCenterOffset: -944
                fillMode: Image.PreserveAspectFit
                anchors.horizontalCenterOffset: -1602
                source: "icn/mp3-fast-backward.svg"
                anchors.verticalCenter: rdioMainWindow.verticalCenter
                anchors.horizontalCenter: rdioMainWindow.horizontalCenter
                states: [
                    State {
                        name: "pressed"
                        when: mouseAreamp3Backward.pressed
                        PropertyChanges {
                            target: mp3BackwardImg
                            scale: 0.8
                        }
                    }]
                transitions: [
                    Transition {
                        NumberAnimation {
                            duration: 100
                            easing.type: Easing.InOutQuad
                            properties: "scale"
                        }
                    }]
            }

            MouseArea {
                id: mouseAreamp3Backward
                x: 0
                y: 0
                width: 144
                height: 144

                anchors.fill: parent
                onClicked: playLogic.previous()
                onPressed: mp3Backward.state = "pressed"
                onReleased: mp3Backward.state = "none"
            }
        }


    }

    Item {
        id: radioWindow
        x: 204
        y: 1
        width: 820
        height: 767
        visible: false

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

        function clicked_visible(){
            if (!visible) {
                visible=true
                mp3Window.visible=false
                welcomeWindow.visible=false
            }
        }


        Rectangle {
            id: radioSelect
            x: -185
            y: 193
            width: 159
            height: 159
            color: "#ffffff"
            radius: 100
        }

        Item {
            id: radioBackward
            x: 99
            y: 589
            width: 174
            height: 144
            visible: true

            MouseArea {
                id: mouseAreaBackward
                x: 0
                y: 0
                width: 144
                height: 144
                onClicked: radioWindow.radio_backward();
            }

            Image {
                id: radioBackwardImg
                width: 144
                height: 144
                source: "icn/fast_backward.png"
                states: State {
                    name: "pressed"
                    when: mouseAreaBackward.pressed
                    PropertyChanges { target: radioBackwardImg; scale: 0.8 }
                }
                transitions: Transition {
                    NumberAnimation { properties: "scale"; duration: 100; easing.type: Easing.InOutQuad }
                }
            }
        }

        Item {
            id: radioForward
            x: 564
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
                states: State {
                    name: "pressed"
                    when: mouseAreaForward.pressed
                    PropertyChanges { target: radioImgForward; scale: 0.8 }
                }
                transitions: Transition {
                    NumberAnimation { properties: "scale"; duration: 100; easing.type: Easing.InOutQuad }
                }
            }

            MouseArea {
                id: mouseAreaForward
                x: -6
                y: 0
                width: 144
                height: 144
                onClicked: radioWindow.radio_forward();
            }
        }

        Item {
            id: radioFrec
            x: 42
            y: 185
            width: 756
            height: 356

            Rectangle {
                id: greyR
                x: -20
                y: -23
                width: 772
                height: 369
                color: "#6a6868"
                radius: 25
            }

            Rectangle {
                id: whiteR
                x: 0
                y: 0
                width: 732
                height: 320
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
                x: 518
                y: 187
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
        y: 202
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

            states: State {
                name: "pressed"
                when: mouseArearadioButton.pressed
                PropertyChanges { target: radioImg; scale: 0.8 }
            }
            transitions: Transition {
                NumberAnimation { properties: "scale"; duration: 100; easing.type: Easing.InOutQuad }
            }
        }

        MouseArea {
            id: mouseArearadioButton
            x: 0
            y: 0
            width: 144
            height: 144
            onClicked: {
                playLogic.stop_method()
                radioWindow.clicked_visible()
            }
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
            x: -14
            y: -9
            width: 170
            height: 161
            anchors.verticalCenter: rdioMainWindow.verticalCenter
            anchors.horizontalCenter: rdioMainWindow.horizontalCenter
            anchors.verticalCenterOffset: -944
            fillMode: Image.PreserveAspectFit
            anchors.horizontalCenterOffset: -1602
            source: "icn/music-icon.png"
            states: State {
                name: "pressed"
                when: mouseAreamp3Button.pressed
                PropertyChanges { target: mp3Img; scale: 0.8 }
            }
            transitions: Transition {
                NumberAnimation { properties: "scale"; duration: 100; easing.type: Easing.InOutQuad }
            }
        }

        MouseArea {
            id: mouseAreamp3Button
            x: -7
            y: 0
            width: 158
            height: 152
            onClicked: mp3Window.clicked_visible()
        }
    }












}
