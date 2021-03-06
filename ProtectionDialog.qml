import QtQuick 2.11
import QtQuick.Window 2.3
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.4
import QtQuick.Controls.Styles 1.4
import QtQml.Models 2.3

Rectangle {
    id: protectionScreen
    anchors.fill: parent
    focus: true
    ColumnLayout {
        id: tagSearchLayout
        anchors.fill: parent
        TextField {
            id: searchTagField
            Layout.fillWidth: true
            placeholderText: qsTr("Search a tag")
        }
        ScrollView {
            id: tagScrollView
            Layout.fillWidth: true
            Layout.fillHeight: true
            ListView {
                id: tagListView
                model: secTagManager.secTags
                clip: true
                keyNavigationEnabled: true
                highlightFollowsCurrentItem: true
                currentIndex: 0
                Component {
                    id: tagComponent
                    Rectangle {
                        id: tagRect
                        width: parent.width
                        height: (tagNameText.height > enableTag.height) ? tagNameText.height + 2*Screen.pixelDensity : enableTag.height + 2*Screen.pixelDensity
                        color: "transparent"
                        border.width: 0.5*Screen.pixelDensity
                        border.color: "grey"
                        MouseArea {
                            anchors.fill: parent
                            propagateComposedEvents: true
                            onClicked: {tagListView.currentIndex = index; mouse.accepted=false;}
                        }
                        RowLayout {
                            id: tagRectLayout
                            anchors.fill: parent
                            Text {
                                id: tagNameText
                                text: modelData.tagName
                                Layout.alignment: Qt.AlignLeft
                                Layout.leftMargin: 5*Screen.pixelDensity
                                font.pointSize: fontDefaultSize
                                font.family: fontDefaultFamily
                                elide: Text.ElideRight
                            }
                            CheckBox {
                                id: enableTag
                                Layout.alignment: Qt.AlignRight
                                Layout.rightMargin: 5*Screen.pixelDensity
                               // text: enabledTag ? qsTr("Enabled") : qsTr("Turn on")
                                checked: modelData.attached
                                onClicked: { //do something
                                    if (checked == false) {
                                        secTagManager.detachTag(currentPath, modelData.tagName)
                                        console.log("Detach tag",
                                                    modelData.tagName, "from", currentPath)
                                    } else {
                                        secTagManager.attachTag(currentPath, modelData.tagName)
                                        console.log("Attach tag",
                                                    modelData.tagName,"to", currentPath)
                                    }
                                }
                            }
                        }
                    }
                }
                delegate: tagComponent
                highlight:  Rectangle { border.color: highlightBorderColor ; border.width: highlightBorderWidth;  z:highlightZ; color: "#CCCCCC"}
                spacing: 3
            }
        }
    }
    Keys.onBackPressed: {
        console.log("The key pressed")
        topLoader.setSource("FolderEntriesView.qml")
    }
    Keys.onEscapePressed: {
        console.log("The key pressed")
        topLoader.setSource("FolderEntriesView.qml")
    }
}
