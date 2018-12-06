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
        ListView {
            id:entryList
            model: fileListModel
            Component {
                id: entryItem
                RowLayout{
                    Rectangle {
                        width: iconImage.width
                        id: zeroRec
                        anchors.left: parent.left
                        height: 32
                        Image {
                            id: iconImage
                            height: 24
                            source: "Resources/" + modelData.split(':')[0]+"Icon.png"
                        }

                        //                        Text {
                        //                            id: zeroText
                        //                            text: modelData.split(':')[0]
                        //                        }
                    }
                    Rectangle {
                        //width: parent.width
                        width: firstText.width
                        id: firstRec
                        anchors.left: zeroRec.right

                        height: 32
                        Text {
                            id: firstText
                            text: modelData.split(':')[1]
                        }
                    }
                    RowLayout {
//                        anchors.left: firstRec.right
//                        anchors.right: parent.right
                        Button {
                            id: shieldButton
                            icon.source: "Resources/shieldIcon.png"
                            icon.width: 24
                            icon.height: 24
                            background: Rectangle {
                                width: 32
                                height: 32
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
                            background: Rectangle {
                                width: 32
                                height: 32
                                color: infoButton.down ? "#d6d6d6" : "#f6f6f6"
                                border.color: "#26282a"
                                border.width: 1
                                radius: 4
                            }
                        }

                    }
                }

            }
            delegate: entryItem
        }
    }
}
