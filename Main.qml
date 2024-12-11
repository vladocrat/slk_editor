import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

ApplicationWindow {
    id: root

    width: 640
    height: 480
    visible: true
    title: qsTr("slk editor")

    menuBar: Item {
        width: root.width
        height: 20

        RowLayout {
            anchors.fill: parent

            Button {
                id: saveButton

                Layout.fillHeight: true
                Layout.preferredWidth: 40

                text: "save"

                onClicked: {
                    console.log("save pressed");
                }
            }
        }
    }

    MarkdownView {
        anchors.fill: parent
        anchors.top: root.menuBar.bottom

        onSave: {
            saveButton.clicked();
        }
    }
}
