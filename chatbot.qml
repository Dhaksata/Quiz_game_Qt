import QtQuick 2.15
import QtQuick.Controls 2.15

ApplicationWindow {
    visible: true
    width: 400
    height: 300
    title: "Chatbot"
     color: "black"
    Rectangle {
        width: parent.width
        height: parent.height
         color: "lavender"
        TextArea {
            id: queriesInput
            width: parent.width - 20
            height: parent.height - 100
            anchors.centerIn: parent
            placeholderText: "Chat with the bot...Please fill your Query"
        }

        Button {

            text: "Submit"
             anchors.top: queriesInput.bottom
            onClicked: {

                var queries = queriesInput.text;

                // Handle the feedback data here (e.g., send it to a server)

                console.log("Queries: " + queries);

                // Clear the input fields

                queriesInput.text = "";
            }
        }
    }
}

