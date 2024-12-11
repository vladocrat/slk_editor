pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Controls

Item {
    id: root

    readonly property alias text: markdownInput.text

    signal save();

    SplitView {
        anchors.fill: parent

        orientation: Qt.Horizontal

        Component.onCompleted: console.log(width)

        EditorView {
            id: markdownInput

            SplitView.preferredWidth: parent.width / 2
            SplitView.preferredHeight: parent.height

            editor: Flickable {
                anchors.fill: parent

                property alias text: underlyingText.text

                onContentYChanged: {
                    markdownInput.lineNumbersView.contentY = contentY;
                }

                TextArea.flickable: TextArea {
                    id: underlyingText

                    anchors.fill: parent
                    wrapMode: TextEdit.Wrap
                    placeholderText: "Enter Markdown text here..."

                    onTextChanged: {
                        markdownInput.updateLineNumbers();
                    }

                    Keys.onPressed: function(event) {
                        if (event.modifiers === Qt.ControlModifier && event.key === Qt.Key_S) {
                            console.log("Shift + S pressed");
                            root.save();
                        }
                    }
                }
            }
        }

        EditorView {
            id: markdownOutput

            SplitView.preferredWidth: parent.width / 2
            SplitView.preferredHeight: parent.height

            editor: Text {
                text: markdownInput.text
                textFormat: TextEdit.MarkdownText
                wrapMode: Text.Wrap

                onTextChanged: {
                    markdownOutput.updateLineNumbers();
                }
            }
        }
    }
}
