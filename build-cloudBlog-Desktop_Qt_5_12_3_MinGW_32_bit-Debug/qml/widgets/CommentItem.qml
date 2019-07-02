import QtQuick 2.3
import QtQuick.Layouts 1.1

import Felgo 3.0

Item {
  id: cell

  property var item: modelData

  property string icon: item && item.icon || ""
  property string name: item && item.name || ""
  property string time: item && item.time || ""
  property string text: item && item.text || ""
  property string handle:item && item.handle || ""
  property int favs: item && item.favorite_count || 0
  property int retweets: item && item.retweet_count || 0

  property bool isFaved: item && item.favorited || false
  property bool isRetweeted: item && item.retweeted || false
  // Temp, should be in theme!
  property color favColor: "#FF6633"
  property color retweetColor: "#77b255"
  property color inactiveColor: "#CC99CC"


  width: parent ? parent.width : 0
  // minimum of 48dp for interactable items recommended
  height: Math.max(dp(48), innerGrid.height)

  Rectangle {
    color: cellArea.pressed ? "#646464" : "#fff"
    anchors.fill: parent

    Behavior on color {
      ColorAnimation { duration: 150; easing.type: Easing.InOutQuad }
    }
  }

  MouseArea {
    id: cellArea
    enabled: cell.enabled
    anchors.fill: parent
  }

  // Main cell content inside this item
  GridLayout {
    id: innerGrid

    // Auto-break after 4 columns, so we do not have to set row & column manually
    columns:3
    rowSpacing: dp(4)
    columnSpacing: dp(8)

    x: dp(10)
    width: parent.width - 2 * x

    // Top spacer
    Item {
      id: topSpacer
      width: parent.width
      height: dp(6)

      Layout.columnSpan: parent.columns
      Layout.fillWidth: true
    }

    RoundedImage {
      id: avatarImage

      img.source: cell.icon
      img.defaultSource: "../../assets/felgo-logo.png"
       radius: dp(10)
      Layout.preferredWidth: dp(50)
      Layout.preferredHeight: dp(50)
      Layout.rowSpan: 4
      Layout.alignment: Qt.AlignTop

    }

    Text {
      id: nameText
      elide: Text.ElideRight
      maximumLineCount:1
      color: Theme.textColor
      font.family: Theme.normalFont.name
      font.bold: true
      font.pixelSize: dp(14)
      lineHeight: dp(16)
      lineHeightMode: Text.FixedHeight
      text: cell.name
    }
    Text {
      id: handleText
      elide: Text.ElideRight
      maximumLineCount: 1
      color: Theme.secondaryTextColor
      font.family: Theme.normalFont.name
      font.pixelSize: dp(12)
      lineHeight: dp(16)
      lineHeightMode: Text.FixedHeight
      text: cell.handle
      Layout.fillWidth: true
      verticalAlignment: Text.AlignBottom
      Layout.preferredWidth: parent.width
    }
    Text {
      id: timeText
      elide: Text.ElideRight
      maximumLineCount: 1
      color: Theme.secondaryTextColor
      font.family: Theme.normalFont.name
      font.pixelSize: dp(12)
      lineHeight: dp(16)
      lineHeightMode: Text.FixedHeight
      verticalAlignment: Text.AlignBottom
      text: cell.time
      Layout.alignment: Qt.AlignRight
    }
    Text {
      id: contentText
      color: Theme.textColor
      linkColor: Theme.tintColor
      font.family: Theme.normalFont.name
      font.pixelSize: dp(14)
      lineHeight: 1.15
      text: cell.text
      wrapMode: Text.WordWrap
      Layout.columnSpan: 3
      Layout.fillWidth: true
      Layout.fillHeight: true
      Layout.alignment: Qt.AlignTop
    }

    Row {
      visible: true

      spacing: dp(4)

      Layout.columnSpan: 2
      Layout.fillWidth: true
      Layout.preferredWidth: parent.width
      Layout.preferredHeight: replyIcon.height + dp(4)
      Layout.alignment: Qt.AlignBottom

      Icon {
        id: replyIcon
        icon: IconType.comment
        color: inactiveColor
        MouseArea
        {
            anchors.fill: parent;
            onClicked:
            {
                InputDialog.inputTextMultiLine(app,
                                                                   qsTr("添加评论"),
                                                                   qsTr("内容@"+name),
                                                                   function(ok, text) {
                                                                       if(text!=="")
                                                                       listModel.append({icon:comment.icon,name:comment.name,time:Qt.formatDateTime(new Date(), "dddd\nyyyy-MM-dd"),text:text,handle:"回复"+comment.name})
                                                                   }
                                                                   )
            }
        }
      }
      Item {
        width: dp(28)
        height: 1
      }

      Icon {
        icon: IconType.star
        color: isFaved ? favColor : inactiveColor
        MouseArea
        {
            anchors.fill: parent;
            onClicked:  isFaved=!isFaved;

        }
        Behavior on color {
                ColorAnimation { duration: 150; easing.type: Easing.InOutQuad }
        }

      }

      Text {
        text: favs
        visible: favs > 0
        color: isFaved ? favColor : inactiveColor
        font.pixelSize: sp(13)

      }
    }

}

  // Bottom cell divider
  Rectangle {
    id: divider
    width: parent.width
    color: Theme.dividerColor
    height: px(1)
    anchors.bottom: parent.bottom
  }

}
