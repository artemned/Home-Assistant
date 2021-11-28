import QtQuick.Layouts 1.3
import io.qt.Backend 1.0
import QtQuick.Extras 1.4
import QtQuick 2.15
import QtQuick.Controls.Material 2.15
import QtQuick.Controls 2.15
import QtQuick.Dialogs 1.2
import QtQuick.Controls.Styles 1.4
import "qrc:/elements"
import "qrc:/dialog"



Page{
    property int addressRegistersBackend:0
    property int amountRegistersBackend:0
    property var data
    property bool stopTimer
    id:readPage   
    title:"View elements"
    width: 695
    Layout.minimumWidth: 500
    height: 445
    Layout.minimumHeight: 400
    onWidthChanged: {
                  if(width>height)
                  {
                      grid.flow=Flow.LeftToRight

                  }
                   if(height>width)
                  {
                    grid.flow=Flow.TopToBottom

                  }
    }
    onHeightChanged: {
                  if(height>width)
                  {
                      grid.flow=Flow.TopToBottom

                  }
                   if(height<width)
                  {
                    grid.flow=Flow.LeftToRight

                  }
    }
    background: Rectangle{
        anchors.fill: parent
        color: "#322d3a"
    }
    header:ToolBar{
        id:toolbar
      Material.theme: Material.Dark
      Material.primary:Material.color(Material.Brown,Material.Shade700)
        height: 30
        font.pixelSize: 19
        contentHeight: 4
        contentWidth: 3
        ToolButton{
         id:toolbuttonactive
         x: 465
         y: 0
         width: 115
         height: parent.height
         anchors.verticalCenterOffset: 0
         anchors.verticalCenter: parent.verticalCenter
         font.letterSpacing: 1.5
         anchors.right:toolButton.left

         Material.foreground: Material.Lime
         display:AbstractButton.TextBesideIcon
         icon.source:"qrc:/Icons/Icons/round_power_settings_new_black_48dp.png"
         text:"activate"
         font.pixelSize: 15
         font.weight: Font.Medium
         focusPolicy: Qt.ClickFocus
         anchors.rightMargin: 0
         font.hintingPreference: Font.PreferDefaultHinting
         font.kerning: true
         font.wordSpacing: 0
         font.family: "Verdana"
         onClicked: {
                         switch(timer.running)
                       {
                            case true: timer.running=false;
                            Material.foreground=Material.Lime
                                break;
                            case false:timer.running=true
                                Material.foreground=Material.DeepOrange
                                break
                            default:break;
                       }


                     // if(timer.running)timer.running=false
                     // else timer.running=true;

         }


}
        ToolButton{
            id: toolButton
            x: 591
            width: 115
            height: parent.height
            anchors.verticalCenterOffset: 0
            anchors.verticalCenter: parent.verticalCenter
            anchors.right:parent.right
            font.letterSpacing: 1.5
            Material.foreground :down? Material.LightBlue
                                     : "white"
            display:AbstractButton.TextBesideIcon
            icon.source:"qrc:/Icons/Icons/2x/baseline_settings_black_24dp.png"
            text:"setting"
            font.pixelSize: 15
            font.weight: Font.Medium
            focusPolicy: Qt.ClickFocus
            anchors.rightMargin: 0
            font.hintingPreference: Font.PreferDefaultHinting
            font.kerning: true
            font.wordSpacing: 0
            font.family: "Verdana"
            onClicked: menu.open()
Menu {
     id:menu

        //Action { text: qsTr("Temperature")}
        Action { text: qsTr("Register set");onTriggered: registersetup.open()}
        Action { text: qsTr("Value set");onTriggered: valuesetup.open()}
        topPadding: 2
        bottomPadding: 2
        width:  170
        height:menuItem.height
        delegate: MenuItem {
            id: menuItem
            implicitWidth: 170
            implicitHeight: 40
            font.family: "Verdana"
            font.pixelSize: 15
            contentItem: Text {
                leftPadding: menuItem.indicator.width
                rightPadding: menuItem.arrow.width
                text: menuItem.text
                font: menuItem.font
                opacity: enabled ? 1.0 : 0.3

                color: menuItem.highlighted ? "white"
                                            :Material.color(Material.Blue,Material.Shade700)
                horizontalAlignment: Text.AlignLeft
                verticalAlignment: Text.AlignVCenter
                elide: Text.ElideRight

            }

            background: Rectangle {
                implicitWidth: 140
                implicitHeight: 40
                opacity: enabled ? 1 : 0.3
                color: menuItem.highlighted ? Material.color(Material.LightBlue,Material.Shade500)
                                            :"transparent"

            }
        }


  }

}//toolbutt/

}//ToolBar

WorkerScript
{
    id:myWorker
    source: "script.mjs"
    onMessage:{
                var all=messageObject.resultat

            if (all===0)               {

                       knob.value=0
                       water.value=2
                       knobtwo.value=0
                       knob.update(knob.value)
                       water.update(water.value)
                       knobtwo.update(knobtwo.value)
                }

                   else {

                         knob.value=readPage.data[knob.knobIndexRegistr]
                         water.value=readPage.data[water.waterIndexRegistr]
                         knobtwo.value=readPage.data[knobtwo.knobTwoIndexRegistr]
                         knob.update(knob.value)
                         water.update(water.value)
                         knobtwo.update(knobtwo.value)
                        }

              }

}


    Timer {//return array for all values
        id:timer
        property bool flagRevers: false
        property int value:0
           interval: 7000;
           //running: true;
           repeat: true
           onTriggered:
       {

             if(backend.currentStatus)
           {


                 if(amountRegistersBackend >=13)
                 {
                     timer.interval=false;
                 }

                myWorker.sendMessage({object:backend.readReg(addressRegistersBackend,
                                                        amountRegistersBackend)});



           }

       }

 }//timer




    Frame{
        id:frame
        anchors.fill: parent
        anchors.margins: 1
        background: Rectangle {
               color: "transparent"
               border.color: Material.color(Material.Purple,Material.Shade300)
               radius: 4
               border.width: 2

        }

        Flow
        {
            id: grid
            anchors.centerIn: parent
            spacing: 10
            Frame{
                id:borderKnob
                height: 175
                enabled: false
                implicitWidth:  190
                implicitHeight: 185

          background: Rectangle {
                 color:  "#322d3a"
                 border.color:"#322d3a"

          }

          Knob {
              id: knob
              property int address:1
              property int knobIndexRegistr:0
              x: 0
              y: -12
              width: 166
              height: 155
              fromAngle: 2
              lineWidth: 13
              fontSize: 14              
              from:0
              to: 40
              value: 1.2
              reverse: false
              title: "House temperature"
              titleFontSize: 15
              titleFont:"Verdana"
              titleFontColor: Material.color(Material.Red,Material.Shade400)
              knobColor: Material.color(Material.Red,Material.Shade400)
              digitColor: Material.color(Material.Red,Material.Shade400)
          }

       }//knob



            Frame{
                id:borderWater
                height: 175
                enabled: false
                // anchors.horizontalCenter: parent.horizontalCenter
                implicitWidth:  190
                implicitHeight: 185
                background: Rectangle {
                       color: "#322d3a"
                       border.color: "#322d3a"

                   }


      WaterLevel
      {

          id:water

          property int waterIndexRegistr: 0
      //    x: 0
    //      y: -12
          width: 156
          height: 130
          anchors.verticalCenter: parent.verticalCenter
          titleFontSize: 15
          fontSize: 14
          lineWidth: 3
          anchors.verticalCenterOffset: 11
          anchors.horizontalCenterOffset:14
          anchors.horizontalCenter: parent.horizontalCenter
          from:0
          to: 75
          value: 1.0
          color:Material.color(Material.Cyan,Material.ShadeA100)
          textColor:Material.color(Material.Cyan,Material.ShadeA700)
          titleFontColor: Material.color(Material.Cyan,Material.ShadeA100)

      }


            }

            Frame{
                id:borderKnobtwo
                height: 175
                implicitWidth:  190
                implicitHeight: 185         
          background: Rectangle {
                 color:"#322d3a"
                 border.color:"#322d3a"

          }

          Knob {
              id: knobtwo
              property int knobTwoIndexRegistr:0
              x: 0
              y: -12
              width: 166
              height: 155
              lineWidth: 13
              fontSize: 14
              from:0
              value: 1.2
              fromAngle: 2.14             
              to:45
              reverse: false
              title: "Street temperature"
              titleFontSize: 15
              titleFont: "Verdana"
              titleFontColor: Material.color(Material.Orange,Material.Shade400)
              knobColor: Material.color(Material.Orange,Material.Shade400)
              digitColor: Material.color(Material.Orange,Material.Shade400)
              onValueChanged: {

                   if(value>0)
                   {
                       from=0
                       to=45
                       reverse=false
                     titleFontColor=Material.color(Material.Orange,Material.Shade400)
                     knobColor=Material.color(Material.Orange,Material.Shade400)
                     digitColor=Material.color(Material.Orange,Material.Shade400)
                   }
                   else if(value < 0)
                           {
                             from=0
                             to=-35
                             reverse=true
                             titleFontColor=Material.color(Material.Blue,Material.ShadeA400)
                             knobColor=Material.color(Material.Blue,Material.ShadeA700)
                             digitColor=Material.color(Material.Blue,Material.ShadeA400)
                           }


                  }


              }


RegisterSetup{
               id:registersetup

   onAccepted: {
                  addressRegistersBackend=registersetup.addressValueFrom
                  amountRegistersBackend =registersetup.addressValueTo

               }

}

ValueSetup{
            id:valuesetup

            onAccepted: {
                               switch(valuesetup.sensorSelect)
                               {
                                 case 0: knob.knobIndexRegistr=valuesetup.addressValue;
                                  //   console.log("temp",knob.knobIndexRegistr)
                                     break;
                                 case 1: water.waterIndexRegistr = valuesetup.addressValue;
                                    // console.log("water",water.waterIndexRegistr)
                                     break;
                                 case 2: knobtwo.knobTwoIndexRegistr = valuesetup.addressValue;
                                      //console.log("te",knobtwo.knobTwoIndexRegistr)
                                     break;
                                 default:break;

                               }

            }



}






}//page


}}




}
