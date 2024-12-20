import QtQuick 6.8
import QtQuick.Controls.Basic
import QtQuick.Layouts

import com.company.SizesModel
import com.company.ClothesSizesModel
import com.company.LogData

import "../../Custom"
import "../"

Window {
  id: addWindow

  property int cId: -1

  title: qsTr("Add a new size to clothing item")
  flags: Qt.Dialog
  color: Style.backgroundColor
  modality: Qt.WindowModal

  height: 300
  width: 200

  InfoDialog {
    id: sizeInfoDialog
  }

  ColumnLayout {
    anchors.fill: parent
    spacing: 5

    Text {
      text: qsTr("Available sizes:")
      font.pointSize: 12
      color: Style.textColor
    }

    TableView {
      id: sizeTableView

      Layout.fillWidth: true
      Layout.fillHeight: true

      clip: true
      flickableDirection: Flickable.VerticalFlick
      boundsBehavior: Flickable.StopAtBounds
      ScrollIndicator.vertical: ScrollIndicator {
        id: myScroll
        contentItem: Rectangle {
          implicitWidth: 3
          radius: 5
          color: myScroll.active ? Style.textColor : "transparent"
        }
      }

      model: SizesModel

      delegate: SizesDelegate {
        id: sizesDel

        width: sizeTableView.width

        myMouseArea.onClicked: {
          if (ClothesSizesModel.add(cId, sizesDel.sizeId)){
            LogData.log(cId, type, sizesDel.sizeName, 1);
            storageInfoDialog.dialogText = qsTr("Successfully created new size!");
          }else
            storageInfoDialog.dialogText = qsTr("Error while creating new size!")

          addWindow.close()
          storageInfoDialog.show()
        }
      }
    }
  }
}
