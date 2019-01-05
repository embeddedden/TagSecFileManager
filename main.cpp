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
    fts.changeDir("../");

    qDebug() << fts.getCurrentPath() << fts.getDirContent();

    engine.rootContext()->setContextProperty("fts", &fts);
    int rc = app.exec();
    return rc;

}
