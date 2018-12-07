import QtQuick 2.9
import QtQuick.Window 2.3
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.4
import QtQuick.Controls.Styles 1.4
import QtQml.Models 2.3

ApplicationWindow {
    id: mainWindow
    title: qsTr("Secured File Manager")
    height: 480
    width: 640
    visible: true
    //    ListModel {
    //        id: fileListModel
    //    }
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
            model: fileListModel
            clip: true
            keyNavigationEnabled: true
            highlightFollowsCurrentItem: true
            currentIndex: 0
            Component {
                id: entryItem
                Rectangle {
                    id: itemRect
                    width: parent.width
                    height: 36
                    color: "transparent"
                    border.width: 0.5
                    //border.color: "grey"
                    radius: 5
                    z: 5
                    MouseArea {
                           anchors.fill: parent
                           propagateComposedEvents: true
                           onClicked: {entryList.currentIndex = index; mouse.accepted=false;}

                       }
                    RowLayout{
                        width: parent.width
                        // anchors.centerIn: itemRect.verticalCenter
                        Rectangle {
                            width: iconImage.width
                            id: zeroRec
                            //anchors.left: parent.left
                            height: 32
                            Layout.leftMargin: 3
                            Layout.alignment: Qt.AlignVCenter
                            Image {
                                id: iconImage
                                fillMode: Image.PreserveAspectFit
                                source: "Resources/" + modelData.split(':')[0]+"Icon.png"
                            }
                        }

                        Text {
                            id: firstText
                            text: modelData.split(':')[1]

                        }
                        RowLayout {
                            //                        anchors.left: firstRec.right
                            //                        anchors.right: parent.right
                            //anchors.centerIn: itemRect.verticalCenter
                            Layout.alignment: Qt.AlignRight | Qt.AlignVCenter
                            Button {
                                id: shieldButton
                                icon.source: "Resources/shieldIcon.png"
                                icon.width: 24
                                icon.height: 24
                                Layout.rightMargin: 10
                                Layout.topMargin: 2
                                Layout.alignment: Qt.AlignVCenter
                                background: Rectangle {
                                    width:  iconImage.width
                                    height: iconImage.height
                                    color: shieldButton.down ? "#d6d6d6" : "#f6f6f6"
                                    border.color: "#26282a"
                                    border.width: 1
                                    radius: 4
                                }
                                onClicked: console.info("Shielded")
                            }
                            Button {
                                id: infoButton
                                icon.source: "Resources/infoIcon.png"
                                icon.width: 24
                                icon.height: 24
                                Layout.rightMargin: 20
                                Layout.topMargin: 2
                                Layout.alignment: Qt.AlignVCenter
                                background: Rectangle {
                                    width: iconImage.width
                                    height: iconImage.height
                                    color: infoButton.down ? "#d6d6d6" : "#f6f6f6"
                                    border.color: "#26282a"
                                    border.width: 1
                                    radius: 4
                                }
                            }

                        }
                    }
                }

            }
            delegate: entryItem
            highlight:  Rectangle { border.color:  "black"; border.width: 2; radius: 5; z: 5; color: "transparent"}
            spacing: 3
        }
    }
}
