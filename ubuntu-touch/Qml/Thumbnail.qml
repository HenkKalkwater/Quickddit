/*
    Quickddit - Reddit client for mobile phones
    Copyright (C) 2020  Daniel Kutka

    This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program.  If not, see [http://www.gnu.org/licenses/].
*/

import QtQuick 2.12
import QtQuick.Controls 2.12
import quickddit.Core 1.0
import QtGraphicalEffects 1.0
//

Image {
    property bool video
    property bool image
    property bool urlPost
    property variant link

    width: 140*persistantSettings.scale
    height: visible ? width : 0

    fillMode: Image.PreserveAspectFit

    //Workaround, because CommentModel was changing this
    Component.onCompleted: {
        source = getUrl()
    }

    function getUrl() {
        if(String(link.thumbnailUrl).length>1)
            return link.thumbnailUrl
        if (image) {
            return Qt.resolvedUrl("qrc:/Icons/image.svg")
        }
        if (video) {
            return Qt.resolvedUrl("qrc:/Icons/video.svg")
        }

        return "https://api.faviconkit.com/" + link.domain+"/144"
    }

    MouseArea {
        anchors.fill: parent
        enabled: urlPost||video
        Rectangle {
            anchors.fill: parent
            color: "black"
            opacity: 0.2
            visible: parent.pressed
        }
        onClicked: {
            globalUtils.openLink(link.url);
        }
    }

    Rectangle{
        anchors{left: parent.left ; right: parent.right; bottom: parent.bottom}
        visible: urlPost
        color: "black"
        opacity: 0.6
        height: 40
        Label {
            text: link.domain
            color: "white"
            font.weight: Font.DemiBold
            width: parent.width
            anchors.centerIn: parent
            horizontalAlignment: "AlignHCenter"
            elide: "ElideRight"
            maximumLineCount: 1
        }
    }

    ToolButton {
        anchors.centerIn: parent
        icon.name: "media-playback-start-symbolic"
        icon.height: parent.height - 70
        icon.width: parent.width - 70
        icon.color: "#BB808080"
        visible: video
        //opacity: 0
        enabled: false
    }
}
