
#ifndef QUESTIONSQLTABLEMODEL_H
#define QUESTIONSQLTABLEMODEL_H

#include <QSqlTableModel>



class QuestionSqlTableModel : public QSqlTableModel {
    Q_OBJECT
public:
    explicit QuestionSqlTableModel(QObject *parent = nullptr,
                                   const QSqlDatabase &db = QSqlDatabase());

    QVariant data(const QModelIndex &index, int role) const override;

    bool setData(const QModelIndex &index, const QVariant &value,
                 int role) override;

    bool removeRows(int row, int count, const QModelIndex &parent) override;

private:
    QByteArray picturePathToByteArray(const QString &picturePath) const;
};

#endif // QUESTIONSQLTABLEMODEL_H
