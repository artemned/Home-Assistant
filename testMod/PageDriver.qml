import QtQuick 2.0
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.3
import QtQuick.Controls.Material 2.15

Page{

    title: "Driver"

    property int del:12

    property int count: 1






    ColumnLayout
    {
        anchors.fill: parent
        anchors.margins: 10
        Button {
            id: btn_send

            //enabled: !btn_connect.enabled
            text: "Click!"
            font.pixelSize: 14
            Material.foreground:Material.Shade500
            Material.background: Material.Purple
            onClicked: {

                //backend.writeCoil(count,1);






                //backend.sendClicked(msgToSend.text);
            }
        }

   }


    function increace()
    {

      count++;

    }
    function writer()
    {

       return del = 1023 / Math.random(255);

    }
}
