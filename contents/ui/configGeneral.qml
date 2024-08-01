// configGeneral.qml
import QtQuick 2.0
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.1
import org.kde.kirigami 2.5 as Kirigami

Item {
    id: page
    property alias cfg_sharkleColor: sharkleColor.currentIndex
    property alias cfg_pizzaCursor: pizzaCursor.checked

    Kirigami.FormLayout {
        anchors.left: parent.left
        anchors.right: parent.right

        ComboBox {
            id: sharkleColor
            Kirigami.FormData.label: "Sharkle Color:"
            model: ["Black", "White"]
        }
        CheckBox {
            id: pizzaCursor
            Kirigami.FormData.label: "Pizza Cursor:"
        }
    }
}