// configGeneral.qml
import QtQuick 2.0
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.12
import org.kde.kirigami 2.4 as Kirigami

Item {
    id: page
    property alias cfg_sharkleColor: sharkleColor.currentText


    Kirigami.FormLayout {
        anchors.left: parent.left
        anchors.right: parent.right

        ComboBox {
            id: sharkleColor
            Kirigami.FormData.label: "Sharkle Color:"
            model: ["Black", "White"]
        }
    }
}