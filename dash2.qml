
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



             Column{
                 id:col
                 anchors.top: textItem.bottom
                 anchors.horizontalCenter:log.center
                 anchors.centerIn: log

             Button{
                 id:tec
                 text:qsTr("Technical Skill")


                 onClicked: {
                     onClicked: stackView1.push(Qt.resolvedUrl("main1.qml"))
                    console.log("Done!")
                 }

                     implicitHeight: 10
                     implicitWidth: 160

                   anchors.horizontalCenter:log.center
                     anchors.topMargin: 30
                     height: 45
                     width: 200
                     background: Rectangle{
                         id:tech1
                         width:parent.width
                         height: parent.height
                         color: tech1.hovered ? "#7249E9":"lavender"
                         border.width: tech1.down?3:0

                         radius: 6

                     }

                     StackView {
                         id: stackView1
                         initialItem: Qt.resolvedUrl("main1.qml")
                         anchors.fill: parent
                     }

       }
                     Button{
                         id:apti
                         text:qsTr("Aptitude Skill")


                         onClicked: {
                             onClicked: stackView2.push(Qt.resolvedUrl("main1.qml"))
                            console.log("Done!")
                         }

                             implicitHeight: 10
                             implicitWidth: 160

                           anchors.horizontalCenter:log.center
                             anchors.topMargin: 30
                             height: 45
                             width: 200
                             background: Rectangle{
                                 id:apti1
                                 width:parent.width
                                 height: parent.height
                                 color: apti1.hovered ? "#7249E9":"lavender"
                                 border.width: apti1.down?3:0

                                 radius: 6

                             }

                             StackView {
                                 id: stackView2
                                 initialItem: Qt.resolvedUrl("main1.qml") // Replace with your initial QML file
                                 anchors.fill: parent
                             }

                     }

                     Button{
                         id:soft
                         text:qsTr("Soft skills")



                         onClicked: {
                             onClicked: stackView3.push(Qt.resolvedUrl("main1.qml"))
                            console.log("Done!")
                         }

                             implicitHeight: 10
                             implicitWidth: 160

                            anchors.horizontalCenter:log.center
                             anchors.topMargin: 30
                             height: 45
                             width: 200
                             background: Rectangle{
                                 id:soft1
                                 width:parent.width
                                 height: parent.height
                                 color: soft1.hovered ? "#7249E9":"lavender"
                                 border.width: soft1.down?3:0

                                 radius: 6

                             }

                             StackView {
                                 id: stackView3
                                 initialItem: Qt.resolvedUrl("main1.qml") // Replace with your initial QML file
                                 anchors.fill: parent
                             }

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
                 source: "qrc:/ressources/images/tech.gif"
                 fillMode: AnimatedImage.PreserveAspectFit
                  anchors.horizontalCenter:log2.center
                     anchors.leftMargin: 50
                  cache: true
             }
             }

          }




    }
}



