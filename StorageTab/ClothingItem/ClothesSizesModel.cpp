#include "ClothesSizesModel.h"

ClothesSizesModel::ClothesSizesModel(QObject *parent, QSqlDatabase db) : QSqlRelationalTableModel(parent, db)
{
    setTable("ClothesSizes");
    setRelation(1, QSqlRelation("Sizes", "sizeId", "sizeName"));
}

QVariant ClothesSizesModel::data(const QModelIndex &index, int role) const
{
    if(role < Qt::UserRole){
        return QSqlRelationalTableModel::data(index,role);
    }

    QVariant value;

    QModelIndex primaryKeyIndex = QSqlRelationalTableModel::index(index.row(), 0);

    int row = primaryKeyIndex.data().toInt();

    switch (role) {
    case clothingIdRole:
        value = row;
        break;
    case sizeIdRole:
        value = QSqlRelationalTableModel::data(this->index(index.row(), 1));
        break;
    case countRole:
        value = QSqlRelationalTableModel::data(this->index(index.row(), 2));
        break;
    default:
        break;
    }

    return value;
}

QHash<int, QByteArray> ClothesSizesModel::roleNames() const
{
    QHash<int, QByteArray> roles;

    roles[clothingIdRole] = "clothingId";
    roles[sizeIdRole] = "sizeId";
    roles[countRole] = "count";

    return roles;
}

void ClothesSizesModel::filterSizes(int clothingId)
{
    setFilter("clothingId = " + QString::number(clothingId));
    select();
}


