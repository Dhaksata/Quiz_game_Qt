

import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Window 2.15
import Qt.labs.qmlmodels 1.0
import Qt.labs.settings 1.0
import QtQuick.Controls.Material 2.15

import DatabaseManagers 1.0
import LanguageSelectors 1.0
import QuestionsProxyModels 1.0
import RandomQuestionFilterModels 1.0

import "info_dialog"
import "add_new_question_dialog"
import "database"
import "database/sql_table_view"
import "settings_dialog"

ApplicationWindow {
    id: root
    visible: true
    width: 700
    height: 900
    title: qsTr("Quiz")

    signal rowMarkedForDeleteFromDatabase(int row)
    signal valueMarkedForUpdateInDatabase(int row, var value, string role)
    signal newEntryDataForDatabase(string question, string answer1, string answer2, string answer3, string answer4, int correctAnswer, string picturePath)

    readonly property int __showTableWidth: 1460
    readonly property int __defaultWidth: 880

    property int countOfQuestions: 10
    property bool darkModeOn
    property url currentDatabasePath

    readonly property string __newQuizPath: "qrc:/qml/quiz/Quiz.qml"
    readonly property string __showDatabasePath: "qrc:/qml/database/sql_table_view/SqlTableView.qml"
    readonly property string __addNewQuestionDialog: "qrc:/qml/add_new_question_dialog/AddNewQuestionDialog.qml"
    readonly property string __resultPath: "qrc:/qml/result/Result.qml"
    readonly property string __settingsDialogPath: "qrc:/qml/settings_dialog/SettingsDialog.qml"

    Settings {
        id: settings
        property int language: LanguageSelector.English
        property int countOfQuestions: 10
        property bool darkModeOn: false
        property url currentDatabasePath: ""
    }

    Component.onCompleted: {
        loadSettings()
        reevaluateNewQuizButtonEnabled()
        reevaluateAddQuestionButtonEnabled()
    }

    Component.onDestruction: {
        saveSettings()
    }

    Loader {
        id: contentLoader
        anchors.fill: parent
        onLoaded: {
            reevaluateNewQuizButtonEnabled()
            reevaluateDatabaseButtonEnabled()
            reevaluateAddQuestionButtonEnabled()
            reevaluateSettingsButtonEnabled()
        }
    }

    Loader {
        id: addNewQuestionloader
        anchors.fill: parent
    }

    Loader {
        id: settingsloader
        anchors.fill: parent
    }

    header: ToolBar {
        anchors.horizontalCenter: parent.horizontalCenter

        Flow {
            anchors.fill: parent

            ToolButton {
                id: databaseButton
                text: qsTr("Database")
                icon.name: "document-open"
                onClicked: databaseMenu.popup()

                Menu {
                    id: databaseMenu
                    MenuItem {
                        text: qsTr("Show current")
                        enabled: root.currentDatabasePath != ""
                        onClicked: showDatabase()
                    }
                    MenuItem {
                        text: qsTr("Close current")
                        enabled: root.currentDatabasePath != ""
                        onClicked: closeDatabase()
                    }
                    MenuItem {
                        text: qsTr("Open existing")
                        enabled: root.currentDatabasePath == ""
                        onClicked: chooseDatabaseDialog.open()
                    }
                    MenuItem {
                        text: qsTr("Create new")
                        enabled: root.currentDatabasePath == ""
                        onClicked: createDatabaseDialog.open()
                    }
                }
            }

            ToolButton {
                id: addQuestionButton
                text: qsTr("Add Question")
                icon.name: "document-new"
                onClicked: showAddNewQuestionDialog()
            }
            ToolButton {
                id: logout
                text: qsTr("Logout")

                onClicked: Qt.quit()
            }

        }
    }

    ChooseDatabaseDialog {
        id: chooseDatabaseDialog

        onAccepted: {
            root.currentDatabasePath = chooseDatabaseDialog.fileUrl
        }
    }

    CreateDatabaseDialog {
        id: createDatabaseDialog

        onAccepted: {
            root.currentDatabasePath = createDatabaseDialog.fileUrl
        }
    }

    footer: Label {
        id: openDatabaseLabel
        text: getOpenDatabaseLabelText()
    }

    onCurrentDatabasePathChanged: {
        openDatabaseLabel.text = getOpenDatabaseLabelText()
        loadDatabaseFromPath()
    }

    InfoDialog {
        id: databaseErrorInfoDialog
        title: qsTr("Database loading error")
    }

    onDarkModeOnChanged: selectColorMode()

    Connections {
        id: quizConnections
        target: contentLoader.item
        ignoreUnknownSignals: contentLoader.source !== root.__newQuizPath

        function onFinnished(correctAnswers) {
            contentLoader.setSource(root.__resultPath, {
                                        "correctAnswers": correctAnswers,
                                        "countOfQuestions": countOfQuestions
                                    })
        }
    }

    Connections {
        id: databaseConnections
        target: contentLoader.item
        ignoreUnknownSignals: contentLoader.source !== root.__showDatabasePath

        function onDeleteRow(row) {
            rowMarkedForDeleteFromDatabase(row)
        }

        function onValueChanged(row, value, role) {
            valueMarkedForUpdateInDatabase(row, value, role)
        }
    }

    Connections {
        id: settingsDialogConnections
        target: settingsloader.item
        ignoreUnknownSignals: contentLoader.source !== root.__settingsDialogPath

        function onCountOfQuestionsChanged() {
            root.countOfQuestions = settingsloader.item.countOfQuestions
            reevaluateNewQuizButtonEnabled()
        }
        function onDarkModeOnChanged() {
            root.darkModeOn = settingsloader.item.darkModeOn
            selectColorMode()
        }
    }
    Connections {
        id: addNewQuestionDialogConnections
        target: addNewQuestionloader.item
        ignoreUnknownSignals: contentLoader.source !== root.__addNewQuestionDialog

        function onNewEntryData(question, answer1, answer2, answer3, answer4, correctAnswer, picturePath) {
            newEntryDataForDatabase(question, answer1, answer2, answer3,
                                    answer4, correctAnswer, picturePath)
        }

        function onAccepted() {
            reevaluateNewQuizButtonEnabled()
        }
    }

    function loadSettings() {
        LanguageSelector.language = settings.language
        root.countOfQuestions = settings.countOfQuestions
        root.darkModeOn = settings.darkModeOn
        root.currentDatabasePath = settings.currentDatabasePath
    }

    function saveSettings() {
        settings.language = LanguageSelector.language
        settings.countOfQuestions = root.countOfQuestions
        settings.darkModeOn = root.darkModeOn
        settings.currentDatabasePath = root.currentDatabasePath
    }

    function reevaluateNewQuizButtonEnabled() {
        if (root.countOfQuestions == 0) {
            newQuizButton.enabled = false
            return
        }
        if (root.currentDatabasePath == "") {
            newQuizButton.enabled = false
            return
        }
        if (contentLoader.source == root.__newQuizPath) {
            newQuizButton.enabled = false
            return
        }
        newQuizButton.enabled = QuestionsProxyModel.rowCount(
                    ) >= root.countOfQuestions
    }

    function reevaluateDatabaseButtonEnabled() {
        databaseButton.enabled = contentLoader.source != root.__newQuizPath
    }

    function reevaluateAddQuestionButtonEnabled() {
        if (root.currentDatabasePath == "") {
            addQuestionButton.enabled = false
            return
        }
        addQuestionButton.enabled = contentLoader.source != root.__newQuizPath
    }

    function reevaluateSettingsButtonEnabled() {
        settingsButton.enabled = contentLoader.source != root.__newQuizPath
    }

    function showNewQuiz() {
        root.width = root.__defaultWidth
        RandomQuestionFilterModel.generateRandomQuestions(countOfQuestions)
        contentLoader.setSource(root.__newQuizPath)
    }

    function showDatabase() {
        root.width = root.__showTableWidth
        contentLoader.setSource(root.__showDatabasePath)
    }

    function closeDatabase() {
        root.width = root.__defaultWidth
        contentLoader.setSource("")
        root.currentDatabasePath = ""
    }

    function showAddNewQuestionDialog() {
        addNewQuestionloader.active = false
        addNewQuestionloader.active = true
        if (addNewQuestionloader.source !== root.__addNewQuestionDialog) {
            addNewQuestionloader.setSource(root.__addNewQuestionDialog)
        }
        addNewQuestionloader.item.open()
    }

    function showSettingsDialog() {
        settingsloader.active = false
        settingsloader.active = true
        if (settingsloader.source !== root.__settingsDialogPath) {
            settingsloader.setSource(root.__settingsDialogPath, {
                                         "countOfQuestions": root.countOfQuestions,
                                         "darkModeOn": root.darkModeOn
                                     })
        }
        settingsloader.item.open()
    }

    function getOpenDatabaseLabelText() {
        return qsTr("Database: %1").arg(currentDatabasePath)
    }

    function loadDatabaseFromPath() {
        if (root.currentDatabasePath != "") {
            if (!DatabaseManager.changeDatabaseConnection(
                        root.currentDatabasePath)) {
                root.currentDatabasePath = ""
                reevaluateNewQuizButtonEnabled()
                reevaluateAddQuestionButtonEnabled()
                databaseErrorInfoDialog.text = DatabaseManager.lastError()
                databaseErrorInfoDialog.open()
            }
        }
    }

    function selectColorMode() {
        if (root.darkModeOn) {
            Material.theme = Material.Dark
        } else {
            Material.theme = Material.Light
        }
    }
}
