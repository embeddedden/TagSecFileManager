#ifndef FILETREESTRUCTURE_H
#define FILETREESTRUCTURE_H

#include <QObject>
#include <QDir>
#include <QString>
#include <QStringList>
#include <memory>

class FileTreeStructure : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QStringList fileListModel READ getTypedDirContent NOTIFY fileListModelChanged)
public:
    explicit FileTreeStructure(QObject *parent = nullptr);
//    FileTreeStructure(QObject *parent = nullptr, QString defaultStartDir = "..");

    const QString getCurrentPath() {
        return currentDir->absolutePath();
    }
    const QStringList getDirContent() {
        return currentDir->entryList();
    }
    Q_INVOKABLE bool changeDir(const QString &folder);
    // provides dirContent with its type: "type:enrtyname"
    // this code smells
    const QStringList getTypedDirContent();
    const QStringList getEntriesTypes () {
        return entriesTypes;
    }
private:
    std::unique_ptr<QDir> currentDir;
    QStringList dirContent;
    QStringList entriesTypes;

    //Obtain directory's content
    void populateDir ();
signals:
    void fileListModelChanged();
public slots:
};

#endif // FILETREESTRUCTURE_H
