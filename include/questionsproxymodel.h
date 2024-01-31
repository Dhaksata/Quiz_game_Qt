
#ifndef QUESTIONSPROXYMODEL_H
#define QUESTIONSPROXYMODEL_H

#include <QIdentityProxyModel>


class QuestionsProxyModel : public QIdentityProxyModel {
    Q_OBJECT

    enum questionRoles {
        idRole = Qt::UserRole + 1,
        askedQuestionRole,
        answer1Role,
        answer2Role,
        answer3Role,
        answer4Role,
        correctAnswerRole,
        pictureRole
    };

public:
    QuestionsProxyModel(QObject *parent = nullptr);

    QHash<int, QByteArray> roleNames() const override;

    Q_INVOKABLE QVariant data(const QModelIndex &index,
                              int role = Qt::DisplayRole) const override;

    bool setData(const QModelIndex &index, const QVariant &value,
                 int role = Qt::EditRole) override;

public slots:
    bool addEntry(const QString &askedQuestion, const QString &answer1,
                  const QString &answer2, const QString &answer3,
                  const QString &answer4, int correctAnswer,
                  const QString &picturePath);
    void changeValue(int row, const QVariant &value, const QString &role);
    bool removeEntry(int row);

private:
    QModelIndex mapIndex(const QModelIndex &source, int role) const;
};

#endif // QUESTIONSPROXYQML_H
