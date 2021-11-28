import QtQuick 2.10
import QtQuick.Controls 2.3
import QtQuick.Controls.Material 2.15
Button {
    id: control

    //leftPadding: padding + 10
    //topPadding: padding + 5
    //rightPadding: padding + 10
    //bottomPadding: padding + 5

    property alias color: back.color
    property alias border: back.border
    Material.foreground:Material.color(Material.LightBlue,Material.Shade50)
    font.pixelSize: 15
    font.weight: Font.Bold

    // Text {
    //    text: control.text
    //    font.pixelSize: 15
    //    anchors.horizontalCenter: parent.horizontalCenter
    //
    //}

    background: Rectangle {
        id: back
        border.width:1
        border.color: "white"
        radius:5
        color: Material.color(Material.DeepPurple)

    }

}
