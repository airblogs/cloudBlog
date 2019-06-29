import Felgo 3.0
import QtQuick 2.5
import QtQuick.Controls 1.2
import "."
Page
{


    //Component { id: mainPageComponent; MainPage { } }
    Component { id: detailPageComponent; FirstPage { } }
    Component { id: profilePageComponent; SecondPage { } }
    Component { id: listsPageComponent; ThreePage { } }
    //Component { id: profilePageComponent; FourPage { } }
    //Component { id: listsPageComponent; FivePage { } }
  Navigation {
          id: navigation
          navigationMode:navigationModeTabs
          navigationDrawerItem: Text {
            text: "Open"
            anchors.centerIn: parent
            color: navigation.navigationDrawerItemPressed ? "red" : "green"
          }

    NavigationItem  {
      title: qsTr("广场");
      icon: IconType.cloud

      NavigationStack {
        FirstPage{}
      }
    }


    NavigationItem {
      title: qsTr("文件夹")
      icon: IconType.list

      NavigationStack {
         SecondPage{}
        }
    }
    NavigationItem {
      title: qsTr("上传")
      icon: IconType.heartbeat
      NavigationStack {
           ThreePage{}
      }
    }

    NavigationItem {
      title: "回顾"
      icon: IconType.bookmark
        FourPage{}

    }

    NavigationItem {
      title: "设置"
      icon: IconType.cogs

      NavigationStack {
       FivePage{}
      }
    }
  }
}
