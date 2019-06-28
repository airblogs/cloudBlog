import Felgo 3.0
import QtQuick 2.0
import QtQuick.Controls 1.2
Page {

    title: "New Page"
    property  var it;
    property  string textTitle: it && it.title || ""
    property string textCotent: it && it.text || ""
    // remove focus from textedit if background is clicked
    signal saveText(var title,var content);
    rightBarItem: IconButtonBarItem {
      id:id;
      visible: title.text!=="";
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
                width: parent.width;
                anchors.top: divider.bottom;
                anchors.bottom: parent.bottom;

                Rectangle {
                   anchors.fill: content

                   color: "lightgrey"
                 }
                 TextArea{
                   id:content;
                   width: parent.width;
                   anchors.top:parent.top;
                   anchors.bottom: divider2.bottom

                 }
                 Rectangle {
                   id: divider2
                   width: parent.width
                   color: Theme.dividerColor
                   height: px(1)
                   anchors.bottom: action.top
                 }
               Column {
                   id: action
                   width: parent.width
                   height: dp(50)
                   anchors.bottom: parent.bottom;
                 }



        }

            RoundedImage {
           id: contentImage

           fillMode: Image.PreserveAspectCrop
           visible:true;
           width: parent.width
           source: "";



           MouseArea {
             anchors.fill: parent

             onClicked: {
               PictureViewer.show(app, contentImage.source)
             }
           }
         }
    }

