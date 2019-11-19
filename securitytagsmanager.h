#ifndef SECURITYTAGSMANAGER_H
#define SECURITYTAGSMANAGER_H

#include <QObject>

class SecurityTagsManager : public QObject
{
    Q_OBJECT
public:
    explicit SecurityTagsManager(QObject *parent = nullptr);

signals:

public slots:
};

#endif // SECURITYTAGSMANAGER_H