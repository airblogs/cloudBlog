import Felgo 3.0
import QtQuick 2.0
import QtQuick.Controls 1.2
import QtQuick.Dialogs 1.2
import "../widgets"
Page {
    id: page

    title: "New Page"
    property  var it;
    property  string textTitle: it && it.title || ""
    property string textCotent: it && it.text || ""
    // remove focus from textedit if background is clicked

    rightBarItem: IconButtonBarItem {
      id:id;
      visible: title.text!=="" ;
      icon: IconType.check
      onClicked:
      {
       console.log(title.text,content.text);
        logic.saveText(title.text,content.text,images.source);
        messageBox.visible=true;
        timerId.start();
        title.text="";
        content.text="";
        images.source="";
      }
    }


         // Bottom cell divider


        AppTextInput {
          id: title
          width: parent.width
          height: dp(50);
          placeholderText: qsTr("点击输入文章标题")
          anchors.top: parent.top
        }
         Rectangle {
           id: divider
           width: parent.width
           color: Theme.dividerColor
           height: px(1)
           anchors.bottom: title.bottom
         }
            Rectangle
            {
                id:editBox;
                radius: 10
                anchors.top: divider.bottom
                anchors.right: parent.right
                anchors.bottom: contentImage.top
                anchors.left: parent.left
                anchors.topMargin: -15

                Rectangle {
                   anchors.fill: content
                   color: "lightgrey"
                 }
                 TextArea{
                   id:content;
                   width: parent.width;
                   anchors.top:parent.top;
                   anchors.bottom: divider2.top
                    opacity: 0.5
                 }
                 Rectangle {
                   id: divider2
                   width: parent.width
                   color: Theme.dividerColor
                   height: px(1)
                    anchors.bottom: action.top;
                 }
                 Rectangle
                 {
                     id: action
                     height: dp(50)
                     width: parent.width;
                     anchors.bottom: parent.bottom
                     AppButton {
                             anchors.centerIn: parent
                             text: "Display CameraPicker"
                             onClicked: {
                               nativeUtils.displayImagePicker("test")
                             }
                           }

                           Connections {
                             target: nativeUtils
                             onImagePickerFinished: {
                               if(accepted)images.source = path
                             }
                           }
                 }
        }

        Rectangle
        {
            id: contentImage
            color: "red"
            height: dp(50)

            anchors.right: parent.right
            anchors.bottom: parent.bottom
            anchors.left: parent.left

            RoundedImage {
            id:images
            fillMode: Image.PreserveAspectCrop
            visible:true;
            width: parent.width;

            anchors.fill: parent;
            source: ""

            MouseArea {
              anchors.fill: parent
              onClicked: {
                  if(images.source=="")
                  {

                  }
                  else
                  {
                  PictureViewer.show(page, images.source)
                  }
              }
            }
             }

        }

        Timer{
               id:timerId
               interval: 1500
               onTriggered: {
                   console.log("timer out")
                   messageBox.visible = false;
               }
           }
        MessgBox{
                id:messageBox
                 anchors.centerIn: parent.Center;
                 visible: false;
                 anchors.verticalCenter: parent.verticalCenter;
                 anchors.horizontalCenter:parent.horizontalCenter;

        }

}

