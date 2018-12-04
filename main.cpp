#include <QApplication>
#include <QQmlApplicationEngine>
#include <QtQml>
#include <QQmlEngine>
#include <QDebug>

#include <qqmlengine.h>
#include <qqmlcontext.h>
#include <qqml.h>
#include <QtQuick/qquickitem.h>
#include <QtQuick/qquickview.h>

#include "filetreestructure.h"


int main(int argc, char *argv[])
{
    QApplication app(argc, argv);
    QQmlApplicationEngine engine(QUrl(QStringLiteral("qrc:/FileManagerWindow.qml")));
    FileTreeStructure fts;
    fts.getEntries("./");

    qDebug() << fts.getCurrentPath() << fts.getDirContent();

    QQmlContext * ctxt = engine.rootContext();
    ctxt->setContextProperty("fileListModel", QVariant::fromValue(fts.getTypedDirContent()));
 //   ctxt->setContextProperty("entriesTypes", fts.getEntriesTypes());
    //engine.load(QUrl(QStringLiteral("qrc:/FileManagerWindow.qml")));
    int rc = app.exec();
    return rc;

}
