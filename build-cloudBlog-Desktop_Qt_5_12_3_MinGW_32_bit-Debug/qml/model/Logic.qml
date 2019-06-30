import QtQuick 2.0
import Felgo 3.0

Item {

  signal fetchTwitterData()
  signal sendReflash();
  signal addTweet(string text)
  signal saveText(var title,var content,var imageSource)
}
