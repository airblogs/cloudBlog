import Felgo 3.0
import QtQuick 2.0
import QtQuick.Controls 1.2
Page {
    id: page

    title: "New Page"
    property  var it;
    property  string textTitle: it && it.title || ""
    property string textCotent: it && it.text || ""
    // remove focus from textedit if background is clicked
    signal saveText(var title,var content);
    rightBarItem: IconButtonBarItem {
      id:id;
      visible: title.text!=="" ;
      icon: IconType.check
      onClicked:
      {
       console.log(title.text,content.text);
        saveText(title.text,content.text);
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
                     color: "red";
                      Column {
                       anchors.right: parent.right
                       anchors.left: parent.left
                       anchors.top: parent.top
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

            fillMode: Image.PreserveAspectCrop
            visible:true;
            width: parent.width;

            anchors.fill: parent;
            source: "../../../cloudBlog/images/head.jpg"

            MouseArea {
              anchors.fill: parent
              onClicked: {
                  if(contentImage.source=="")
                  {

                  }
                  else
                  {
                  PictureViewer.show(app, contentImage.source)
                  }
              }
            }
             }

        }
}


