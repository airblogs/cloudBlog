import Felgo 3.0
import QtQuick 2.5
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
         Page
         {
         }
      }
    }


    NavigationItem {
      title: qsTr("Me")
      icon: IconType.list

      NavigationStack {
       Page {
                AppDrawer {
                  //all items inside AppDrawer will be placed in the drawer area

                  id: drawer

                  z: 1 //put drawer on top of other content

                  Rectangle { //background for drawer
                    anchors.fill: parent
                    color: "white"
                  }

                  AppButton {
                    anchors.centerIn: parent
                    text: "Test"
                    onClicked: {
                      testTxt.text = "Button in drawer Clicked"
                      drawer.close()
                    }
                  }
                } //end of AppDrawer

                AppText {
                  id: testTxt
                  anchors.centerIn: parent
                  font.pixelSize: sp(18)
                  text: "Swipe from left to open drawer"
                }

                AppButton {
                  text: "Open drawer manually"
                  anchors.top: testTxt.bottom
                  anchors.horizontalCenter: parent.horizontalCenter
                  onClicked: drawer.open()

              }
       }
      }
    }
    NavigationItem {
      title: qsTr("up")
      icon: IconType.heartbeat

      NavigationStack {
        Page {
          title: "Navigation Switch"
        }
      }
    }
    NavigationItem {
      title: "Collection"
      icon: IconType.bookmark

      NavigationStack {
        Page { title: "Dialogs Page" }
      }
    }

    NavigationItem {
      title: "Settings"
      icon: IconType.cogs

      NavigationStack {
        Page { title: "Settings Page" }
      }
    }
  }
