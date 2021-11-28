import QtQuick 2.0
import QtQuick.Controls 1.4
import QtQuick.Layouts 1.3
import io.qt.Backend 1.0
import QtQuick.Extras 1.4
import QtQuick 2.10
import QtQuick.Controls.Material 2.15
import QtQuick.Controls 2.15


Page{
    property alias textStatus: labelStatus.text
    property alias btnConnect: btn_connect.enabled
    id:pageWind

    title:"Connection"
    property bool currentError: false
    property int del:0
    property int count: 0
    property alias butConnection:btn_connect.enabled
    //property alias buttDisconnection:btn_disconnect.


    width: 695
    Layout.minimumWidth: 500
    height: 445
    Layout.minimumHeight: 400


    background: Rectangle{
        anchors.fill: parent
        color: "#322d3a"
    }



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





    ColumnLayout
    {
        anchors.fill: parent
        anchors.margins: 2
        spacing: 1
//        spacing: 1







        RowLayout{

           // spacing: 5
            anchors.horizontalCenter: parent.horizontalCenter

        StatusIndicator {

      anchors.left: parent.left
            id: statusIndicator
            color:backend.currentStatus ? Material.color(Material.Green,Material.Shade500)
                                         :Material.color(Material.Purple,Material.Shade50) //"lightgreen" : "red"
            active: true
        }

        Text {
                 id: status
                // color: "#0c0c0c"
                 color:backend.currentStatus ?
                           Material.color(Material.Green,Material.Shade500)
                           :Material.color(Material.Purple,Material.Shade50)
                font.pixelSize: 15
                 text: backend.currentStatus ? "Connection Established"
                                             : "No connection"
                 font.family: "Verdana"
                 font.weight: Font.DemiBold

             }


 }

//
//
//        Item {
//            id: spaceOne
//            height: 1
//        }
//

        ColumnLayout {
            id:rowlayoutIp
            //Layout.bottomMargin: 15

        spacing:1.5
        anchors.horizontalCenter: parent.horizontalCenter
        Layout.alignment: Qt.AlignHCenter | Qt.AlignTop



        Label{
            text: qsTr("Enter ip  ")
                   font.pixelSize: 15
                   horizontalAlignment: Text.AlignHCenter
                   verticalAlignment: Text.AlignVCenter
                      Material.foreground:Material.Shade500
                      width:150
                      height: 40

                   }

          Frame{

             implicitWidth: 150
             implicitHeight:40
             background: Rectangle {
                     color: "transparent"
                     border.color: "white"
                     radius: 5
                     border.width: 0.5
                 }

           TextField {
                id: textInput
                anchors.centerIn: parent
                Layout.alignment: Qt.AlignLeft
                font.pixelSize: 15
                horizontalAlignment: Text.AlignHCenter
                layer.smooth: true
                hoverEnabled: true
                Material.foreground:Material.Shade500
                placeholderText: "192.168.0.0"


             }//text

         }
}//IP


        Item {
            id: space
            height: 1
        }

        ColumnLayout {

            id:columnlayoutSlave
           // Layout.bottomMargin: 30
            Layout.alignment: Qt.AlignHCenter | Qt.AlignTop
            spacing: 1.2
            anchors.horizontalCenter: parent.horizontalCenter


               Label{
                   text: qsTr("Select port and id ")
                   font.pixelSize:15

                   horizontalAlignment: Text.AlignHCenter
                   Material.foreground:Material.Shade500
                   width: 150
                   height: 40


                  }


               Frame{
                   id:framePortID
                   Layout.bottomMargin: 0
                   Layout.fillHeight: false
                   Layout.fillWidth: false
                   Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                   implicitWidth: 200
                   implicitHeight:60
                background: Rectangle {
                        color: "transparent"
                        border.color: "white"
                        radius: 5
                        border.width: 0.5
                }

                RowLayout{
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.horizontalCenter: parent.horizontalCenter
                    spacing:  2

                ComboBox{
                id:myComboBox

                model: [502,501]
                implicitWidth: 87
                implicitHeight: 50
                font.pixelSize:15
                leftPadding: 3.5
                bottomPadding: 2
                Material.foreground: Material.Shade500
                Material.accent: Material.LightBlue
                anchors.horizontalCenter: parent.verticalCenter
                background: Rectangle {
                        color: "transparent"
                        border.color: "transparent"//"white"
                        radius: 5
                       // border.width: 1.3
                    }
                }

           SpinBox{
               id:slaveId
               implicitWidth: 100
               implicitHeight:40
               anchors.right: framePortID
               anchors.horizontalCenter: parent.verticalCenter
               font.pixelSize: 15
               Material.foreground: Material.Shade500
               Material.accent: Material.LightBlue
               editable: true
               inputMethodHints:Qt.ImhDigitsOnly
           }
}//row

         }

  }//slave id


       RowLayout{
           Layout.alignment: Qt.AlignLeft | Qt.AlignTop
           // Layout.bottomMargin: 90
            spacing: 5
            anchors.horizontalCenter: parent.horizontalCenter
            //anchors.right: parent.right
            //anchors.left: parent.left

            BetterButton {
                id: btn_connect
              // Layout.aligment:Qt.AlignCenter
                anchors.left:parent.left
                font.pixelSize: 14
                font.pointSize: 0
                implicitWidth: 120
                implicitHeight: 50
                text: "Connect"



                color: enabled ? this.down ? Material.color(Material.LightBlue,Material.Shade300)
                     : Material.color(Material.Green,Material.Shade400)
                     : Material.color(Material.BlueGrey,Material.Shade700)


                onClicked: {
      //              ti.append(addMsg("Connecting to server..."));

                    backend.connectClicked(textInput.text,myComboBox.currentValue,
                                                                     slaveId.value);
                   this.enabled = false;
               }
           }

            BetterButton {
                  id: btn_disconnect
                  enabled: !btn_connect.enabled
                  anchors.right: parent.right
                  font.pixelSize: 14
                  font.pointSize: 0
                  implicitWidth: 120
                  implicitHeight: 50
                  text: "Disconnect"
                  color: enabled ? this.down ? Material.color(Material.LightBlue,Material.Shade300)
                                             : Material.color(Material.Red,Material.Shade400)
                                             : Material.color(Material.BlueGrey,Material.Shade700)
                  onClicked: {

                      backend.disconnectClicked();
                      btn_connect.enabled = true;
                }
            }

        }

        Item {
            id:spacethree
            height: 3
        }

StatusBar{

          id:statusBar
         // visible: currentError ? true : false
          visible: false
          Layout.fillWidth: true
          style:Rectangle{
          anchors.fill: parent
          color: "transparent"
        }         
        RowLayout {
                   anchors.fill: parent
                   anchors.left: parent.left
                   anchors.right: parent.rigth
                  Frame{
                     id:frameStatus
                       Layout.fillWidth: true

                  Text {
                         id:labelStatus
                         color: "black"
                         font.pixelSize: 14
                         horizontalAlignment: Text.AlignHCenter
                         verticalAlignment: Text.AlignVCenter
                         Material.foreground:Material.Shade500
                        }

                  background: Rectangle {
                          color: "transparent"
                          border.color: "white"
                          radius: 5
                          border.width: 1.3
                      }


                     }


                 }

       }//status

    }//column
    }//frame

    Component.onCompleted: {

        labelStatus.text=addMsg("Application started\n", false);

      }



    function addMsg(someText)
    {
        return "[" + currentTime() + "] " + someText;
    }

    function increace()
    {

      count++;

    }
    function writer()
    {

       return del = 1023 / Math.random(255);

    }
    function dicreace()
    {
      count--;
    }

    function currentTime()
    {


        var now = new Date();
        var current=now.toLocaleTimeString(locale, Locale.ShortFormat)
        var nowString = ("0" + now.getHours()).slice(-2) + ":"
                + ("0" + now.getMinutes()).slice(-2) + ":"
                + ("0" + now.getSeconds()).slice(-2);
        return current//nowString;
    }

}


