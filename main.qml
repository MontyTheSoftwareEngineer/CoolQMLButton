import QtQuick 2.13
import QtQuick.Window 2.13
import Monty 1.0
Window {
    visible: true
    width: 640
    height: 480
    title: qsTr("Hello World")

    ExampleClass {
        id: myClass
        onProcessing: customButton.state = "progress"
        onProcessComplete: customButton.state = "complete"
    }

    CustomButton {
        id: customButton
        anchors.centerIn: parent
        width: parent.width / 4
        height: parent.height / 6
        progress: myClass.exampleProgress
        onButtonClicked: myClass.beginProcess()
    }
}
