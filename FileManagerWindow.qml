import QtQuick 2.9
import QtQuick.Window 2.3
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.2
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
                        width: zeroText.width
                        id: zeroRec
                        anchors.left: parent.left
                        height: 25
                        Text {
                            id: zeroText
                            text: modelData.split(':')[0]
                        }
                    }
                    Rectangle {
                        //width: parent.width
                        width: firstText.width
                        id: firstRec
                        anchors.left: zeroRec.right
                        anchors.right: parent.right
                        height: 25
                        Text {
                            id: firstText
                            text: modelData.split(':')[1]
                        }
                    }
}

            }
            delegate: entryItem
        }
    }
}
