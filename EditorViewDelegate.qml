import QtQuick

Item {
    id: root

    required property int modelIndex;

    implicitWidth: 20
    implicitHeight: 20

    Text {
        anchors.centerIn: parent
        text: (root.modelIndex + 1)
    }
}
