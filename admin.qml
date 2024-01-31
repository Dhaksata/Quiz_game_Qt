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
          text: "Login"
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
        Text {
          id: title2
          text: "Please enter your login details to SignIn"
          anchors.left: parent.left
          anchors.horizontalCenter: parent.left
          anchors.leftMargin: 60
          anchors.topMargin: 30
          font.family: "Inter"
          font.pixelSize: 22
          anchors.top: title.bottom
          color: "black"
          font.bold: true
        }

        TextField {
            id:usernameField
            width: 450
            height: 50
            anchors.top:title2.bottom
            color: "black"
            anchors.topMargin: 30
            anchors.left: parent.left
            anchors.leftMargin: 60
            placeholderText: "Username"
          }

        TextField {
            id:passwordField
            width: 450
            height: 50
            anchors.top:usernameField.bottom
            anchors.topMargin: 30
            anchors.left: parent.left
            color: "black"
            anchors.leftMargin: 60
            placeholderText: "Password"
            echoMode: TextInput.Password
          }



      Button{
          id:loginBtn
          text:qsTr("Verify")
           font.pixelSize: 18

           onClicked: {
               // Check login credentials (simplified for demonstration)
               if (usernameField.text === "user" && passwordField.text === "password") {
                   // Successful login, navigate to the next page
                   onClicked: stackView1.push(Qt.resolvedUrl("main2.qml"))
               } else {
                   // Failed login, show an error message (you can add your own error handling)
                   errorLabel.text = "Invalid username or password";
               }
           }




              implicitHeight: 10
              implicitWidth: 160
              anchors.horizontalCenter: header.horizontalCenter
              anchors.top: passwordField.bottom
              anchors.topMargin: 30
              height: 45
              width: 320
              background: Rectangle{
                  id:loginBtnBg
                  width:parent.width
                  height: parent.height
                  color: loginBtn.hovered ? "lavender":"#7249E9"
                  border.width: loginBtn.down?3:0

                  radius: 6
              }
              StackView {
                  id: stackView1
                  initialItem: Qt.resolvedUrl("main2.qml") // Replace with your initial QML file
                  anchors.fill: parent
              }
      }
      Text {
          id: errorLabel
          color: "red"

          anchors.horizontalCenter: header.horizontalCenter
          anchors.top: loginBtn.bottom
      }
       }


                  }


}






