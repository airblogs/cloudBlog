import QtQuick 2.0
import Felgo 3.0

Item {
  id: dataModel

  // property to configure target dispatcher / logic
  property alias dispatcher: logicConnection.target
  readonly property alias currentProfile: _.currentProfile
  readonly property alias timeline: _.timeline
  readonly property alias messages: _.messages
  readonly property alias firstTweetData: _.firstTweetData
  readonly property alias comment:_.comments
  Connections {
    id: logicConnection

    onFetchTwitterData:  {
      console.debug("Loading datamodel...")

      // Profile
      HttpRequest.get(Qt.resolvedUrl("../user.json"))
      .then(function(res) {
        _.currentProfile = JSON.parse(res.body)
      })

      // Feed
      HttpRequest.get(Qt.resolvedUrl("../feed.json"))
      .then(function(res){
        var json = JSON.parse(res.body)
        var model = []

        _.firstTweetData = json[0]
        for (var i = 0; i < json.length; i++) {
          model.push(_.tweetModel(json[i]))
        }
        _.timeline = model
      })

      // Messages
      HttpRequest.get(Qt.resolvedUrl("../messages.json"))
      .then(function(res) {
        var raw = JSON.parse(res.body)
        var model = []
        for (var i = 0; i < raw.length; i++) {

          var message = JSON.parse(JSON.stringify(raw[i]))
            model.push(message)
        }
        _.comments= model
      })
    }
    onComment:
    {
      var newComment={"id":"","name":"","anwser":"rh","time":"","favs":0,"comment":0,"text":""};
        newComment.id=id;
        newComment.name=name;
        newComment.text=text;
        newComment.time=time;
        newComment.favs=favs;
        newComment.text=text;
        _.comments.push(newComment);
        _.commentsChanged();
    }
    // action 2 - addTweet
    onSaveText: {
      //create fake tweet as copy of first tweet with new text
      var newTweet = JSON.parse(JSON.stringify(_.firstTweetData))
      console.log("收到添加内容"+title);
      newTweet.user = _.currentProfile
      newTweet.text = content;
      newTweet.name=title;


      newTweet.entities.media[0].type="photo";
      newTweet.entities.media[0].media_url=imageSource;

      newTweet.image=imageSource;
      _.timeline.push( _.tweetModel(newTweet)) //insert at position 0
      _.timelineChanged()

    }
  }

  // private
  Item {
    id: _

    property var currentProfile
    property var timeline
    property var messages
    property var comments
    property var firstTweetData


    function tweetModel(data) {
    //  console.log("TWEET MODEL: "+JSON.stringify(data))
      // Twitter uses custom format not recognized by new Date(string)
      var date = new Date(data.created_at.replace("+0000 ", "") + " UTC")

      // Check for URLs
      var text = data.text

      var image=null;
      // Check for image media

      if (!!data.entities && !!data.entities.media) {
        for (var j = 0; j < data.entities.media.length; j++) {
          var med = data.entities.media[j]
          if (med.type === "photo") {
            // Save image reference
            image = med.media_url


            // We just use the first found photo for now
            break
          }
        }
      }

      return {
        "id": data.id,
        "name": data.user.name,
        "handle": "@" + data.user.screen_name,
        "icon": data.user.profile_image_url.replace("_normal", "_bigger"),
        "text": text,
        "image": image,
        "time": DateFormatter.prettyDateTime(date),
        "retweet_count": data.retweet_count,
        "favorite_count": data.favorite_count,
        "retweeted": data.retweeted,
        "favorited": data.favorited,
        "user": data.user,
        "actionsHidden": undefined // workaround because dynamic add/remove of properties has troubles on iOS with Qt. 5.6.0
      }
    }
  }
}
