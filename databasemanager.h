
#ifndef DATABASEMANAGER_H
#define DATABASEMANAGER_H

#include <QObject>

class QUrl;
class QSqlDatabase;

class QuestionSqlTableModel;
class QuestionsProxyModel;
class RandomQuestionFilterModel;



class DatabaseManager : public QObject {
    Q_OBJECT
public:
    explicit DatabaseManager(QObject *parent = nullptr);


    Q_INVOKABLE bool changeDatabaseConnection(const QUrl &databasePath);


    Q_INVOKABLE QString lastError() const;


    QuestionsProxyModel *questionsProxyModel() const;
    RandomQuestionFilterModel *randomQuestionFilterModel() const;

private:
    QString mCurrentConnectionName;
    QString mLastError;
    bool databaseExists(const QUrl &dbPath) const;
    bool createQuestionTable(QSqlDatabase &db);
    QString getNewConnectionName() const;
    void validateDatabase(const QSqlDatabase &db);

    QuestionSqlTableModel *mQuestionsSqlTableModel{nullptr};
    QuestionsProxyModel *mQuestionsProxModel{nullptr};
    RandomQuestionFilterModel *mRandomQuestionFilterModel{nullptr};
};

#endif // DATABASEMANAGER_H
