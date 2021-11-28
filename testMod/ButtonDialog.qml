import QtQuick.Controls 2.15
import QtQuick.Controls.Material 2.15
import QtQuick.Dialogs 1.2
import QtQuick 2.10

Dialog{
    property alias addressValue: spinBoxAddress.value
    property alias nameElement:textName.text
    property bool buttonSelect:myComboBox.currentIndex ? 1:0
    title: "Button setting"
    //height: 310
    //width: 315


    Material.theme: Material.Dark

    contentItem: Rectangle{

        id:backgound
        width: 315
        height: 310
        border.width: 1
        border.color:Material.Shade500


        Rectangle{

            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top: parent.top
            anchors.bottom:delimiter.top
            gradient: Gradient {
                GradientStop {
                    position: 0.46226
                    color: "#434343"
                }

                GradientStop {
                    position: 0.89937
                    color: "#000000"
                }

            }

        Column{
            id: column
            anchors.fill: parent
            spacing: 3

            Frame{
                id: frame
                height: 45
                anchors.top: parent.top
                anchors.topMargin: 30
                anchors.horizontalCenter: parent.horizontalCenter

       implicitWidth: 170
       implicitHeight:60

       background: Rectangle {
               color: "transparent"
               border.color: "white"
               radius: 5
               border.width: 0.5
           }


   Label{

          anchors.horizontalCenter: parent.horizontalCenter

          id:labelRegister
          text: qsTr("Select address")
          anchors.left: parent.left
          anchors.top: parent.top
          font.pixelSize: 14
          horizontalAlignment: Text.AlignLeft
          font.weight: Font.Normal
          verticalAlignment: Text.AlignTop
          font.bold: false
          font.family: "Verdana"
          anchors.leftMargin: -12
          anchors.topMargin: -27
          anchors.horizontalCenterOffset: 0
          color:Material.color(Material.Shade500)
    }

    SpinBox {
        id: spinBoxAddress
        from: 0
        to:1000
       // anchors.verticalCenter: parent.verticalCenter
        //anchors.verticalCenterOffset: -55
        //anchors.horizontalCenter: parent.horizontalCenter
        //  x: 62
        //y: 115
        height: 35
        anchors.bottom: parent.bottom
        font.pixelSize: 16
        font.weight: Font.Medium
        font.family: "Verdana"
        anchors.bottomMargin: -9
        anchors.horizontalCenter: parent.horizontalCenter
        width: 140
        Material.foreground: Material.Shade500
        Material.accent: Material.LightBlue
        editable: true
        inputMethodHints:Qt.ImhDigitsOnly
    }
   }//frame

            Frame{
                id: frameName
                height: 45
                anchors.top: frame.bottom
                anchors.topMargin: 30
                anchors.horizontalCenter: parent.horizontalCenter


       implicitWidth: 170
       implicitHeight:60

      background: Rectangle {
              color: "transparent"
              border.color: "white"
              radius: 5
              border.width: 0.5
          }


   Label{

          anchors.horizontalCenter: parent.horizontalCenter

          id:labelName
          text: qsTr("Write name")
          anchors.left: parent.left
          anchors.top: parent.top
          font.pixelSize: 14
          font.weight: Font.Normal
          verticalAlignment: Text.AlignTop
          font.family: "Verdana"
          font.bold: false
          anchors.leftMargin: -12
          anchors.topMargin: -27
          anchors.horizontalCenterOffset: 0
          color:Material.color(Material.Shade500)

    }

    TextField {
        id: textName
        y: 18
        placeholderText: "BUTTON NAME"
        maximumLength: 10
        height: 40
        anchors.bottom: parent.bottom
        font.pixelSize: 16
        horizontalAlignment: Text.AlignHCenter
        font.weight: Font.Medium
        font.family: "Verdana"
        anchors.bottomMargin: -11
        anchors.horizontalCenter: parent.horizontalCenter
        width: 146
        Material.foreground: Material.Shade500
        Material.accent: Material.LightBlue

        //inputMethodHints:Qt.ImhDigitsOnly
    }
   }//frame
            Frame{
                id: frameElement
                height: 45
                anchors.top: frameName.bottom
                anchors.topMargin: 30
                anchors.horizontalCenter: parent.horizontalCenter


       implicitWidth: 170
       implicitHeight:60

       background: Rectangle {
               color: "transparent"
               border.color: "white"
               radius: 5
               border.width: 0.5
           }


   Label{

          anchors.horizontalCenter: parent.horizontalCenter

          id:labelElement
          text: qsTr("Select element")
          anchors.left: parent.left
          anchors.top: parent.top
          font.pixelSize: 14
          horizontalAlignment: Text.AlignLeft
          font.weight: Font.Normal
          verticalAlignment: Text.AlignTop
          font.bold: false
          font.family: "Verdana"
          anchors.leftMargin: -12
          anchors.topMargin: -27
          anchors.horizontalCenterOffset: 0
          color:Material.color(Material.Shade500)
    }


   ComboBox{
   id:myComboBox
   y: -7
   width: 146
   height: 35
   anchors.bottom: parent.bottom

   model: ["BUTTON 1","BUTTON 2"]
   implicitWidth: 180
   implicitHeight: 40
   font.pixelSize:16
   font.weight: Font.Medium
   font.family: "Verdana"
   font.preferShaping: true
   anchors.bottomMargin: -7
   anchors.horizontalCenter: parent.horizontalCenter
   leftPadding: 11
   Material.foreground: Material.Shade500
   Material.accent: Material.LightBlue

   background: Rectangle {
           color: "transparent"
          // border.color: "white"
          // radius: 5
          // border.width: 1.3
       }
   }

   }//frame






}//Column

 }
    Rectangle {
        id:delimiter
        height: 1.7
        anchors.right: parent.right
        anchors.left: parent.left
        anchors.bottom: row.top
        color:Material.color(Material.Shade500)

    }

    Row{

        id:row
      anchors.left:  parent.left
      anchors.bottom: parent.bottom
      anchors.right: parent.right
       height: 30

        Button {
            id: save
       anchors.top: parent.top
       anchors.bottom: parent.bottom
       width: parent.width/2-1
            text: "Save"
          //  Material.foreground:Material.Shade500
            font.pixelSize: 15
            font.bold: false
            font.family: "Verdana"
            font.weight: Font.Medium
            Material.foreground:  enabled ? this.down ? Material.color(Material.Green,Material.Shade300)
                               : Material.color(Material.LightBlue,Material.Shade500)
                               : Material.color(Material.BlueGrey,Material.Shade400)

            background: Rectangle {

                anchors.fill: parent
                border.width:1
                border.color: Material.Shade500
                gradient: Gradient {
                    GradientStop {
                        position: 0.69108
                        color: "#434343"
                    }

                    GradientStop {
                        position: 0.90736
                        color: "#434343"
                    }


                    GradientStop {
                        position: 0.3758
                        color: "#000000"
                    }

                }


            }

                onClicked: {
                  //this.enabled = false;
                    accepted()
                    textName.clear()

               }

   }


        Rectangle{
                 id:divider
          width: 1.7
          anchors.top: parent.top
          anchors.bottom: parent.bottom
          color:Material.color(Material.Shade500)


        }


 Button {
     id: cancel
     anchors.top: parent.top
     anchors.bottom: parent.bottom
     width: parent.width/2-1
    // enabled: !save.enabled
     text: "Cancel"

     Material.foreground:enabled ? this.down ?  Material.color(Material.Red,Material.Shade300)
                        : Material.color(Material.LightBlue,Material.Shade500)
                        : Material.color(Material.BlueGrey,Material.Shade400)

     font.pixelSize: 15
     font.family: "Verdana"
     font.bold: false
     font.weight: Font.Medium

     background: Rectangle {

         anchors.fill: parent
         border.width:1
         border.color: Material.Shade500
         gradient: Gradient {
             GradientStop {
                 position: 0.69108
                 color: "#434343"
             }

             GradientStop {
                 position: 0.90736
                 color: "#434343"
             }


             GradientStop {
                 position: 0.3758
                 color: "#000000"
             }
         }

     }

         onClicked: {
                close()

             //save.enabled = true;
         }

 }


 }//row



  }




   // onAccepted: {
   //     console.log("hi im here")
   //
   //    // one.valueD=1           //example
   //    //one.nameTeg="new name"  //example
   //    // one.address=5          //example
   //
   // }



}//dialog

/*##^##
Designer {
    D{i:0;autoSize:true;formeditorZoom:1.659999966621399;height:480;width:640}
}
##^##*/
