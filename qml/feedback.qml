import QtQuick 2.15
import QtQuick.Controls 2.15

ApplicationWindow {
    visible: true
    width: 400
    height: 300
    title: "Feedback Form"
     color: "black"


    Rectangle {
        width: parent.width
        height: parent.height
         color: "lavender"

        Column {
            spacing: 10
            anchors.centerIn: parent

            Label {
                text: "Feedback Form"
                font.pixelSize: 20
                horizontalAlignment: Text.AlignHCenter
            }

            TextField {
                placeholderText: "Name"
                id: nameInput
            }

            TextField {
                placeholderText: "Email"
                id: emailInput
            }

            TextArea {
                placeholderText: "Feedback"
                id: feedbackInput
                height: 100
            }

            Button {
                text: "Submit"
                onClicked: {
                    var name = nameInput.text;
                    var email = emailInput.text;
                    var feedback = feedbackInput.text;

                    // Handle the feedback data here (e.g., send it to a server)
                    console.log("Name: " + name);
                    console.log("Email: " + email);
                    console.log("Feedback: " + feedback);

                    // Clear the input fields
                    nameInput.text = "";
                    emailInput.text = "";
                    feedbackInput.text = "";
                }
            }
        }
    }
}

