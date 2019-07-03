import Felgo 3.0
import QtQuick 2.5
import QtQuick.Controls 1.2
import "."
import "../widgets"
Page
{


    //Component { id: mainPageComponent; MainPage { } }
      Component { id: firstPageComponent; FirstPage { } }
         Component { id: commentPageComponent; CommentPage { } }
    Component { id: detailPageComponent; ContentPage { } }
    Component { id: profilePageComponent; SecondPage { } }
    Component { id: secondPageComponent; ThreePage { } }
    Component { id:fivePageComponent;FivePage { } }
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
      id:firstPage
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
          Component.onCompleted: {
            push(fivePageComponent, { profile: dataModel.currentProfile })
          }
      }
    }
  }
}
