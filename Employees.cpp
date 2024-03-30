#include "Employees.h"

#include <QSqlRecord>

Employees::Employees(QObject *parent, QSqlDatabase db) : QSqlTableModel(parent, db)
{
    setTable("Employees");
    select();
}

QVariant Employees::data(const QModelIndex &index, int role) const
{
    if(role < Qt::UserRole){
       return QSqlTableModel::data(index, role);
    }

    QVariant value;

    QModelIndex primaryKeyIndex = QSqlTableModel::index(index.row(), 0);

    int row = primaryKeyIndex.data().toInt();

    switch (role) {
    case idRole:
        value = row;
        break;
    case firstnameRole:
        value = QSqlTableModel::data(this->index(index.row(), 1));
        break;
    case lastnameRole:
        value = QSqlTableModel::data(this->index(index.row(), 2));
        break;
    case usernameRole:
        value = QSqlTableModel::data(this->index(index.row(), 3));
        break;
    case passwordRole:
        value = QSqlTableModel::data(this->index(index.row(), 4));
        break;
    case emailRole:
        value = QSqlTableModel::data(this->index(index.row(), 5));
        break;
    case phoneRole:
        value = QSqlTableModel::data(this->index(index.row(), 6));
        break;
    default:
        break;
    }

    return value;
}

QHash<int, QByteArray> Employees::roleNames() const
{
    QHash<int, QByteArray> roles;

    roles[idRole] = "id";
    roles[firstnameRole] = "firstname";
    roles[lastnameRole] = "lastname";
    roles[usernameRole] = "username";
    roles[passwordRole] = "password";
    roles[emailRole] = "email";
    roles[phoneRole] = "phone";

    return roles;
}

/*
    updateEmployee and changePasswordEmployee use two different ways to change the data in an sql table.
    updateEmployee uses the index from the delegate
    changePasswordEmployee uses the id from the row.
*/
bool Employees::updateEmployee(const int &index, const QString &firstname, const QString &lastname, const QString &username, const QString &email, const QString &phone)
{

    this->setTable("Employees");
    this->select();

    QModelIndex firstnameIndex = this->index(index, 1);
    QModelIndex lastnameIndex = this->index(index, 2);
    QModelIndex usernameIndex = this->index(index, 3);
    QModelIndex emailIndex = this->index(index, 5);
    QModelIndex phoneIndex = this->index(index, 6);

    this->setData(firstnameIndex, firstname, Qt::EditRole);
    this->setData(lastnameIndex, lastname, Qt::EditRole);
    this->setData(usernameIndex, username, Qt::EditRole);
    this->setData(emailIndex, email, Qt::EditRole);
    this->setData(phoneIndex, phone, Qt::EditRole);

    emit editedEmployee();

    return this->submitAll();
}

bool Employees::changePasswordEmployee(const int &id, const QString &oldPassword, const QString &newPassword)
{
    QSqlTableModel model;

    model.setTable("Employees");
    model.setFilter("id = "+ QString::number(id) + " AND password = '"+ oldPassword + "'");
    model.select();

    QSqlRecord record = model.record(0);
    record.setValue("password", newPassword);
    model.setRecord(0, record);

    if(!record.isNull("id"))
        emit passwordChanged();
    else
        emit wrongPassword();

    return model.submitAll();
}

bool Employees::deleteEmployee(const int &index)
{
    QSqlQuery query;
    this->setTable("Employees");
    this->select();

    this->removeRow(index);
    this->select();

    emit deletedEmployee();

    return this->submitAll();
}

bool Employees::searchEmployee(const QString &firstname, const QString &lastname, const QString &username, const QString &email, const QString &phone)
{
    this->setTable("Employees");
    this->setFilter("(firstname LIKE CONCAT('" + firstname + "', '%') OR '" + firstname + "' = '')"
                    + " AND "
                    + "(lastname LIKE CONCAT('" + lastname + "', '%') OR '" + lastname + "' = '')"
                    + " AND "
                    + "(username LIKE CONCAT('" + username + "', '%') OR '" + username + "' = '')"
                    + " AND "
                    + "(email LIKE CONCAT('" + email + "', '%') OR '" + email + "' = '')"
                    + " AND "
                    + "(phone LIKE CONCAT('" + phone + "', '%') OR '" + phone + "' = '')"
                    );
    return this->select();
}
