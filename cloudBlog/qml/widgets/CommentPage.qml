import Felgo 3.0
import QtQuick 2.0
import QtQuick.Controls 1.2
/*

// EXAMPLE USAGE:
// add the following piece of code inside your App { } to display the List Page

CommentPage {

}

*/

ListPage {
    id:commentPage;
    property  var  comment;
    backgroundColor: "white";
    property int numItems: 10
    rightBarItem: IconButtonBarItem {
      icon: IconType.plus
      onClicked: InputDialog.inputTextMultiLine(app,
                                                    qsTr("添加评论"),
                                                    qsTr("内容..."),
                                                    function(ok, text) {
                                                        if(text!=="")
                                                        listModel.append({icon:comment.icon,name:comment.name,time:Qt.formatDateTime(new Date(), "dddd\nyyyy-MM-dd"),text:text})
                                                    }
                                                    )
    }
    model: JsonListModel {
      id: listModel
      source: dataModel.timeline && dataModel.timeline.slice(0, numItems)
      keyField: "id"

    }

    delegate: CommentItem {
      id: row
      item: listModel.get(index)

    }

    //load older tweets with visibility handler
    listView.footer: VisibilityRefreshHandler {
      canRefresh: dataModel.timeline ? numItems < dataModel.timeline.length : false
      onRefresh: loadOldTimer.start()
    }


    //load new tweets with pull handler
    pullToRefreshHandler {
      pullToRefreshEnabled: true
      onRefresh: loadNewTimer.start()
      refreshing: loadNewTimer.running
    }

    Timer {
      // Fake loading of new tweets in background
      id: loadNewTimer
      interval: 1000
      onTriggered: {
              navigationStack.clearAndPush(firstPageComponent,{});
      }
    }

    Timer {
      // Fake loading of older tweets in background
      id: loadOldTimer
      interval: 2000
      onTriggered: {
        var pos = listView.getScrollPosition()
        numItems += 10
        listView.restoreScrollPosition(pos)
      }
    }


}

