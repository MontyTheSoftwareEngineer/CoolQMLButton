import QtQuick 2.0

Rectangle {
    id: customButton
    property string buttonColor: "#3263b3"
    property string buttonPressedColor: "#23457d"
    property int progress: 0

    state: "button"

    color: buttonColor
    radius: 5

    Timer {
        id: progressTimer
        running: false
        interval: 60
        repeat: true
        onTriggered: {
            progress += 5
            if ( progress > 95 )
            {
                progressTimer.stop()
                progress = 0
                customButton.state = "complete"
            }
        }
    }

    Rectangle {
        id: progressPortion
        anchors {
            top: parent.top
            left: parent.left
        }

        visible: false
        height: parent.height
        width: ( customButton.width * ( progress / 100 ) )
        radius: customButton.radius
        color: buttonPressedColor
    }

    Text {
        id: buttonText
        color: "white"
        text: "Process"
        anchors.centerIn: parent
        font.pixelSize: 36
        font.bold: true
    }

    Image {
        id: checkImage
        state: "null"
        anchors.centerIn: parent
        width: 0
        height: width
        fillMode: Image.PreserveAspectFit
        source: "qrc:/check.png"

        states: State {
            name: "showCheck"
            PropertyChanges {
                target: checkImage
                width: 100
            }
        }

        transitions: Transition {
            NumberAnimation { properties: "width,height"; easing.type: Easing.OutBack; duration: 250 }
        }
    }

    MouseArea {
        anchors.fill: parent
        onPressed: customButton.color = buttonPressedColor
        onReleased: customButton.color = buttonColor
        onClicked: {
            buttonText.visible = false
            customButton.state = "progress"
        }
    }

    states: [
        State {
            name: "progress";
            PropertyChanges {
                target: customButton
                width: parent.width * 0.9
                height: parent.height / 20
            }
        },
        State {
            name: "complete";
            PropertyChanges {
                target: customButton
                width: 0
                height: 0
            }
        }
    ]

    transitions: Transition {
        NumberAnimation { properties: "width,height"; easing.type: Easing.InOutQuad; duration: 750 }
        onRunningChanged: {
            if ( state === "progress" && !running)
            {
                progressPortion.visible = true
                progressTimer.running = true
            }
            if ( state === "complete" && !running)
            {
                checkImage.state = "showCheck"
            }
        }
    }
}
