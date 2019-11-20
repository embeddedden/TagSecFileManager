#ifndef SECURITYTAGSMANAGER_H
#define SECURITYTAGSMANAGER_H

#include <QObject>
#include <QString>
#include <QStringList>
#include <QList>
#include <QVariant>
#include <QVariantList>
#include <QDebug>

class TagObject : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QString tagName READ tagName NOTIFY tagNameChanged)
    Q_PROPERTY(bool attached READ attached NOTIFY attachedChanged)

public:
    TagObject(QObject *parent=0):QObject(parent){}
    TagObject(const QString &tagName, const bool attached, QObject *parent=0):
        QObject(parent)
    {
        m_tagName = tagName;
        m_attached = attached;
    }

    QString tagName () const
    {
        return m_tagName;
    }
    bool attached () const
    {
        return m_attached;
    }
    void setAttached(bool newVal)
    {
        m_attached = newVal;
    }
signals:
    void tagNameChanged();
    void attachedChanged();

private:
    QString m_tagName;
    bool m_attached;
};

class SecurityTagsManager : public QObject
{
    Q_OBJECT

    Q_PROPERTY(QVariant secTags READ secTags NOTIFY secTagsChanged)

public:
    explicit SecurityTagsManager(QObject *parent = nullptr);

    //returns tags of a file filename
    QVariant secTags();
    Q_INVOKABLE void updateTags();
    Q_INVOKABLE void detachTag(QString fileName, QString tagName);
    Q_INVOKABLE void attachTag(QString fileName, QString tagName);
signals:
    void secTagsChanged();

public slots:

private:
    QList <QObject*> tmpTags;
};

#endif // SECURITYTAGSMANAGER_H
