
#include "../include/questionsqltablemodel.h"

#include "../include/questionsqlcolumnnames.h"

#include <QBuffer>
#include <QDebug>
#include <QPixmap>

#include <QSqlError>
#include <QSqlField>
#include <QSqlQuery>
#include <QSqlRecord>
#include <QSqlRelationalDelegate>

QuestionSqlTableModel::QuestionSqlTableModel(QObject *parent,
                                             const QSqlDatabase &db)
    : QSqlTableModel{parent, db}
{
    setTable("questions");
    setSort(QuestionColumn::id, Qt::AscendingOrder);
    if (!select()) {
        qDebug() << "QuestionSqlTableModel: Select table questions failed";
    }
    setEditStrategy(EditStrategy::OnFieldChange);
}

QVariant QuestionSqlTableModel::data(const QModelIndex &index, int role) const
{
    if (role == Qt::DisplayRole && index.column() == QuestionColumn::picture) {
        return QSqlTableModel::data(index, role).toByteArray().toBase64();
    }
    return QSqlTableModel::data(index, role);
}

bool QuestionSqlTableModel::setData(const QModelIndex &index,
                                    const QVariant &value, int role)
{
    if (role == Qt::EditRole && index.column() == QuestionColumn::picture) {
        auto picturePath = value.toString();

        auto pictureByteArray = picturePathToByteArray(picturePath);
        return QSqlTableModel::setData(index, pictureByteArray, role);
    }
    return QSqlTableModel::setData(index, value, role);
}

bool QuestionSqlTableModel::removeRows(int row, int count,
                                       const QModelIndex &parent)
{
    beginRemoveRows(parent, row, row);
    auto result = QSqlTableModel::removeRows(row, count, parent);
    if (result) {
        select(); // row is not deleted from sql database until select is called
    }
    else {
        endRemoveRows();
        return result;
    }

    while (canFetchMore()) {
        fetchMore();
    }

    for (auto i = 0; i < rowCount(); ++i) {
        QSqlTableModel::setData(createIndex(i, QuestionColumn::id), i + 1);
    }
    submitAll();
    select();
    endRemoveRows();
    return result;
}

QByteArray
QuestionSqlTableModel::picturePathToByteArray(const QString &picturePath) const
{
    QByteArray picture;
    if (!picturePath.isEmpty()) {
        QPixmap inPixmap;
        if (inPixmap.load(picturePath)) {
            QBuffer inBuffer(&picture);
            inBuffer.open(QIODevice::WriteOnly);
            inPixmap.save(&inBuffer, "PNG");
        }
    }
    return picture;
}
