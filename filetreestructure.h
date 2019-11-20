#ifndef FILETREESTRUCTURE_H
#define FILETREESTRUCTURE_H

#include <QObject>
#include <QDir>
#include <QString>
#include <QStringList>
#include <QList>
#include <QVariant>
#include <memory>

class FilenameObject : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QString filename READ filename NOTIFY filenameChanged)
    Q_PROPERTY(QString fullPath READ fullPath NOTIFY fullPathChanged)
    Q_PROPERTY(QString objectType READ objectType NOTIFY objectTypeChanged)
public:
    FilenameObject(QObject *parent=0):QObject(parent){}
    FilenameObject(QString &fileName, QString &fullPath, QString &objectType,
                   QObject *parent=0):QObject(parent),m_filename(fileName),
                   m_fullPath(fullPath),m_objectType(objectType){}
    virtual ~FilenameObject() {}

    QString filename() const
    {
        return m_filename;
    }
    QString fullPath() const
    {
        return m_fullPath;
    }
    QString objectType() const
    {
        return m_objectType;
    }
signals:
    void filenameChanged();
    void fullPathChanged();
    void objectTypeChanged();

private:
    QString m_filename, m_fullPath, m_objectType;
};

class FileTreeStructure : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QStringList fileListModel READ getTypedDirContent NOTIFY fileListModelChanged)
    Q_PROPERTY(QVariant objectListModel READ objectListModel NOTIFY objectListModelChanged)
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
    QVariant objectListModel();
private:
    std::unique_ptr<QDir> currentDir;
    QStringList dirContent;
    QStringList entriesTypes;
    QList <QObject*> objectList;

    //Obtain directory's content
    void populateDir ();
signals:
    void fileListModelChanged();
    void objectListModelChanged();
public slots:
};

#endif // FILETREESTRUCTURE_H
