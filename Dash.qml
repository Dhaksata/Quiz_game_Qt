import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

ApplicationWindow {
    width: 700
    height: 900
    visible: true
    title: qsTr("BITApp")
    color: "black"
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

    Rectangle {
      id: wo
      width: 800
      height: 800
      color: "black"
      anchors.centerIn: parent
      anchors.horizontalCenter:parent.horizontalCenter

      ColumnLayout {
          id:ccc
           anchors.leftMargin: 100
           anchors.horizontalCenter: wo.horizontalCenter

                      Button {
                              text: "Chatbot"
                              width: 200
                                             anchors.horizontalCenter: wo.horizontalCenter

                                            background: Rectangle {
                                               color:"#7249E9"
                                                implicitWidth: 45// Set the desired width
                                                                implicitHeight: 40
                                            }
                              onClicked: {
                                  onClicked: stackView1.push(Qt.resolvedUrl("chatbot.qml"))
                                 console.log("Done!")
                              }
                              StackView {
                                  id: stackView1
                                  initialItem: Qt.resolvedUrl("chatbot.qml") // Replace with your initial QML file
                                  anchors.fill: parent
                              }
                          }

                          Button {
                              text: "Feedback"
                              width: 200
                                             anchors.horizontalCenter: wo.horizontalCenter

                                            background: Rectangle {
                                               color:"#7249E9"
                                                implicitWidth: 45// Set the desired width
                                                                implicitHeight: 40
                                            }
                              onClicked: {
                                  onClicked: stackView2.push(Qt.resolvedUrl("feedback.qml"))
                                 console.log("Done!")
                              }
                              StackView {
                                  id: stackView2
                                  initialItem: Qt.resolvedUrl("feedback.qml") // Replace with your initial QML file
                                  anchors.fill: parent
                              }
                          }


      }

      RowLayout {
          id:cccl
          anchors.centerIn: parent
                              spacing: 3
          Rectangle {
            id: log
            width: 350
            height: 470
            color: "#7249E9"
            anchors.horizontalCenter: wo.left
            anchors.leftMargin: 10
             anchors.topMargin: 50

             Text {
                         id: textItem
                         anchors.centerIn: parent
                         text: ""
                         anchors.horizontalCenter:log.center
                         font.pixelSize: 20
                     }

                     Timer {
                         id: typingTimer
                         interval: 100 // Adjust the interval to control typing speed
                         repeat: true
                         running: true

                         property int currentIndex: 0
                         property string fullText: "Explore, answer, learn, conquer."

                         onTriggered: {
                             textItem.text = fullText.substring(0, currentIndex);
                             currentIndex++;

                             if (currentIndex > fullText.length)
                                 currentIndex = 0;
                         }
                     }
                 }


          Rectangle {
            id: log2
            width: 350
            height: 470
            color: "white"
            anchors.horizontalCenter: wo.right
            anchors.rightMargin: 50
             anchors.topMargin: 50


             AnimatedImage {
                 id: unnamed

                 width: 350
                 height: 400
                 source: "qrc:/ressources/images/unnamed.gif"
                 fillMode: AnimatedImage.PreserveAspectFit
                  anchors.horizontalCenter:log2.center
                     anchors.leftMargin: 50
                  cache: true
             }
             }

          }

      Button{
          id:loginBtn2
          text:qsTr("Explore Now !")

          MouseArea {

              anchors.fill: parent

          onClicked: {
              onClicked: stackView.push(Qt.resolvedUrl("dash2.qml"))
             console.log("Done!")
          }
          }
              implicitHeight: 10
              implicitWidth: 160

              anchors.horizontalCenter: wo.horizontalCenter
              anchors.bottom:wo.bottom
              anchors.topMargin: 30
              height: 45
              width: 320
              background: Rectangle{
                  id:loginBtnBg1
                  width:parent.width
                  height: parent.height
                  color: loginBtn2.hovered ? "white":"#7249E9"
                  border.width: loginBtn2.down?3:0

                  radius: 6

              }

              StackView {
                  id: stackView
                  initialItem: Qt.resolvedUrl("dash2.qml") // Replace with your initial QML file
                  anchors.fill: parent
              }
      }
      }
}


