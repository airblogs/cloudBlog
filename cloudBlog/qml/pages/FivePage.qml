import QtQuick 2.3
import Felgo 3.0
import QtGraphicalEffects 1.0

import "../model"
import "../widgets"

ListPage {
  id: profilePage

  title: qsTr("Profile")

  property var profile




  listView {

    anchors.leftMargin: nativeUtils.safeAreaInsets.left
    anchors.rightMargin: nativeUtils.safeAreaInsets.right
    anchors.bottomMargin: nativeUtils.safeAreaInsets.bottom

    header: Column {
      id: contentColumn

      width: parent.width





      // Profile details
      Rectangle {
        width: parent.width
        height: profileContent.height + dp(10) + profileContent.y
        color: "white"

        Column {
          id: profileContent

          width: parent.width - dp(20)
          x: dp(10)
          y: profileImage.height * 0.75 + dp(10)
          spacing: dp(8)

          Column {
            spacing: dp(4)
            Row{

                RoundedImage {
                  id: profileImage
                  source: "https://img.ivsky.com/img/tupian/pre/201807/12/dasan_renmen-004.jpg"

                  x: dp(10)
                  y: -(height / 4) + parent.height
                  width: dp(50)
                  height: dp(50)

                  backgroundColor: "white"
                }
            AppText {
              text: profile.name
              font.pixelSize: sp(16)
              font.bold: true
                 }
            }

          }

          AppText {
            text: profile.description
            width: parent.width
            wrapMode: Text.WordWrap
            font.pixelSize: sp(12)
            lineHeight: 1.3
          }
        }
      }

      Rectangle {
        y: parent.height - height
        width: parent.width
        height: 1
        color: Theme.dividerColor
      }
       Rectangle{
        width: parent.width;
        height: dp(50);
      Row {
        id: tintColorRow
        anchors.horizontalCenter: parent.horizontalCenter
        spacing:dp(5)
        property color defaultColor: Theme.isIos ? "#007aff" : (Theme.isAndroid ? "#3f51b5" : "#01a9e2") // default is felgo blue
        property int currentIndex: 0

        Connections {
          target: Theme
          onPlatformChanged: if(tintColorRow.currentIndex === 0) Theme.colors.tintColor = tintColorRow.defaultColor
        }

        AppText {
          text: "主题:"
          anchors.verticalCenter: parent.verticalCenter
        }

        Repeater {
          model: [tintColorRow.defaultColor, "#FF3B30", "#4CD964", "#FF9500"]
          anchors.topMargin: 1;
          Rectangle {
            color: modelData

            width: dp(48)
            height: dp(48)
            MouseArea {
              anchors.fill: parent
              onClicked: { Theme.colors.tintColor =  color; tintColorRow.currentIndex = index }
            }
          }
        }
      } // tint row

      }
        Rectangle
      {
        width: parent.width;
        height: dp(50);
        Row {
          anchors.horizontalCenter: parent.horizontalCenter
          AppText {
            text: "系统设置: "
            anchors.verticalCenter: parent.verticalCenter
          }

          IconButton {
            anchors.verticalCenter: parent.verticalCenter
            icon: IconType.apple
            size: dp(24)
            color: Theme.isIos ? Theme.tintColor : Theme.secondaryTextColor
            onClicked: Theme.platform = "ios"
          }

          IconButton {
            id: androidIcon
            anchors.verticalCenter: parent.verticalCenter
            icon: IconType.android
            color: Theme.isAndroid ? Theme.tintColor : Theme.secondaryTextColor
            size: dp(24)
            visible: !system.isPlatform(1) // 1 == iOS
            onClicked: Theme.platform = "android"
          }

          AppButton {
            text: "Custom"
            anchors.top: parent.top
            anchors.topMargin: Theme.isAndroid ? dp(2) : dp(1)
            flat: true
            verticalPadding: 0
            borderColor: Theme.isIos ? Theme.secondaryTextColor : Theme.tintColor
            textColor: Theme.isIos ? borderColor : Theme.appButton.flatTextColor
            visible: !androidIcon.visible
            onClicked: Theme.platform = "android"
          }
        }

      }

    }
  }
}
