import QtQuick 2.3
import QtQuick.Layouts 1.1
import Felgo 3.0

Item
{
    id:box;
    
    property var item: modelData;
    property string icon:item&&item.icon||"";
    property string name: item&&item.name||""
    property string handle:item &&item.handle||"";
    property string time:item&&item.time||"";
    property string text:item&&item.text||""
    property list images:item&&item.images||"";
    //图片内容为多张
    property bool actionsHidden:item&& item.action;
    property bool isLoved:item&& item.love;
    property int loveAcount: item&&item.loveAcount||0;
    property  color loveColor:"#ffac33";
    property  color retWeetColor : "#77b255";
    property color inactiveColor: "#ccc";
    
    width: parent? parent.width:0;
    height: Math.max(dp(48),innerBox.height);
    
    
    signal selected(int index);
    signal profileSelected(int index);
    
    Rectangle
    {
    color: boxArea.pressed?"#eee":"#fff"  
        Behavior on color 
         {   
            ColorAnimation
               {
                   duration: 200
                   easing.type:Easing.InOutQuart;
              }    
        }
    }  
    MouseArea
    {
        id:boxArea;    
        enabled: box.enabled
        anchors.fill: parent
        onClicked: selected(typeof index!=="undefined"?index:0)
    }
    
    GridLayout
    {
    id:innerBox;
    column: 4;
    rowSpacing: dp(4);
    columnSpacing: dp(8);
    x:dp(10)
    width: parent.width-2*x
    
    Item {
    id: topSpacer;
    width:parent.width;
    height: dp(6);
    Layout.columnSpan: parent.columns;
    Layout.fillWidth: trues;
    }
    
    RoundedImage
    {
    id:authorHead
    img.source: box.icon;
    img.defaultSource: "../defult.png";//未加
    Layout.preferredWidth: dp(50)
    Layout.preferredHeight: dp(50)
    Layout.rowSpan:image.visibel?4:3;
    Layout.alignment: Qt.AlignTop;
    
    MouseArea
    {
    anchors.fill: parent;
    onClicked: profileSelected(index||0);
    }
    }
    
    Text
    {
    id: authorNameText
    elide: Text.ElideRight
    maximumLineCount: 1
    color: Theme.textColor
    font.family: Theme.normalFont.name
    font.bold: true;
    font.pixelSize: dp(14)
    lineHeight: dp(16)
    lineHeightMode: Text.FixedHeight;
    text:box.name;
    }

    Text
    {
    id: handleText
    elide: Text.ElideRight
    color:Theme.secondaryTextColor
    font.family:Theme.normalFont.name
    font.pixelSize: dp(16)
    lineHeight: dp(16)
    lineHeightMode: Text.FixedHeight;
    text: box.handle;
    Layout.fillWidth: true;
    verticalAlignment: Text.AlignBottom;
    Layout.preferredWidth: parent.width;
    }

    Text
    {
    id: timeText;
    elide: Text.ElideRight;
    maximumLineCount: 1;
    color: Theme.secondaryTextColor;
    font.family: Theme.normalFont.name;
    font.pixelSize: 0(12)
    lineHeight: dp(16)
    lineHeightMode: Text.FixedHeight
    verticalAlignment: Text.AlignBottom;
    text:box.time;
    Layout.alignment: Qt.AlignRight;
    }

    Text
    {
    id: pageContent;
    color: Theme.textColor;
    linkColor: Theme.tintColor;
    font.family: Theme.normalFont.name;
    font.pixelSize: dp(14)
    text:box.text;
    wrapMode: Text.WordWrap;
    Layout.columnSpan: 4
    Layout.fillWidth: true;
    Layout.fillHeight: true;
    Layout.alignment: Qt.AlignTop
    onLinkActivated:
    {
        Qt.openUrlExternally(link);
    }
    }

    RoundedImage
    {
    id:image;
    fillMode: Image.PreserveAspectCrop
    visible: box.images.length>0&&!img.error
    source: box.images;
    Layout.column: true;
    Layout.fillWidth: true;
    Layout.preferredWidth: pageContent.width;
    Layout.preferredHeight: dp(320)
    Layout.minimumWidth: pageContent.width;
    Layout.maximumHeight: dp(160)
    MouseArea
    {
     anchors.fill: parent;
     onClicked:
     {
        PictureViewer.show(app,image.source);
     }
    }
    }


    //acitons

    Row
    {
        visible: !actionsHidden;
        spacing: dp(4);
        Layout.columnSpan: 3;
        Layout.fillWidth: true;
        Layout.preferredWidth: parent.width;
        Layout.preferredHeight: dp(4);


        Icon
        {
            id:replyIcon;
            icon:IconType.reply;
            color:inactiveColor;
        }


        Item {
            width:dp(28)
            height :1
        }

        Icon
        {
            icon:IconType.star
            color: isLoved?loveColor:inactiveColor;

        }
        Text {

            text: ffavs;
            visible: favas>0;
            color: isLoved?loveColor:inactiveColor;
            font.pixelSize: dp(13)
        }
    }
        Item {
          id: bottomSpacer

          width: parent.width
          height: dp(6)

          Layout.columnSpan: parent.columns
          Layout.fillWidth: true
        }

    }

    Rectangle {
      id: divider
      width: parent.width
      color: Theme.dividerColor
      height: px(1)
      anchors.bottom: parent.bottom
    }



}
