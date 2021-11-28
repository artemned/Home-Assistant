import QtQuick.Layouts 1.3
import io.qt.Backend 1.0
import QtQuick.Extras 1.4
import QtQuick 2.10
import QtQuick.Controls.Material 2.15
import QtQuick.Controls 2.15
import QtQuick.Dialogs 1.2
import QtQuick.Controls.Styles 1.4
import "qrc:/dialog"


Page{
     id:basePage

     property alias addrSwitchOne:switch1.address
     property alias currentStateSwitchOne:switch1.currentSwitch1State
     property alias addrSwitchTwo: switch2.address
     property alias currentStateSwitchTwo:switch2.currentSwitch2State
     property alias addrSwitchThree: switch3.address
     property alias currentStateSwitchThree:switch3.currentSwitch3State
     property alias addrSwitchFour:switch4.address
     property alias currentStateSwitchFour:switch4.currentSwitch4State
     property alias addrToggleOne:button1.address
     property alias currentStateToggleOne: button1.currentToggleOneState
     property alias addrToggleTwo:button2.address
     property alias currentStateToggleTwo:button2.currentToggleTwoState
     property alias addrDialOne:dial.address
     property alias currentDialStateOne:dial.dialOneState
     property alias dilaOneValue:dial.oldValue
     property alias addrDialTwo:dial1.address
     property alias currentDialStateTwo:dial1.dialTwoState
     property alias dilaTwoValue:dial1.oldValue

     title:"Control panel"
     //    Layout.preferredWidth: 695
     //  Layout.preferredHeight: 445
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

                    Action { text: qsTr("Switch");onTriggered: switchSetDialog.open()}
                    Action { text: qsTr("Button");onTriggered: buttonSetDialog.open() }
                    Action { text: qsTr("Dial");onTriggered: sliderSetDialog.open()}

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

                        arrow: Canvas {
                            x: parent.width - width
                            implicitWidth: 40
                            implicitHeight: 40
                            visible: menuItem.subMenu
                            onPaint: {
                                var ctx = getContext("2d")
                                ctx.fillStyle = menuItem.highlighted ? "#ffffff" : "#21be2b"
                                ctx.moveTo(15, 15)
                                ctx.lineTo(width - 15, height / 2)
                                ctx.lineTo(15, height - 15)
                                ctx.closePath()
                                ctx.fill()
                            }
                        }

                        indicator: Item {
                            implicitWidth: 40
                            implicitHeight: 40
                            Rectangle {
                                width: 26
                                height: 26
                                anchors.centerIn: parent
                                visible: menuItem.checkable
                                border.color: "white"
                                radius: 5
                                Rectangle {
                                    width: 14
                                    height: 14
                                    anchors.centerIn: parent
                                    visible: menuItem.checked
                                    color: "white"
                                }
                            }
                        }

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
           //layoutDirection: Qt.LeftToRight
           // flow: Flow.LeftToRight
            anchors.centerIn: parent
            spacing: 25

            Frame{

                id:columnswitchframe
                width: 260
                height: 210
    implicitWidth:  240
    implicitHeight: 300
    background: Rectangle {
        color: "#322d3a"
        border.color: "#322d3a"

    }

    Column{
        id:columnSwitch
        width: 103
        height: 195
        anchors.verticalCenter: parent.verticalCenter
        anchors.verticalCenterOffset: -7
        layer.textureMirroring: ShaderEffectSource.NoMirroring
        layer.enabled: false
        anchors.horizontalCenterOffset: -35
        anchors.horizontalCenter: parent.horizontalCenter
        spacing: 7
        
////////////////////////////////////////////////////////////////////////////////////////////////////////
  SwitchDelegate {
            id: switch1
            property int   address:100001
            property bool  currentSwitch1State

            contentItem: Text {
            id:switch1text
            rightPadding: switch1.indicator.width +5 //(switch1.spacing-3)
            text: switch1.text
            font: {
                     switch1.font;
                     font.family="Verdana";
                     font.pixelSize=17;
                     font.weight=Font.DemiBold
                  }
            opacity: enabled ? 1.0 : 0.3
            color:switch1.currentSwitch1State ? Material.color(Material.Green,Material.Shade200)
                                              : Material.color(Material.Orange,Material.Shade200)

            elide: Text.ElideLeft
            verticalAlignment: Text.AlignVCenter

          }

            indicator: Rectangle {
            implicitWidth: 55
            implicitHeight: 28
            x: switch1.width - width - switch1.rightPadding
            y: parent.height / 2 - height / 2
            radius: 14
            border.width: 2
            color: switch1.currentSwitch1State ? Material.color(Material.BlueGrey,Material.Shade400) : "transparent"
            border.color: switch1.currentSwitch1State ? Material.color(Material.Orange,Material.Shade100) : "#cccccc"

            Rectangle {
                x: switch1.checked ? parent.width - width : 0
                width: 28
                height: 28
                radius: 14
                border.width: 2
                color: switch1.currentSwitch1State ? Material.color(Material.Green,Material.Shade100)
                                                   : Material.color(Material.Red,Material.Shade100)
                border.color: switch1.currentSwitch1State ? (switch1.down ? Material.color(Material.LightBlue,Material.Shade400)
                                                                  : Material.color(Material.Green,Material.Shade400))
                                                  : Material.color(Material.Red,Material.Shade400)
             }
          }

            background: Rectangle {
                implicitWidth: 100
                implicitHeight: 40
                visible: switch1.down || switch1.highlighted
                color: switch1.down ? "transparent" : "transparent"
            }

            onPositionChanged:{
                if(switch1.text<="")
              {   checked=false                   
                  switchSetDialog.open()
              }
               else if(switch1.text >= "" )
              {
                  position ? backend.writeCoil(address,checked):
                             backend.writeCoil(address,checked)
              }

           }

        }

////////////////////////////////////////////////////////////////////////////////////////////////

        SwitchDelegate {
            id: switch2
            property int address:100002
            property bool  currentSwitch2State

           contentItem: Text {
                id:switch1text2
                rightPadding: switch2.indicator.width+5// + switch2.spacing
                text: switch2.text
                font: {
                        switch2.font;
                        font.family="Verdana";
                        font.pixelSize=17;
                        font.weight=Font.DemiBold

                       }
                opacity: enabled ? 1.0 : 0.3
                color:switch2.currentSwitch2State ? Material.color(Material.Green,Material.Shade200)
                                                  : Material.color(Material.Orange,Material.Shade200)



                elide: Text.ElideRight
                verticalAlignment: Text.AlignVCenter

            }

            indicator: Rectangle {
                implicitWidth: 55
                implicitHeight: 28
                x: switch2.width - width - switch2.rightPadding
                y: parent.height / 2 - height / 2
                radius: 14
                border.width: 2
                color: switch2.currentSwitch2State ? Material.color(Material.BlueGrey,Material.Shade400) : "transparent"
                border.color: switch2.currentSwitch2State ? Material.color(Material.Orange,Material.Shade100) : "#cccccc"

                Rectangle {
                    x: switch2.checked ? parent.width - width : 0
                    width: 28
                    height: 28
                    radius: 14
                    border.width: 2
                    color: switch2.currentSwitch2State ? Material.color(Material.Green,Material.Shade100)
                                                       : Material.color(Material.Red,Material.Shade100)
                    border.color: switch2.currentSwitch2State ? (switch2.down ? Material.color(Material.LightBlue,Material.Shade400)
                                                              : Material.color(Material.Green,Material.Shade400))
                                                              : Material.color(Material.Red,Material.Shade400)
                }
            }

            background: Rectangle {
                implicitWidth: 100
                implicitHeight: 40
                visible: switch2.down || switch2.highlighted
                color: switch2.down ? "transparent" : "transparent"
            }
            onPositionChanged:  {
                if(switch2.text<="")
              {           checked=false
                        switchSetDialog.open()

               }
               else if(switch2.text >= "")
              {

               position ? backend.writeCoil(address,checked)
                        : backend.writeCoil(address,checked)

               }

           }

        }
////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        SwitchDelegate {
            id: switch3
            property int address:100003
            property bool  currentSwitch3State

            contentItem: Text {
                id:switch1text3
                rightPadding: switch3.indicator.width + 5//switch3.spacing
                text: switch3.text
                font: {
                        switch3.font;                        
                        font.family="Verdana";
                        font.pixelSize=17;
                        font.weight=Font.DemiBold
                       }
                opacity: enabled ? 1.0 : 0.3
                color: switch3.currentSwitch3State ? Material.color(Material.Green,Material.Shade200)
                                                   : Material.color(Material.Orange,Material.Shade200)
                elide: Text.ElideRight
                verticalAlignment: Text.AlignVCenter

            }

            indicator: Rectangle {
                implicitWidth: 55
                implicitHeight: 28
                x: switch3.width - width - switch3.rightPadding
                y: parent.height / 2 - height / 2
                radius: 14
                border.width: 2
                color: switch3.currentSwitch3State ? Material.color(Material.BlueGrey,Material.Shade400) : "transparent"
                border.color: switch3.currentSwitch3State ? Material.color(Material.Orange,Material.Shade100) : "#cccccc"

                Rectangle {
                    x: switch3.checked ? parent.width - width : 0
                    width: 28
                    height: 28
                    radius: 14
                    border.width: 2
                    color: switch3.currentSwitch3State ?Material.color(Material.Green,Material.Shade100)
                                        :  Material.color(Material.Red,Material.Shade100)
                    border.color: switch3.currentSwitch3State ? (switch3.down ? Material.color(Material.LightBlue,Material.Shade400)
                                                              : Material.color(Material.Green,Material.Shade400))
                                                              : Material.color(Material.Red,Material.Shade400)
                }
            }

            background: Rectangle {
                implicitWidth: 100
                implicitHeight: 40
                visible: switch3.down || switch3.highlighted
                color: switch3.down ? "transparent" : "transparent"
            }
            onPositionChanged:  {
                if(switch3.text<="")
              {           checked=false
                        switchSetDialog.open()

               }
               else if(switch3.text >= "")
              {
                 position ? backend.writeCoil(address,checked)
                          : backend.writeCoil(address,checked)
               }

           }

        }
        SwitchDelegate {
            id: switch4
            property int address:100004
            property bool  currentSwitch4State
            contentItem: Text {
                id:switch1text4
                rightPadding: switch4.indicator.width + 5//switch4.spacing
                text: switch4.text
                font: {
                        switch4.font;
                        font.family="Verdana";
                        font.pixelSize=17;
                        font.weight=Font.DemiBold
                       }
                opacity: enabled ? 1.0 : 0.3
                color:switch4.currentSwitch4State ? Material.color(Material.Green,Material.Shade200)
                                                  : Material.color(Material.Orange,Material.Shade200)
                elide: Text.ElideRight
                verticalAlignment: Text.AlignVCenter
                bottomPadding: 20

            }

            indicator: Rectangle {
                implicitWidth: 55
                implicitHeight: 28
                x: switch4.width - width - switch4.rightPadding
                y: parent.height / 2 - height / 2
                radius: 14
                border.width: 2
                color: switch4.currentSwitch4State ? Material.color(Material.BlueGrey,Material.Shade400) : "transparent"
                border.color: switch4.currentSwitch4State ? Material.color(Material.Orange,Material.Shade100) : "#cccccc"

                Rectangle {
                    x: switch4.checked ? parent.width - width : 0
                    width: 28
                    height: 28
                    radius: 14
                    border.width: 2
                    color: switch4.currentSwitch4State ? Material.color(Material.Green,Material.Shade100)
                                                       : Material.color(Material.Red,Material.Shade100)
                    border.color: switch4.currentSwitch4State ? (switch4.down ? Material.color(Material.LightBlue,Material.Shade400)
                                                              : Material.color(Material.Green,Material.Shade400))
                                                              : Material.color(Material.Red,Material.Shade400)
                }
            }

            background: Rectangle {
                implicitWidth: 100
                implicitHeight: 40
                visible: switch4.down || switch4.highlighted
                color: switch4.down ? "transparent" : "transparent"
            }
            onPositionChanged:  {
                if(switch4.text<="")
              {           checked=false
                        switchSetDialog.open()

               }
               else if(switch4.text >= "")
              {
                 position ? backend.writeCoil(address,checked)
                          : backend.writeCoil(address,checked)
               }

           }

        }

        }//column

}//framecolumn


Frame{

    id:columframe
    width: 260
    height: 210
    implicitWidth:  400
    implicitHeight: 350
    background: Rectangle {
        color: "#322d3a"
        border.color: "#322d3a"
        
           //color: "transparent"
           //border.color: Material.color(Material.LightBlue,Material.Shade400)
           //radius: 4
           //border.width: 2

    }

    Column{
        id: column
        x: 0
        y: 0
        width: 230
        height: 210
        anchors.verticalCenter: parent.verticalCenter
        anchors.horizontalCenterOffset: 0
        anchors.horizontalCenter: parent.horizontalCenter
        
        spacing:20
        
        Row{
            anchors.horizontalCenter: parent.horizontalCenter
            spacing:47

        ToggleButton {
            id: button2
            property int address:20000
            property bool  currentToggleTwoState
            width: 90
            height: 90
            text:{
                   font.pixelSize=19;
                   horizontalAlignment= Text.AlignHCenter;
                   verticalAlignment= Text.AlignVCenter;
                   font.family= "Verdana";
                   color:currentToggleTwoState ? Material.color(Material.LightBlue,Material.ShadeA400)
                                               : Material.color(Material.Amber,Material.ShadeA400)
                 }

            style:ToggleButtonStyle{
                checkedDropShadowColor: Material.color(Material.LightGreen,Material.ShadeA400)
                checkedGradient: Gradient {
                    GradientStop { position: 0.0; color: Material.color(Material.LightGreen,Material.Shade700) }
                    GradientStop { position: 0.33; color: Material.color(Material.LightGreen,Material.Shad400)}
                    GradientStop { position: 1.0; color:  Material.color(Material.LightGreen,Material.Shade200) }
                }
                uncheckedGradient: Gradient {
                    GradientStop { position: 0.0; color: Material.color(Material.Red,Material.Shade700) }
                    GradientStop { position: 0.33; color: Material.color(Material.Red,Material.Shade400)}
                    GradientStop { position: 1.0; color:  Material.color(Material.Red,Material.Shade200) }
                }

                  uncheckedDropShadowColor: Material.color(Material.Red,Material.ShadeA400)

              }

            anchors.rightMargin: 50
            implicitWidth: 90
            implicitHeight: 90
            isDefault: true
            onCheckedChanged:{
                                 if(button2.text<="")
                               {           checked=false
                                         buttonSetDialog.open()

                                }
                                else if(button2.text>="")
                               {
                                 checked ?backend.writeCoil(address,checked)
                                         :backend.writeCoil(address,checked)
                                }



                              }

 }

        ToggleButton {
            id: button1
            property int address:20001
            property bool  currentToggleOneState
            width: 90
            height: 90
            implicitWidth: 90
            implicitHeight: 90
            isDefault: true          
            text:{
                   font.pixelSize=19;
                   horizontalAlignment= Text.AlignHCenter;
                   verticalAlignment= Text.AlignVCenter;
                   font.family= "Verdana";
                   color:currentToggleOneState ? Material.color(Material.LightBlue,Material.ShadeA400)
                                               : Material.color(Material.Amber,Material.ShadeA400)
                  }

            style:ToggleButtonStyle{
                checkedDropShadowColor:Material.color(Material.LightGreen,Material.ShadeA400)
                checkedGradient: Gradient {
                    GradientStop { position: 0.0; color: Material.color(Material.LightGreen,Material.Shade700) }
                    GradientStop { position: 0.33; color: Material.color(Material.LightGreen,Material.Shad400)}
                    GradientStop { position: 1.0; color:  Material.color(Material.LightGreen,Material.Shade200) }
                }
                uncheckedGradient: Gradient {
                    GradientStop { position: 0.0; color: Material.color(Material.Red,Material.Shade700) }
                    GradientStop { position: 0.33; color: Material.color(Material.Red,Material.Shade400)}
                    GradientStop { position: 1.0; color:  Material.color(Material.Red,Material.Shade200) }
                }

                  uncheckedDropShadowColor: Material.color(Material.Red,Material.ShadeA400)


              }

         onCheckedChanged:{

                             if(button1.text<="")
                           {           checked=false
                                     buttonSetDialog.open()

                           }
                            else if(button1.text >= "")
                           {
                             checked ?backend.writeCoil(address,checked)
                                     :backend.writeCoil(address,checked)
                           }

                     }

        }


        }//rowToogle

        Row{
            layoutDirection: Qt.LeftToRight
             spacing:27

             Dial {
                 id: dial
                 property bool dialOneState
                 property int oldValue
                 property int address:30000
                 property alias nameSlider:dialname.text
                 stepSize: 1
                 from: 0
                 value: 0
                 to: 255
                 live: false
                 inputMode: Dial.Horizontal
                 snapMode:  Dial.SnapOnRelease
                 background: Rectangle {
                        x: dial.width / 2 - width / 2
                        y: dial.height / 2 - height / 2
                        width: Math.max(64, Math.min(dial.width, dial.height))
                        height: width
                        color:dial.pressed? Material.color(Material.Amber,Material.Shade100):"transparent"
                        radius: width / 2
                        border.color: dial.pressed ? Material.color(Material.Yellow,Material.Shade700)
                                                      :Material.color(Material.Blue,Material.Shade200)
                        opacity: dial.enabled ? 1 : 0.3
                        border.width: 2
                    }

                    handle: Rectangle {
                        id: handleItem
                        x: dial.background.x + dial.background.width / 2 - width / 2
                        y: dial.background.y + dial.background.height / 2 - height / 2
                        width: 16
                        height: 16
                        radius: 8
                        antialiasing: true
                        opacity: dial.enabled ? 1 : 0.3
                        transform: [
                            Translate {
                                y: -Math.min(dial.background.width, dial.background.height) * 0.4 + handleItem.height / 2
                            },
                            Rotation {
                                angle: dial.angle
                                onAngleChanged: {

                                                if(dial.angle>=130)
                                                {
                                                    handleItem.color=Material.color(Material.color
                                                                                    (Material.BlueGrey,Material.Shade400))
                                                }else
                                                    handleItem.color=
                                                                Material.color(Material.Teal,Material.Shade400)
                                }
                                origin.x: handleItem.width / 2
                                origin.y: handleItem.height / 2
                            }
                        ]
                    }
                    Text {
                        id: dialname
                        x: 4
                        y: 102
                        width: 90
                        height:text.height
                        color:Material.color(Material.LightBlue,Material.Shade400)
                        text: qsTr("")
                        anchors.verticalCenter: parent.verticalCenter
                        font.pixelSize: 15
                        Material.foreground:Material.Shade500
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                        anchors.verticalCenterOffset: -59
                        anchors.horizontalCenterOffset: 0
                        anchors.horizontalCenter: parent.horizontalCenter
                        font.weight: Font.DemiBold
                        font.family: "Verdana"
                    }
                    onValueChanged: {



                        if(dialname.text<="")
                      {
                            sliderSetDialog.open()
                            dial.live=false
                            dial.value=0
                            dial.oldValue=value


                       }
                       else if(dialname.text >= "")
                      {
                            if(dial.oldValue!==dial.value)
                            {                             
                                  backend.writeReg(address,value);
                                  dial.oldValue=dial.value
                            }





                      }



                    }



             }

             Dial {
                 id: dial1
                 property bool dialTwoState
                 property int address:30001
                 property int oldValue
                 property alias nameSlider:dialname1.text                 
                 from: 0
                 value:0
                 to: 255
                 stepSize: 1
                 live: false
                 inputMode: Dial.Horizontal
                 snapMode: Dial.SnapOnRelease                  //Dial.SnapAlways
                 background: Rectangle {
                        x: dial1.width / 2 - width / 2
                        y: dial1.height / 2 - height / 2
                        width: Math.max(64, Math.min(dial1.width, dial1.height))
                        height: width
                        color:dial1.pressed? Material.color(Material.Amber,Material.Shade100):"transparent"
                        radius: width / 2
                        border.color: dial1.pressed ? Material.color(Material.Yellow,Material.Shade700)
                                                      :Material.color(Material.Blue,Material.Shade200)
                        opacity: dial1.enabled ? 1 : 0.3
                        border.width: 2

                    }

                    handle: Rectangle {
                        id: handleItemtwo
                        x: dial1.background.x + dial1.background.width / 2 - width / 2
                        y: dial1.background.y + dial1.background.height / 2 - height / 2
                        width: 16
                        height: 16
                        radius: 8
                        antialiasing: true
                        opacity: dial1.enabled ? 1 : 0.3
                        transform: [
                            Translate {
                                y: -Math.min(dial1.background.width, dial1.background.height) * 0.4 + handleItemtwo.height / 2
                            },
                            Rotation {
                                angle: dial1.angle
                                onAngleChanged: {

                                                if(dial1.angle>=130)
                                                {
                                                    handleItemtwo.color=Material.color(Material.color
                                                                                      (Material.BlueGrey,Material.Shade400))
                                                }else
                                                    handleItemtwo.color=
                                                                Material.color(Material.Teal,Material.Shade400)
                                }
                                origin.x: handleItemtwo.width / 2
                                origin.y: handleItemtwo.height / 2
                            }
                        ]
                    }

                    Text {
                        id: dialname1
                        x: 11
                        y: 102
                        width: 90
                        height:text.height
                        color:Material.color(Material.LightBlue,Material.Shade400)
                        text: qsTr("")
                        Material.foreground:Material.Shade500
                        anchors.verticalCenter: parent.verticalCenter
                        font.pixelSize: 15
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                        anchors.verticalCenterOffset: -59
                        anchors.horizontalCenter: parent.horizontalCenter
                        font.weight: Font.DemiBold
                        font.family: "Verdana"

                    }

                    onValueChanged:{



                        if(dialname1.text<="")
                      {
                            sliderSetDialog.open()
                            dial1.live=false
                            dial1.value=0
                            dial1.oldValue=value

                       }
                       else if(dialname1.text >= "")
                      {

                            if(dial1.oldValue!==dial1.value)
                            {
                               backend.writeReg(address,value);
                               dial1.oldValue=dial1.value
                            }

                      }



                    }


             }


 }//Row

 }//Column

}//framecolumn

}//Generallayot


}//frame



        SliderDialog{
          id:sliderSetDialog

           onAccepted: {
                    if(sliderSetDialog.sliderSelect)
                    {
                      dial.address = sliderSetDialog.addressValue
                      dial.nameSlider=sliderSetDialog.nameElement

                    }else{

                           dial1.address = sliderSetDialog.addressValue
                           dial1.nameSlider=sliderSetDialog.nameElement

                         }

              }

        }
        SwitchDialog{
          id:switchSetDialog

           onAccepted: {
                    if(switchSetDialog.switchSelect===0)
                    {
                      switch1.address = switchSetDialog.addressValue
                      switch1.text=switchSetDialog.nameElement

                    }else if(switchSetDialog.switchSelect===1) {

                           switch2.address = switchSetDialog.addressValue
                           switch2.text=switchSetDialog.nameElement

                         }else if(switchSetDialog.switchSelect===2)
                                {
                                  switch3.address = switchSetDialog.addressValue
                                  switch3.text=switchSetDialog.nameElement

                                }
                    else if(switchSetDialog.switchSelect===3)
                    {

                                switch4.address = switchSetDialog.addressValue
                                switch4.text=switchSetDialog.nameElement
                    }

           }

        }
        ButtonDialog{
          id:buttonSetDialog

           onAccepted: {
                    if(buttonSetDialog.buttonSelect)
                    {
                      button1.address = buttonSetDialog.addressValue
                      button1.text=buttonSetDialog.nameElement

                    }else{

                           button2.address = buttonSetDialog.addressValue
                           button2.text=buttonSetDialog.nameElement

                         }

           }

        }



}




/*##^##
Designer {
    D{i:0;formeditorZoom:0.8999999761581421}
}
##^##*/
