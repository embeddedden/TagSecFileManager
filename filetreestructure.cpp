#include "filetreestructure.h"
#include <memory>
#include <QFileInfoList>
#include <QDebug>

FileTreeStructure::FileTreeStructure(QObject *parent) : QObject(parent)
{
    //TODO: exceptions?
    currentDir = std::make_unique<QDir>(".");

}

void FileTreeStructure::populateDir () {
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

bool FileTreeStructure::changeDir(const QString &newDir)
{
    if (!currentDir->cd(newDir))
    {
        qDebug() << "Not a directory";
        return false;
    } else {
        populateDir();
        emit fileListModelChanged();
        emit objectListModelChanged();
    }
    return true;
}

const QStringList FileTreeStructure::getTypedDirContent() {
    QStringList typedContent;
    for (int i = 0; i < dirContent.length(); i++)
        typedContent.append(entriesTypes[i]+":"+dirContent[i]);
    return typedContent;
}

QVariant FileTreeStructure::objectListModel()
{
    //FIXME: some additional check are required (empty dir?)
    objectList.clear();
    for (int i = 0; i < dirContent.length(); i++)
        objectList.append(new FilenameObject(dirContent[i], entriesTypes[i], \
                                             entriesTypes[i]));
    return QVariant::fromValue(objectList);
}
