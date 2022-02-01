import QtQuick 2.0

Rectangle {
    id: customButton
    property string buttonColor: "#3263b3"
    property string buttonPressedColor: "#23457d"
    property int progress: 0

    state: "button"

    signal buttonClicked()

    color: buttonColor
    radius: 5

    Rectangle {
        id: progressPortion
        anchors {
            top: parent.top
            left: parent.left
        }

        visible: customButton.state === "progress"
        height: parent.height
        width: ( customButton.width * ( progress / 100 ) )
        radius: customButton.radius
        color: buttonPressedColor

        transitions: Transition {
            NumberAnimation { properties: "width"; easing.type: Easing.Linear; duration: 10 }
        }
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
            customButton.buttonClicked()
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
            if ( state === "complete" && !running)
            {
                checkImage.state = "showCheck"
            }
        }
    }
}
