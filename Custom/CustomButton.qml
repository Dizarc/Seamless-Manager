import QtQuick 6.8
import QtQuick.Controls.Basic

Button {
  id: myButton

  implicitWidth: 125
  implicitHeight: 25

  property color buttonColor

  contentItem: Text {
    text: myButton.text
    font.pointSize: 11

    color: Style.textColor

    horizontalAlignment: Text.AlignHCenter
    verticalAlignment: Text.AlignVCenter
  }

  background: Rectangle {
    color: myButton.pressed ? Qt.lighter(
                                buttonColor,
                                1.3) : (myButton.hovered ? Qt.lighter(
                                                             buttonColor,
                                                             1.1) : buttonColor)
    border.width: 1
    border.color: Qt.darker(buttonColor, 1.5)
    radius: 3
  }

  MouseArea {
    anchors.fill: parent
    cursorShape: Qt.PointingHandCursor
    acceptedButtons: Qt.NoButton
  }
}
