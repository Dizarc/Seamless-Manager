import QtQuick 6.6
pragma Singleton

QtObject{

  readonly property int lightTheme: 0
  readonly property int darkTheme: 1

  property int theme: lightTheme

  readonly property color lightThemeColor: "#E5E5E5"
  readonly property color darkThemeColor: "#464B52"

  readonly property color backgroundColor: theme === lightTheme ? "#E1E2E3" : "#252930"
  readonly property color textColor: theme === lightTheme ? "#292929" : "#ECEDF0"
  readonly property color borderColor: theme === lightTheme ? "#292929" : "#ECEDF0"
  readonly property color inputBoxColor: theme === lightTheme ? "#C6C8C9" : "#494F56"

  readonly property color generalButtonColor: theme === lightTheme ? "#C0C2C3" : "#3A3E44"

  readonly property color acceptButtonColor: "#399F2E"
  readonly property color denyButtonColor: "#C3352B"
}
