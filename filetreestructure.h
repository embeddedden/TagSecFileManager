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
public:
    explicit FileTreeStructure(QObject *parent = nullptr);
//    FileTreeStructure(QObject *parent = nullptr, QString defaultStartDir = "..");

    void getEntries (const QString pathToDir);
    const QString getCurrentPath() {
        return currentDir->absolutePath();
    }
    const QStringList getDirContent() {
        return currentDir->entryList();
    }

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
signals:

public slots:
};

#endif // FILETREESTRUCTURE_H
