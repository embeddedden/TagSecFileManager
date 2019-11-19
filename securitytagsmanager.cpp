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
