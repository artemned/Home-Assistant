import QtQuick 2.0
import QtGraphicalEffects 1.12
Item {
    id: knob
    transformOrigin: Item.Center


    property var metaData : ["from", "to", "value",
        "reverse",
        "fromAngle", "toAngle",
        "lineWidth", "fontSize",
        "knobBackgroundColor", "knobColor",
        "title", "titleFont", "titleFontSize", "titleFontColor"]

    //value parameters
    property double from:0
    property double value: 1
    property double to: 100

    //progress from right to left
    property bool reverse: false

    //progress circle angle
    property double fromAngle: Math.PI - 1
    property double toAngle: Math.PI *2 + 1

    property int lineWidth: height / 10
    property int fontSize: height / 7

    property color knobBackgroundColor: Qt.rgba(0.1, 0.1, 0.1, 0.1)
    property color knobColor: Qt.rgba(1, 0, 0, 1)

    property string title: ""
    property alias titleFont: labelTitle.font.family
    property alias titleFontSize: labelTitle.font.pointSize
    property alias titleFontColor: labelTitle.color
    property alias digitColor:label.color

    property alias imageFon:image.source

    function update(value) {
        knob.value = value
        canvas.requestPaint()
        background.requestPaint()
        label.text = value.toFixed(2)+' ℃';
    }

    Text {
        id: labelTitle
        y: 2
        text: knob.title
        color: Qt.rgba(0, 0, 0., 0.5)
        horizontalAlignment: Text.AlignHCenter
        anchors.horizontalCenter: parent.horizontalCenter
    }

//    Rectangle{
//        anchors.centerIn: parent
//        width: 100
//        height: 100
//        border.width: 1
//        border.color: "white"
//
//}

    Canvas {
        id: background
        width: parent.height
        height: parent.height
        antialiasing: true

        property int radius: background.width/2

        onPaint: {

            if (knob.title !== "") {
                background.y = labelTitle.height
                background.x = labelTitle.height/2
                background.height = parent.height - labelTitle.height/2
                background.width = parent.height - labelTitle.height/2
                background.radius = background.height /2
            }

            var centreX = background.width / 2.0;
            var centreY = background.height / 2.0;

            var ctx = background.getContext('2d');
            ctx.strokeStyle = knob.knobBackgroundColor;
            ctx.lineWidth = knob.lineWidth;
            ctx.lineCap = "round"
            ctx.beginPath();
            ctx.clearRect(0, 0, background.width, background.height);
            ctx.arc(centreX, centreY, radius - knob.lineWidth, knob.fromAngle, knob.toAngle, false);
            ctx.stroke();
        }
    }

    Canvas {
        id:canvas
        width: parent.height
        height: parent.height
        antialiasing: true

        property double step: knob.value / (knob.to - knob.from) * (knob.toAngle - knob.fromAngle)
        property int radius: height/2

        Image {
            id:image
            anchors.centerIn:  parent

            width: canvas.width/2
            height: canvas.height/2
            source: "qrc:/Icons/Icons/tempa.png"
            anchors.horizontalCenterOffset: 1.5
            fillMode: Image.PreserveAspectFit
            smooth: true
            visible: false
            asynchronous: true
        }
        ColorOverlay{
            anchors.fill: image
                      //id:color
                      source: image
                      color: "white"
        }
            Text {
                id: label
                font.bold: true
                z: 1
                font.pointSize: knob.fontSize
                text: knob.value.toFixed(2)+' ℃'
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.top: image.bottom
                anchors.horizontalCenterOffset:1

                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                anchors.topMargin: 27


                anchors.rightMargin: -5
                anchors.leftMargin: 0
                //anchors.fill: parent
            }

      onPaint: {

            if (knob.title !== "") {
                canvas.y = labelTitle.height
                canvas.x = labelTitle.height/2
                canvas.height = parent.height - labelTitle.height/2
                canvas.width = parent.height - labelTitle.height/2
                canvas.radius = canvas.height /2
            }

            var centreX = canvas.width / 2.0;
            var centreY = canvas.height / 2.0;

            var ctx = canvas.getContext('2d');
            ctx.strokeStyle = knob.knobColor;
            ctx.lineWidth = knob.lineWidth;
            ctx.lineCap = "round"
            ctx.beginPath();
            ctx.clearRect(0, 0, canvas.width, canvas.height);



            if (knob.reverse) {
                ctx.arc(centreX, centreY, radius - knob.lineWidth, knob.toAngle, knob.toAngle - step, true);
            } else {
                ctx.arc(centreX, centreY, radius - knob.lineWidth, knob.fromAngle, knob.fromAngle + step, false);
            }
            ctx.stroke();
        }
    }
}



/*##^##
Designer {
    D{i:0;autoSize:true;height:480;width:640}
}
##^##*/
