import Felgo 3.0
import QtQuick 2.0


BorderImage {
    id:airMessageBox

    //显示内容
    property alias contectText: contentTextId.text

    width: 200; height: 80
    border { left: 20; top: 20; right: 30; bottom: 20 }
    horizontalTileMode: BorderImage.Repeat
    verticalTileMode: BorderImage.Repeat
    //source: "image/bg_other/balloon.png"

    Rectangle {
        id: shade;
        anchors.fill: airMessageBox;
        radius: 10;
        color: "#848491"
        opacity: 1;/*定义了透明度,0为完全透明,1为完全不透明*/
    }


    //显示内容
    Text{
        id:contentTextId
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        text:"成功"
        font.pointSize:dp(20)


    }
}
