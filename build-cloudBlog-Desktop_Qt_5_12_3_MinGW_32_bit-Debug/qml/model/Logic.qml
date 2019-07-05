import QtQuick 2.0
import Felgo 3.0

Item {

  signal fetchTwitterData()

  signal addTweet(string text)
  signal saveText(var title,var content,var imageSource)
  signal comment(var id,var name,var anwser,var time,var favs,var comment,var text);

}
