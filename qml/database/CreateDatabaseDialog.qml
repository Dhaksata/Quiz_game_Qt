
import QtQuick.Dialogs 1.2

FileDialog {
    id: newDatabaseFileDialog
    title: qsTr("Please create a new database")
    folder: shortcuts.home
    nameFilters: [qsTr("Database (*.db)")]
    selectExisting: false
    selectMultiple: false
    selectFolder: false
}
