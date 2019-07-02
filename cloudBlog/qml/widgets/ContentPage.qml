import QtQuick 2.4
import QtQuick.Layouts 1.1
import Felgo 3.0
import "../model"
ListPage{
  id: detailPage
  title: qsTr("Tweet")
  backgroundColor: "white"
  property var tweet



  property string icon: tweet && tweet.icon || ""
  property string name: tweet && tweet.name || ""
  property string handle:tweet && tweet.handle || ""
  property string time: tweet && tweet.time || ""
  property string text: tweet && tweet.text || ""
  property string image:tweet && tweet.image || ""

  property bool actionsHidden: tweet && tweet.actionsHidden || false

  property int favs: tweet && tweet.favorite_count || 0
  property int retweets: tweet && tweet.retweet_count || 0

  property bool isFaved: tweet && tweet.favorited || false
  property bool isRetweeted: tweet && tweet.retweeted || false
  // Temp, should be in theme!
  property color favColor: "#FF6633"
  property color retweetColor: "#77b255"
  property color inactiveColor: "#CC99CC"


  GridLayout {
    id: innerGrid

    // Auto-break after 2 columns, so we do not have to set row & column manually




    columns: 2
    rowSpacing: dp(8)
    columnSpacing: dp(8)

    x: dp(10)
    y: dp(10)
    width: parent.width - 2 * x

    RoundedImage {
      id: avatarImage

      source: tweet.icon

      Layout.preferredWidth: dp(50)
      Layout.preferredHeight: dp(50)
      Layout.rowSpan: 2
      Layout.alignment: Qt.AlignTop

      MouseArea {
        anchors.fill: parent
        onClicked: {
          navigationStack.push(profilePageComponent, { profile: tweet.user })
        }
      }
    }

    Column {
      Layout.fillWidth: true
      Layout.alignment: Qt.AlignTop | Qt.AlignLeft
      Layout.preferredWidth: parent.width

      spacing: dp(4)

      Text {
        id: nameText
        elide: Text.ElideRight
        maximumLineCount: 1
        color: Theme.textColor
        font.family: Theme.normalFont.name
        font.bold: true
        font.pixelSize: dp(14)
        lineHeight: dp(16)
        lineHeightMode: Text.FixedHeight
        text: tweet.name
      }
      Text {
        id: handleText
        elide: Text.ElideRight
        maximumLineCount: 1
        color: Theme.secondaryTextColor
        font.family: Theme.normalFont.name
        font.pointSize: 7
        font.pixelSize: dp(12)
        lineHeight: dp(16)
        lineHeightMode: Text.FixedHeight
        text: tweet.handle
      }
    }


     Text {
      id: contentText
      color: Theme.textColor
      linkColor: Theme.tintColor
      font.family: Theme.normalFont.name
      style: Text.Outline
      font.pixelSize: dp(18)
      lineHeight: 1.15
      text: tweet.text
      wrapMode: Text.WordWrap
      Layout.columnSpan: 2
      Layout.fillWidth: true

      Layout.alignment: Qt.AlignTop
    }

    RoundedImage {
        id: contentImage

      fillMode: Image.PreserveAspectCrop
      visible: tweet.image && tweet.image.length > 0

      source: tweet.image || ""

      Layout.columnSpan: 2
      Layout.fillWidth: true
      Layout.preferredWidth: contentText.width
      Layout.preferredHeight: dp(240)
      Layout.maximumWidth: contentText.width
      Layout.maximumHeight: dp(240)

      MouseArea {
        anchors.fill: parent

        onClicked: {
          PictureViewer.show(detailPage, contentImage.source)
        }
      }
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
      text: tweet.time || ""

      Layout.columnSpan: 2
      Layout.fillWidth: true
    }

    // Divider
    Rectangle {
      width: parent.width
      color: Theme.dividerColor
      height: 1 // Use absolute value for now

      Layout.columnSpan: 2
      Layout.fillWidth: true
    }

    Row {
      visible: !actionsHidden

      spacing: dp(4)

      Layout.columnSpan: 2
      Layout.fillWidth: true
      Layout.preferredWidth: parent.width
      Layout.preferredHeight: replyIcon.height + dp(4)
      Layout.alignment: Qt.AlignBottom


      Icon {
        icon: IconType.retweet
        color: isRetweeted ? retweetColor : inactiveColor
      }

      Text {
        text: retweets
        visible: retweets > 0
        color: isRetweeted ? retweetColor : inactiveColor
        font.pixelSize: sp(13)
      }

      Item {
        width: dp(28)
        height: 1
      }
      Icon {
        id: replyIcon
        icon: IconType.comment
        color: inactiveColor

        MouseArea
        {
              anchors.fill: parent;
            onClicked:
            {
                navigationStack.push(commentPageComponent,{comment:tweet});
            }

        }


      }

      Text {
        text:retweets
        visible:true;
        color: inactiveColor
        font.pixelSize: sp(13)
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
            onClicked:
            {
                if(isFaved==1)
                {
                    favs-=1;

                }
                else
                {
                    favs+=1;
                }
                isFaved=!isFaved;

            }

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


    // Divider
    Rectangle {
      width: parent.width
      color: Theme.dividerColor
      height: 1 // Use absolute value for now

      Layout.columnSpan: 2
      Layout.fillWidth: true
    }
  }

}
