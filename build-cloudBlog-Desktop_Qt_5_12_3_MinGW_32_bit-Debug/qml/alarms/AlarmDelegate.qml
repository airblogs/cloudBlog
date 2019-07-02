import QtQuick 2.11
import QtQuick.Controls 2.4
import QtQuick.Controls.Material 2.4
import QtQuick.Layouts 1.11
import QtQuick.Window 2.11
import Felgo 3.0
ItemDelegate {
    id: root
    width: parent.width
    checkable: true
    property int acount: 0;
    onClicked: ListView.view.currentIndex = index
    onPressAndHold:popupMenu.popup();

    contentItem: ColumnLayout {
        spacing: 0

        RowLayout {
            ColumnLayout {
                id: dateColumn

                readonly property date alarmDate: new Date(
                    model.year, model.month - 1, model.day, model.hour, model.minute)

                Label {
                    id: timeLabel
                    font.pixelSize: Qt.application.font.pixelSize * 2
                    text: dateColumn.alarmDate.toLocaleTimeString(window.locale, Locale.ShortFormat)
                }
                RowLayout {
                    Label {
                        id: dateLabel
                        text: dateColumn.alarmDate.toLocaleDateString(window.locale, Locale.ShortFormat)
                    }
                    Label {
                        id: alarmAbout
                        text: "⸱ " + model.label
                        visible: model.label.length > 0 && !root.checked
                    }
                }
            }
            Item {
                Layout.fillWidth: true
            }

            Rectangle
            {
                width:60;
                height: 40;

                Layout.alignment: Qt.AlignTop
                Text {
                    id: grade
                    text: qsTr("Grade:"+acount);
                    color: "red";
                    anchors.verticalCenter: parent.verticalCenter;
                    anchors.horizontalCenter: parent.horizontalCenter;
                }
            }
        }

        CheckBox {
            id: alarmRepeat
            text: qsTr("Repeat")
            checked: model.repeat
            visible: root.checked
            onToggled: model.repeat = checked
        }
        Flow {
            visible: root.checked && model.repeat
            Layout.fillWidth: true

            Repeater {
                id: dayRepeater
                model: daysToRepeat
                delegate: RoundButton {
                    text: Qt.locale().dayName(model.dayOfWeek, Locale.NarrowFormat)
                    flat: true
                    checked: model.isOK
                    checkable: !model.isOK
                    Material.background: checked ? Theme.tintColor: "transparent"
                    onToggled:
                   {


                        switch(model.dayOfWeek)
                        {
                        case 0:
                        {
                            model.isOK=true;
                              acount+=model.dayOfWeek+1;
                                 break;
                        }
                        case 1:
                        {
                           if(acount==1)
                           {
                              model.isOK=true;
                           acount+=model.dayOfWeek+1;
                           }
                           else
                           {
                           checked=0;
                           }

                             break;
                        }
                        case 2:
                        {
                           if(acount==3)
                           {
                              model.isOK=true;
                           acount+=model.dayOfWeek+1;
                           }    else
                           {
                           checked=0;
                           }

                             break;
                        }
                        case 3:
                        {
                           if(acount==6)
                           {
                              model.isOK=true;
                            acount+=model.dayOfWeek+1;
                           }    else
                           {
                           checked=0;
                           }

                         break;
                        }
                        case 4:
                        {
                           if(acount==10)
                           {
                              model.isOK=true;
                                acount+=model.dayOfWeek+1;
                                }    else
                           {
                           checked=0;
                           }
                             break;
                        }
                        case 5:
                        {
                           if(acount==16)
                           {
                              model.isOK=true;
                                acount+=model.dayOfWeek+1;
                           }
                           else
                           {
                           checked=0;
                           }
                             break;
                        }
                        case 6:
                        {
                           if(acount==23)
                           {
                              model.isOK=true;
                                acount+=model.dayOfWeek+1;
                           }    else
                           {
                           checked=0;
                           }

                            break;
                        }
                        default:
                            break;
                        }
                    }

                }
            }
        }

        TextField {
            id: alarmDescriptionTextField
            cursorVisible: true
            visible: root.checked
            text: model.label
            onTextEdited: model.label = text
        }

    }




    Menu{
            id : popupMenu
            title: "&File"
            MenuItem {
                   text: "&启动"
                    onTriggered:model.activated;
            }
            MenuItem {
                   text: "&完成"
                   onTriggered:;
            }
            MenuItem {
                   text: "&删除"
                    onTriggered:root.ListView.view.model.remove(root.ListView.view.currentIndex, 1)
            }

        }
}
