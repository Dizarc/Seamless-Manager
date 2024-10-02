#ifndef CLOTHESMODEL_H
#define CLOTHESMODEL_H

#include <QObject>
#include <QSqlTableModel>
#include <QSqlRecord>
#include <QFile>
#include <QUrl>

#include "Init/DatabaseController.h"

class ClothesModel : public QSqlTableModel
{
    Q_OBJECT

public:
    enum Roles{
        clothingIdRole = Qt::UserRole + 1,
        clothingNameRole,
        clothingDescriptionRole,
        clothingImageSourceRole,
        typeIdRole
    };

    explicit ClothesModel(QObject *parent = nullptr, QSqlDatabase db = QSqlDatabase());

    virtual QVariant data(const QModelIndex &index, int role) const override;
    virtual QHash<int, QByteArray> roleNames() const override;

public slots:
    bool reassignClothes(const int &oldTypeId, const int &newTypeId);

    void filterType(int typeId);

    bool renameClothing(const int &id, const QString name);
    bool changeClothingDescription(const int&id, const QString description);
    bool changeClothingImage(const int &id, const QString &ClothingImageSource);
};

#endif // CLOTHESMODEL_H
