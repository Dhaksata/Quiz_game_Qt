
import QtQuick.Dialogs 1.2

FileDialog {
    id: selectDatabaseFileDialog
    title: qsTr("Please choose an existing database")
    folder: shortcuts.home
    nameFilters: [qsTr("Database (*.db)")]
    selectExisting: true
    selectMultiple: false
    selectFolder: false
}
