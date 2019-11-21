#include "securitytagsmanager.h"
#include <SecurityTags.h>
#include <vector>
#include <string>
#include <map>

SecurityTagsManager::SecurityTagsManager(QObject *parent) : QObject(parent)
{
    initializeTags();
//    tmpTags.append(new TagObject("Tag 1", true));
//    tmpTags.append(new TagObject("Tag 2", true));
//    tmpTags.append(new TagObject("Tag 3", false));
}

QVariant SecurityTagsManager::secTags()
{
    //Q_UNUSED(fileName);
    std::vector <std::string> tags, allTags;
    getTags(m_currentFilePath.toStdString(), tags);
    getAllPossibleTags(allTags);
    tmpTags.clear();
    for (auto t:tags)
    {
        tmpTags.append(new TagObject(QString::fromStdString(t), true));
    }
    for (auto atag:allTags)
    {
        if (std::find(tags.begin(), tags.end(), atag) == tags.end())
        {
            tmpTags.append(new TagObject(QString::fromStdString(atag), false));
        }
    }
    return QVariant::fromValue(tmpTags);
}

Q_INVOKABLE void SecurityTagsManager::updateTags()
{
    //tmpTags.append("Tag 4");
    emit secTagsChanged();
}

void SecurityTagsManager::detachTag(QString fileName, QString tagName)
{
//    Q_UNUSED(fileName);
//    TagObject * a;
//    for (auto t:tmpTags)
//    {
//        a = dynamic_cast<TagObject*>(t);
//        if (a->tagName() == tagName)
//        {
//            a->setAttached(false);
//            qDebug() << a->tagName() << "changed to false";
//            break;
//        }
//    }
    removeTag(fileName.toStdString(), tagName.toStdString());
    secTags();
    emit secTagsChanged();
}

void SecurityTagsManager::attachTag(QString fileName, QString tagName)
{
//    Q_UNUSED(fileName);
//    TagObject * a;
//    for (auto t:tmpTags)
//    {
//        a = dynamic_cast<TagObject*>(t);
//        if (a->tagName() == tagName)
//        {
//            a->setAttached(true);
//            qDebug() << a->tagName() << "changed to true";
//            break;
//        }
//    }
    addTag(fileName.toStdString(), tagName.toStdString());
    secTags();
    emit secTagsChanged();
}
