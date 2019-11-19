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

#include <QStringList>
#include "filetreestructure.h"
#include "securitytagsmanager.h"

int main(int argc, char *argv[])
{
    QApplication app(argc, argv);
    QQmlApplicationEngine engine(QUrl(QStringLiteral("qrc:/FileManagerWindow.qml")));
    FileTreeStructure fts;
    fts.changeDir("../");

    qDebug() << fts.getCurrentPath() << fts.getDirContent();
    const QString tmpFilename("picture");
    SecurityTagsManager secTagManager;
    //QVariant tagList = secTagManager.secTags();
    //engine.rootContext()->setContextProperty("stringModel", QVariant::fromValue(tagList));
    engine.rootContext()->setContextProperty("secTagManager", &secTagManager);

    engine.rootContext()->setContextProperty("fts", &fts);
    int rc = app.exec();
    return rc;

}
