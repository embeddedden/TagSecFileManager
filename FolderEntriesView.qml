import QtQuick 2.9
import QtQuick.Window 2.3
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.4
import QtQuick.Controls.Styles 1.4
import QtQml.Models 2.3

Rectangle {
    id: entryListRect
    anchors.fill: parent
    ScrollView {
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.top: parent.top
        focus: true
        Keys.onDownPressed: entryList.incrementCurrentIndex()
        Keys.onUpPressed: entryList.decrementCurrentIndex()
        ListView {
            id:entryList
            model: fts.fileListModel
            clip: true
            keyNavigationEnabled: true
            highlightFollowsCurrentItem: true
            currentIndex: 0
            Component {
                id: entryItem
                // define an item of a list of dir entries
                //TODO: what to do if we can't populate (empty dir (due to mistake))
                Rectangle {
                    id: itemRect
                    width: parent.width
                    height: entryHeight
                    color: "transparent"
                    border.width: 0.5*Screen.pixelDensity
                    border.color: "grey"
                    radius: elementRectRadius
                    // make item selectable by placing a MouseArea inside
                    MouseArea {
                        anchors.fill: parent
                        propagateComposedEvents: true
                        onClicked: {entryList.currentIndex = index; mouse.accepted=false;}
                        onDoubleClicked: {fts.changeDir(firstText.text)}
                    }
                    RowLayout{
                        width: parent.width
                        anchors.fill: parent
                        Rectangle {
                            width: iconImage.width
                            id: zeroRec
                            border.width:  0// 0.1*pxInMm+1
                            radius: 0
                            height: entryIconSize
                            Layout.leftMargin: 1*pxInMm
                            Layout.topMargin: 2*pxInMm
                            Layout.alignment: Qt.AlignVCenter
                            Image {
                                id: iconImage
                                width: entryIconSize
                                height: entryIconSize
                                fillMode: Image.PreserveAspectFit
                                source: "Resources/" + modelData.split(':')[0]+"Icon.png"
                            }
                        }
                        Text {
                            id: firstText
                            text: modelData.split(':')[1]
                            Layout.fillWidth: true
                            font.pointSize: fontDefaultSize
                            font.family: fontDefaultFamily
                            elide: Text.ElideRight
                        }
                        RowLayout {
                            anchors.verticalCenter: parent.verticalCenter
                            Button {
                                id: shieldButton
                                Layout.rightMargin: 2*pxInMm
                                Layout.alignment: Qt.AlignVCenter
                                text: "Tags"
                                onClicked: { console.info("Shielded"); topLoader.source="ProtectionDialog.qml"}
                            }
                            Button {
                                id: infoButton
                                text: "Info"
                                Layout.rightMargin: 4*pxInMm
                                anchors.horizontalCenter: parent.verticalCenter
                            }
                        }
                    }
                }
            }
            delegate: entryItem
            highlight:  Rectangle { border.color: highlightBorderColor; border.width: highlightBorderWidth; radius: 5; z: highlightZ; color: "#CCCCCC"}
            spacing: 3
        }
    }
}
