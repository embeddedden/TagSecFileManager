

#include <QApplication>
#include <QQmlApplicationEngine>
#include <QtQml>
#include <QQmlEngine>

int main(int argc, char *argv[])
{
    QApplication app(argc, argv);
    QQmlApplicationEngine engine(QUrl(QStringLiteral("qrc:/FileManagerWindow.qml")));

    int rc = app.exec();
    return rc;

}
