import QtQuick 6.8
import QtQuick.Controls
import QtQuick.Layouts

import "../Custom"

import "../StorageTab/ClothesTypes"
import "../StorageTab/Clothes"
import "../StorageTab/ClothingItem"

import com.company.SizesModel

Column {
  id: storageItem

  anchors.fill: parent
  spacing: 5

  Row{
    spacing: 5

    CustomButton {
      text: qsTr("< Back")
      buttonColor: Style.generalButtonColor

      onClicked: {
        if (storageView.currentItem !== storageView.initialItem)
          storageView.pop()
      }
    }

    CustomButton{
      text: qsTr("Sizes")

      buttonColor: Style.generalButtonColor

      onClicked: {
        SizesModel.filterAvailable();

        var component = Qt.createComponent("Sizes.qml")
        var window = component.createObject()
        window.show()
      }
    }
  }

  StackView {
    id: storageView

    initialItem: clothesTypesComponent

    width: parent.width
    height: parent.height

    pushEnter: Transition {
      YAnimator {
        from: (storageView.mirrored ? -1 : 1) * storageView.height
        to: 0
        duration: 300
        easing.type: Easing.OutCubic
      }
    }

    popExit: Transition {
      YAnimator {
        from: 0
        to: (storageView.mirrored ? -1 : 1) * storageView.height
        duration: 300
        easing.type: Easing.OutCubic
      }
    }

    InfoDialog {
      id: storageInfoDialog
    }
  }

  Component {
    id: clothesTypesComponent
    ClothesTypes { }
  }

  Component {
    id: clothesComponent
    Clothes { }
  }

  Component {
    id: clothingComponent
    ClothingItem { }
  }
}
