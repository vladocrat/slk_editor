import QtQuick
import QtQuick.Layouts
import QtQuick.Controls

Item {
    id: root

    required property Component editor
    property alias lineNumbersView: lineNumbers
    readonly property string text: loader.item.text ? loader.item.text : ""

    RowLayout {
        anchors.fill: parent

        ListModel {
            id: lineNumbersModel
        }

        ListView {
            id: lineNumbers

            Layout.fillWidth: true
            Layout.fillHeight: true
            Layout.maximumWidth: 25

            model: lineNumbersModel
            interactive: false

            delegate: EditorViewDelegate {
                required property var model
                modelIndex: model.index
            }
        }

        Item {
            id: editorItem

            Layout.fillWidth: true
            Layout.fillHeight: true

            Loader {
                id: loader

                anchors.fill: parent
                sourceComponent: root.editor

                onLoaded: {
                    console.log("loaded");
                }
            }
        }
    }

    function updateLineNumbers() {
        var lines = loader.item.text.split("\n").length;
        lineNumbersModel.clear();
        for (var i = 1; i <= lines; i++) {
            lineNumbersModel.append({ lineNumber: i });
        }
    }
}
