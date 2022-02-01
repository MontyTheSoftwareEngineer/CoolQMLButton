import QtQuick 2.13
import QtQuick.Window 2.13

Window {
    visible: true
    width: 640
    height: 480
    title: qsTr("Hello World")

    CustomButton {
        id: customButton
        anchors.centerIn: parent
        width: parent.width / 4
        height: parent.height / 6
    }
}
