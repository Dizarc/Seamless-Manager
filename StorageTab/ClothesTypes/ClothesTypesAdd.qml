import QtQuick 6.8
import QtQuick.Dialogs
import QtCore

import "../../Custom"

import com.company.ClothesTypesModel

Window {
  id: clothesTypeAddWindow

  title: qsTr("Add a new clothing type")
  flags: Qt.Dialog
  modality: Qt.WindowModal
  color: Style.backgroundColor

  height: 500
  width: 600

  Column{
    anchors.horizontalCenter: parent.horizontalCenter
    spacing: 5

    Text{
      color: Style.textColor
      text: qsTr("Name of type:")
      font.pointSize: 12
    }

    CustomInputBox{
      id: typeNameInput
    }

    Text{
      color: Style.textColor
      text: qsTr("Pick an image:")
      font.pointSize: 12
    }

    Rectangle{
      id: imageRect

      width: 300
      height: 300

      color: Style.inputBoxColor
      border.color: Style.borderColor
      border.width: 1

      radius: 5

      Image{
        id: typeImage

        anchors.fill: parent

        source: ""
        sourceSize.width: imageRect.width - 6

        fillMode: Image.PreserveAspectFit
      }

      Text{
        id: hoverText
        anchors.centerIn: parent
        color: Style.textColor
        text: qsTr("Click to open image")
        font.pointSize: 12
        opacity: 0.0
      }

      MouseArea{
        anchors.fill: parent

        cursorShape: Qt.PointingHandCursor
        hoverEnabled: true

        onClicked: imageChoiceFileDialog.open()

        onEntered: {
          hoverText.opacity = 1.0
          imageRect.opacity = 0.7
        }

        onExited: {
          hoverText.opacity = 0.0
          imageRect.opacity = 1.0
        }
      }
    }

    CustomButton {
      text: qsTr("Save")
      buttonColor: Style.acceptButtonColor

      onClicked: {
        if(ClothesTypesModel.add(typeNameInput.text, typeImage.source))
          typeInfoDialog.dialogText = qsTr("Successfully created new type!")
        else
          typeInfoDialog.dialogText = qsTr("Error while creating new type!")

        clothesTypeAddWindow.close()
        typeInfoDialog.show()
      }
    }
  }

  FileDialog{
    id: imageChoiceFileDialog
    title: qsTr("Select an Image")

    nameFilters: ["Image files (*.png *.jpg *.jpeg *.bmp)"]
    currentFolder: StandardPaths.standardLocations(StandardPaths.DocumentsLocation)[0] + "/SeamlessManagerDocuments/"
    onAccepted: typeImage.source = selectedFile
  }
}
