import QtQuick 6.6
import QtQuick.Controls.Basic

import "../../ClothingStore"

Rectangle {
  id: employeesDelegate

  implicitWidth: tableView.width
  implicitHeight: 30

  anchors.margins: 4

  clip: true

  required property int id
  required property string firstname
  required property string lastname
  required property string username
  required property string password
  required property string email
  required property string phone

  required property int index

  MouseArea {
    anchors.fill: parent
    cursorShape: Qt.PointingHandCursor

    onClicked : {
      userClicked(id,
                  index,
                  firstname,
                  lastname,
                  username,
                  email,
                  phone);

      selectionModel.select(tableView.index(employeesDelegate.index, 0), ItemSelectionModel.SelectCurrent);
    }

    Row {
      id: empRow
      spacing: 5

      Image {
        source: "../images/userImage.png"

        sourceSize.width: 125
        sourceSize.height: 20
      }

      Text {
        text: employeesDelegate.id

        color: Style.textColor

        font.pointSize: 12
        width: 30
      }

      Text {
        text: employeesDelegate.firstname

        color: Style.textColor

        font.pointSize: 12
        width: 150
      }

      Text{
        text: employeesDelegate.lastname

        color: Style.textColor

        font.pointSize: 12
        width: 150
      }

      Text {
        text: employeesDelegate.email

        color: Style.textColor

        font.pointSize: 12
        width: 300
      }

      Text {
        text: employeesDelegate.phone

        color: Style.textColor

        font.pointSize: 12
        width: 100
      }
    }
  }
}
