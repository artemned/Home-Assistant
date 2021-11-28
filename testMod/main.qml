
import QtQuick 2.10
import QtQuick.Window 2.10
import QtQuick.Controls 2.3
import QtQuick.Layouts 1.3
import io.qt.Backend 1.0
import QtQuick.Controls 1.2
//import QtQuick.Extras 1.4
//import QtQuick.Controls.Styles 1.4
import QtQuick.Controls 2.15
import QtQuick.Extras 1.4
import QtQuick.Controls.Material 2.15
import QtQuick.Dialogs 1.2

ApplicationWindow {
    id:window
    width: 700
    minimumWidth: 500
    height: 450
    minimumHeight: 400
    visible: true
    property alias backend: backend
    title: "HMI for home"


    property real multiplierH: (window.height/350)*1000;
    property real multiplierW: (window.width/650)*1000;
    function dpH(numbers) {
           return numbers*multiplierH/1000;
    }
    function dpW(numbers) {
       return numbers*multiplierW/1000;
    }
    function dpX(numbers){
        return (dpW(numbers)+dpH(numbers))/2;
    }


    footer: Rectangle{
       width: parent.width
       height: 34
       radius: 4
       border.color: Material.color(Material.Blue,Material.Shade500)
       border.width: 1.3
       color:Material.color(Material.Blue,Material.Shade400)


       Text {
           id: informationMsg
           color: "#ffffff"
           width: parent.width-5
           text:pageSetting.addMsg("Application started...")
           font.pixelSize: 14
           horizontalAlignment: Text.AlignHCenter
           font.family: "Verdana"
           anchors.centerIn: parent

       }

    }
    header: ToolBar {
        contentHeight: toolButton.implicitHeight

        ToolButton {
            id: toolButton
//            text: stackView.depth > 1 ? "\u25C0" : "\u2630"
           // font.pixelSize: Qt.application.font.pixelSize * 1.6
            icon.source:"qrc:/Icons/Icons/menu-black-24dp/2x/baseline_menu_black_24dp.png"

            Material.foreground:down ? Material.color(Material.Blue,Material.Shade400)
                                        : "white"

            onClicked: {
                if (stackView.depth > 1) {
                    //drawer.open()
                    stackView.pop()
                } else {
                    drawer.open()
                }
            }
        }

        Label {
            id:lbl
            text: stackView.currentItem.title
            anchors.centerIn: parent
        }

    }

    Drawer {
        id: drawer
        width: window.width * 0.66
        height: window.height

        Column {
            anchors.fill: parent

            ItemDelegate {
                text: qsTr("Control elements")
                font.weight: Font.Medium
                font.family: "Verdana"
                width: parent.width
                onClicked: {
                    stackView.push(write)
                    drawer.close()
                }
            }


            ItemDelegate {
                text: qsTr("View elements")
                font.weight: Font.Medium
                font.family: "Verdana"
                width: parent.width
                onClicked: {
                    stackView.push(read)
                    drawer.close()
                }
            }
            ItemDelegate {
                text: qsTr("Exit")
                font.weight: Font.Medium
                font.family: "Verdana"
                width: parent.width
                onClicked: {
                  stackView.clear()
                    Qt.quit()
                }
            }

            MenuSeparator{

                    padding: 0
                    topPadding: 7
                    bottomPadding: 7
                    contentItem: Rectangle {
                        implicitWidth: drawer.width
                        implicitHeight: dpH(2)
                        color: Material.color(Material.Blue,Material.Shade400)
                    }

                }

            ItemDelegate {
                text: qsTr("About")
                font.weight: Font.Medium
                font.family: "Verdana"
                width: parent.width
                onClicked: {

                            about.visible=true

                           }
                    }

        }
  }

//INSERT_APP_NAME

    StackView {
        id: stackView
        initialItem: pageSetting
        anchors.fill: parent

    }


    Timer
    {
        id:informTimer
        interval: 10000;
        repeat: true
        onTriggered:
    {

      informationMsg.text=pageSetting.addMsg("");

    }

}

//////////////////////////////how it work)//////////////////////

Backend{

    id: backend
    property bool stateCoil
    property int numberCoil
    property real dataStorage


onStatusHoldingsReg:
{

 read.data=range;

}

onStatusCoil:
{

    stateCoil =status
    numberCoil=number;
    informTimer.restart()
    write.currentStateSwitchOne=definiteState(write.addrSwitchOne,write.currentStateSwitchOne)
    write.currentStateSwitchTwo=definiteState(write.addrSwitchTwo,write.currentStateSwitchTwo)
    write.currentStateSwitchThree=definiteState(write.addrSwitchThree,write.currentStateSwitchThree)
    write.currentStateSwitchFour=definiteState(write.addrSwitchFour,write.currentStateSwitchFour)
    write.currentStateToggleOne=definiteState(write.addrToggleOne,write.currentStateToggleOne)
    write.currentStateToggleTwo=definiteState(write.addrToggleTwo,write.currentStateToggleTwo)

    informationMsg.text=pageSetting.addMsg("State: " + status + " has been written in address "+ number)



}
onStatusReg:
{

informationMsg.text=pageSetting.addMsg("Value: "+valueReg+" has been written in address "
                                       + addressReg)
informTimer.restart()

}


onStatusChanged: {

     informationMsg.text=pageSetting.addMsg(newStatus)

     informTimer.restart()

       if (currentStatus !== true)
    {
        pageSetting.btn_connect.enabled = true;
    }
    if(currentStatus===true)
    {        
        pageSetting.currentError=false;
    }
}

onSomeError: {

   informationMsg.text=pageSetting.addMsg("Error! "+addReg +" "+ err);


   var currentAdd=addReg;

   if(write.addrSwitchOne===addReg)write.currentStateSwitchOne=false
   if(write.addrSwitchTwo===addReg)write.currentStateSwitchTwo=false
   if(write.addrSwitchThree===addReg)write.currentStateSwitchThree=false
   if(write.addrSwitchFour===addReg)write.currentStateSwitchFour=false
   if(write.addrToggleOne===addReg)write.currentStateToggleOne=false
   if(write.addrToggleTwo===addReg)write.currentStateToggleTwo=false

   informTimer.restart()

     if (currentStatus !== true)
    {
         currentError=true;
         read.stopTimer=false
       backend.disconnectClicked();

    }


}


function definiteState(addressValue,stateValue)
{
    var currentState=backend.stateCoil
    var currentNumber=backend.numberCoil
   if(currentNumber===addressValue && currentState!==stateValue)
   {

       stateValue=currentState
       return stateValue

   }else if(currentNumber===addressValue && currentState===stateValue)

    {
          return currentState
    }

else
   return stateValue

}

}

ColumnLayout{
    anchors.fill:parent
    anchors.margins:3

    PageSetting{

        anchors.fill: parent
        id:pageSetting
        visible: false
    }

    Write{
        anchors.fill: parent
        visible: false
       id:write

    }

    Read{
         anchors.fill: parent
         visible: false
         id:read
    }



}


////////////////////////////////////////////////////////


MessageDialog{
              id:about
              title: qsTr("About")
              visible: false
              icon:StandardIcon.Information
              modality: Qt.NonModa
              informativeText:
"This application was created for informational purposes only and does not pursue commercial interests.
It allows you to interact with devices using the Modbus TCP protocol.\n"+
"I want to express special gratitude to my family,because without their support and love all this would not have happened.Thank you!
"+"---------------------------------------------\n"+
"Developed and Released by Daineko.A\n"+"Version: 1.01.7\n"+"daineko.a32@mail.ru\n"
}

}


