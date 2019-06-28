import Felgo 3.0
import QtQuick 2.5
import QtQuick.Controls 1.2
import "."
ListPage
{
    id:page;
    title: qsTr("world");


    titleItem: Icon
    {
        icon:IconType.twitter;
        color:"white";
        size:dp(24)

    }
    listView.emptyText.text: qsTr("No lists")

    onItemSelected: {
      console.debug("Selected list at position", index)

      navigationStack.push(mainPageComponent, { title: "are you ok?", rightBarItem: null })
    }
    property int numItems: 10
    model: [
      { "text": "Felgo Developers", "detailText": "49.213 members" },
      { "text": "App Developers", "detailText": "10.968 members" },
      { "text": "Random things", "detailText": "4.323 members" }
    ]


}
