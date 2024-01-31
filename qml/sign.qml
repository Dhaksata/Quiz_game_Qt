import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

ApplicationWindow {
    width: 700
    height: 900
    visible: true
    title: qsTr("BITApp")
    color: "lavender"

    Rectangle {
      id: loginPage
      width: 600
      height: 600
      color: "lavender"
      anchors.centerIn: parent
      anchors.horizontalCenter:parent.horizontalCenter

      // Header
      Rectangle {
        id: header
        width: parent.width
        height: 880
        color: "lavender"
        anchors.centerIn: parent
        anchors.topMargin:2

        Text {
          id: tit
          text: "ProSkillQuiz"
          horizontalAlignment: Text.AlignHCenter
          width: parent.width
          font.family: "Aldrich"
          font.pixelSize: 30
          color: "black"
          font.bold: true
          anchors.bottomMargin:15
}
      }

      Image {
                  id:img
                  source: "qrc:/ressources/images/logo.jpg"
                  anchors.top: tit.bottom// Anchored to the top edge
                  anchors.leftMargin:50
                  width: 250
                  anchors.horizontalCenter:header.horizontalCenter
                  height: 230
              }

      Text {
        id: title
        text: "SignUp"
        anchors.left: parent.left
        anchors.top: img.bottom
        anchors.horizontalCenter: parent.left
        anchors.leftMargin: 60
        anchors.topMargin: 50
        font.family: "Inter"
        font.pixelSize: 26
        color: "black"
        font.bold: true
      }

        Column {
            anchors.centerIn: parent
            spacing: 10

            Label {
                text: "Create an Account"
                font.bold: true
                font.pixelSize: 18
            }

            TextField {
                id: usernameInput
                width: parent.width - 20
                placeholderText: "Username"
            }

            TextField {
                id: passwordInput
                width: parent.width - 20
                placeholderText: "Password"
                echoMode: TextInput.Password
            }

            Button {
                text: "Sign Up"
                onClicked: {
                    var username = usernameInput.text
                    var password = passwordInput.text
                    if (usernameInput.text === "dhaks" && passwordInput.text === "dhaks@04") {
                        // Successful login, navigate to the next page
                        onClicked: stackView1.push(Qt.resolvedUrl("Login.qml"))
                    } else {
                        // Failed login, show an error message (you can add your own error handling)
                        errorLabel.text = "Invalid username or password";
                    }


                    // Implement your sign-up logic here
                    // For this example, we'll just print the input values
                    console.log("Username:", username)
                    console.log("Password:", password)

                    // You can add further logic to create an account
                    // For instance, send this data to a server for registration
                }
            }
            }
        }
    }


