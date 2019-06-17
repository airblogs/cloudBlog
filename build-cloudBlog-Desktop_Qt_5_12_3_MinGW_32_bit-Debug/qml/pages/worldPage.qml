import Felgo 3.0
import QtQuick 2.5
import QtQuick.Controls 1.2
import "."
Page
{

  Navigation {
          id: navigation
          navigationMode:navigationModeTabs
          navigationDrawerItem: Text {
            text: "Open"
            anchors.centerIn: parent
            color: navigation.navigationDrawerItemPressed ? "red" : "green"
          }

    NavigationItem  {
      title: qsTr("Look");
      icon: IconType.cloud

      NavigationStack {
      }
    }
   }
}
