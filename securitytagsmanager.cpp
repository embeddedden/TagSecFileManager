#include "securitytagsmanager.h"

SecurityTagsManager::SecurityTagsManager(QObject *parent) : QObject(parent)
{
    tmpTags.append(new TagObject("Tag 1", true));
    tmpTags.append(new TagObject("Tag 2", true));
    tmpTags.append(new TagObject("Tag 3", false));
}

QVariant SecurityTagsManager::secTags()
{
    //Q_UNUSED(fileName);
    return QVariant::fromValue(tmpTags);
}

Q_INVOKABLE void SecurityTagsManager::updateTags()
{
    //tmpTags.append("Tag 4");
    emit secTagsChanged();
}

void SecurityTagsManager::detachTag(QString fileName, QString tagName)
{
    Q_UNUSED(fileName);
    TagObject * a;
    for (auto t:tmpTags)
    {
        a = dynamic_cast<TagObject*>(t);
        if (a->tagName() == tagName)
        {
            a->setAttached(false);
            qDebug() << a->tagName() << "changed to false";
            break;
        }
    }
}

void SecurityTagsManager::attachTag(QString fileName, QString tagName)
{
    Q_UNUSED(fileName);
    TagObject * a;
    for (auto t:tmpTags)
    {
        a = dynamic_cast<TagObject*>(t);
        if (a->tagName() == tagName)
        {
            a->setAttached(true);
            qDebug() << a->tagName() << "changed to true";
            break;
        }
    }
}
