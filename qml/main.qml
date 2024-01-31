import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

Window {
    width: 700
    height: 900
    visible: true
    title: qsTr("BITApp")
    color: "black"



    Rectangle {
      id: loginPage
      width: 600
      height: 600
      color: "#0F0F0F"
      anchors.centerIn: parent
      anchors.horizontalCenter:parent.horizontalCenter

      Rectangle {
        id: header
        width: parent.width
        height: 880
        color: "#000000"
        anchors.centerIn: parent
        anchors.topMargin:2

        Text {
          id: tit
          text: "ProSkillQuiz"

           horizontalAlignment: Text.AlignHCenter

            width: parent.width
          font.family: "Aldrich"
          font.pixelSize: 30
          color: "white"
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


        AnimatedImage {
            id: mm
             anchors.top: img.bottom
            width: 500
            height: 480
            source: "qrc:/ressources/images/mm.gif"
            fillMode: AnimatedImage.PreserveAspectFit

             anchors.horizontalCenter:header.horizontalCenter
                anchors.leftMargin: 50
             cache: true
        }

        Button{
            id:loginBtn
            text:qsTr("Get Started ->")

            onClicked: {
                onClicked: stackView.push(Qt.resolvedUrl("two.qml"))
               console.log("Enjoy..!!")
            }
                implicitHeight: 10
                implicitWidth: 160

                anchors.horizontalCenter: header.horizontalCenter
                anchors.top: mm.bottom
                anchors.topMargin: 30
                height: 45
                width: 320
                background: Rectangle{
                    id:loginBtnBg
                    width:parent.width
                    height: parent.height
                    color: loginBtn.hovered ? "white":"#7249E9"
                    border.width: loginBtn.down?3:0

                    radius: 6

                }



    StackView {
        id: stackView
        initialItem: Qt.resolvedUrl("two.qml") // Replace with your initial QML file
        anchors.fill: parent
    }
}
}
}
}
