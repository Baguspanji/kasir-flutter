import 'package:kasir_app/src/ui/components/printer_enum.dart';
import 'package:blue_thermal_printer/blue_thermal_printer.dart';
import 'dart:io';
import 'package:http/http.dart' as http;

///Test printing
class TestPrint {
  BlueThermalPrinter bluetooth = BlueThermalPrinter.instance;

  sample() async {
    //image max 300px X 300px

    ///image from Network
    // var response = await http.get(Uri.parse(
    //     "https://raw.githubusercontent.com/kakzaki/blue_thermal_printer/master/example/assets/images/yourlogo.png"));
    // Uint8List bytesNetwork = response.bodyBytes;
    // Uint8List imageBytesFromNetwork = bytesNetwork.buffer
    //     .asUint8List(bytesNetwork.offsetInBytes, bytesNetwork.lengthInBytes);

    bluetooth.isConnected.then((isConnected) {
      if (isConnected == true) {
        bluetooth.printNewLine();
        bluetooth.printCustom(
          "Kasir Demo",
          Size.boldMedium.val,
          Align.center.val,
        );
        bluetooth.printCustom(
          "Purwori Pasuruan",
          Size.medium.val,
          Align.center.val,
        );
        bluetooth.printCustom(
          "Telp : 12345678",
          Size.medium.val,
          Align.center.val,
        );
        bluetooth.printNewLine();
        // bluetooth.printImageBytes(imageBytesFromNetwork); //image from Network
        // bluetooth.printNewLine();

        bluetooth.printLeftRight(
          "Pembeli : ",
          "Budi",
          Size.bold.val,
          format: "%-15s %15s %n",
        );

        bluetooth.printCustom(
          "----------------------------------------",
          Size.medium.val,
          Align.center.val,
        );
        bluetooth.printNewLine();

        bluetooth.printCustom(
          "Kentang",
          Size.bold.val,
          Align.left.val,
          charset: "windows-1250",
        );
        bluetooth.printLeftRight(
          "Rp 4000 x 2",
          "Rp 9.000",
          Size.bold.val,
          charset: "windows-1250",
        );
        bluetooth.printNewLine();

        bluetooth.printCustom(
          "----------------------------------------",
          Size.medium.val,
          Align.center.val,
        );
        bluetooth.printNewLine();

        bluetooth.printLeftRight(
          "Total Harga",
          "Rp 9.000",
          Size.bold.val,
          charset: "windows-1250",
        );
        bluetooth.printNewLine();
        bluetooth.printNewLine();
        bluetooth.printCustom("Thank You", Size.bold.val, Align.center.val);
        // bluetooth.printNewLine();
        // bluetooth.printQRcode(
        //     "Insert Your Own Text to Generate", 200, 200, Align.center.val);
        bluetooth.printNewLine();
        bluetooth.printNewLine();
        bluetooth
            .paperCut(); //some printer not supported (sometime making image not centered)
        //bluetooth.drawerPin2(); // or you can use bluetooth.drawerPin5();
      }
    });
  }
}
