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
                        //anchors.fill: parent
                        Layout.fillHeight: parent
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
                            Layout.alignment: Qt.AlignRight | Qt.AlignVCenter
                            Button {
                                id: shieldButton
//                                icon.source: "Resources/shieldIcon.png"
//                                icon.width: smallIconSize
//                                icon.height: smallIconSize
                                Layout.rightMargin: 2*pxInMm
                                Layout.alignment: Qt.AlignVCenter
                                background: Rectangle {
                                    color: shieldButton.down ? "#d6d6d6" : "#f6f6f6"
                                    border.color: "#26282a"
                                    border.width: 0.1*pxInMm+1
                                    width: entryIconSize
                                    height: entryIconSize
                                    radius: 0
                                    Image {
                                        anchors.fill: parent
                                        fillMode: Image.PreserveAspectFit
                                        source: "Resources/shieldIcon.png"
                                    }
                                }
                                onClicked: { console.info("Shielded"); topLoader.source="ProtectionDialog.qml"}
                            }
                            Button {
                                id: infoButton
                                //width: smallIconSize
                                //height: smallIconSize
//                                icon.source: "Resources/infoIcon.png"
//                                icon.width: smallIconSize
//                                icon.height: smallIconSize
                                Layout.rightMargin: 4*pxInMm
                                Layout.alignment: Qt.AlignVCenter
                                background: Rectangle {
                                    color: infoButton.down ? "#d6d6d6" : "#f6f6f6"
                                    border.color: "#26282a"
                                    border.width: 0.1*pxInMm+1
                                    width: entryIconSize
                                    height: entryIconSize
                                    radius: 0
                                    Image {
                                        anchors.fill: parent
                                        fillMode: Image.PreserveAspectFit
                                        source: "Resources/infoIcon.png"
                                    }
                                }
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
