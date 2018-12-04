#include "filetreestructure.h"
#include <memory>
#include <QFileInfoList>
#include <QDebug>

FileTreeStructure::FileTreeStructure(QObject *parent) : QObject(parent)
{
    //TODO: exceptions?
    currentDir = std::make_unique<QDir>(".");

}

void FileTreeStructure::getEntries (const QString pathToDir) {
    currentDir = std::make_unique<QDir>(pathToDir);
    dirContent = currentDir->entryList();
    entriesTypes.clear();
    QFileInfoList currentDirInfo = currentDir->entryInfoList();
    for (int i = 0; i < currentDirInfo.length(); ++i) {
        if (currentDirInfo[i].isDir()) {
            entriesTypes.append("dir");
            qDebug() << "dir:" << dirContent[i];
        } else if (currentDirInfo[i].isFile()) {
            entriesTypes.append("file");
            qDebug() << "file:" << dirContent[i];
        } else {
            entriesTypes.append("other");
            qDebug() << "other:" << dirContent[i];
        }
    }
}

const QStringList FileTreeStructure::getTypedDirContent() {
    QStringList typedContent;
    for (int i = 0; i < dirContent.length(); i++)
        typedContent.append(entriesTypes[i]+":"+dirContent[i]);
    return typedContent;
}
