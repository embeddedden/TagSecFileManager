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
    property int pxInMm: Screen.pixelDensity  //to define sizes in millimeters
    property int entryHeight: 12*pxInMm
    property int entryIconSize: entryHeight-4*pxInMm //mm
    property int smallIconSize: entryIconSize-2*pxInMm

//    FolderEntriesView {
//        id: comp
//    }

    Loader {
        id: topLoader
        anchors.fill: parent
        source: "FolderEntriesView.qml"
    }
}
