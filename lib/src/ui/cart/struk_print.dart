import 'package:kasir_app/src/config/constans_config.dart';
import 'package:kasir_app/src/model/widget_model.dart';
import 'package:kasir_app/src/ui/components/printer_enum.dart';
import 'package:blue_thermal_printer/blue_thermal_printer.dart';
import 'dart:io';
import 'package:http/http.dart' as http;

///Test printing
class StrukPrintCart {
  BlueThermalPrinter bluetooth = BlueThermalPrinter.instance;

  sample(
    List<CartModel> cart, {
    String? appName,
    String? appAddress,
    String? appPhone,
    int? total,
    String? buyerName,
    String? amountPaid,
  }) async {
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
          appName ?? "Kasir Demo",
          Size.boldMedium.val,
          Align.center.val,
        );
        bluetooth.printCustom(
          appAddress ?? "Purwori Pasuruan",
          Size.medium.val,
          Align.center.val,
        );
        bluetooth.printCustom(
          "Telp : ${appPhone ?? '12345678'}",
          Size.medium.val,
          Align.center.val,
        );
        bluetooth.printNewLine();
        // bluetooth.printImageBytes(imageBytesFromNetwork); //image from Network
        // bluetooth.printNewLine();

        bluetooth.printLeftRight(
          "Pembeli : ",
          buyerName ?? "-",
          Size.bold.val,
          format: "%-15s %15s %n",
        );

        bluetooth.printCustom(
          "----------------------------------------",
          Size.medium.val,
          Align.center.val,
        );
        bluetooth.printNewLine();

        cart.forEach((e) {
          String s = e.product!.unit ?? "-";
          final idx = s.split("/");

          int qty = int.parse(idx[0]) * e.qty;
          String unit = '$qty/${idx[1]}';

          bluetooth.printCustom(
            (e.product!.name ?? "-"),
            Size.bold.val,
            Align.left.val,
            charset: "windows-1250",
          );

          String desc =
              "$unit x ${toCurrency(double.parse(e.product!.price ?? "0"))}";
          String price = toCurrency(double.parse(
              (int.parse(e.product!.price ?? "0") * e.qty).toString()));

          bluetooth.printCustom(
            '${desc.padRight(20)}${price.padLeft(10)}',
            Size.bold.val,
            Align.center.val,
            charset: "windows-1250",
          );

          // bluetooth.printLeftRight(
          //   "$unit x ${toCurrency(double.parse(e.product!.price ?? "0"))}",
          //   toCurrency(
          //     double.parse(
          //       (int.parse(e.product!.price ?? "0") * e.qty).toString(),
          //     ),
          //   ),
          //   Size.bold.val,
          //   charset: "windows-1250",
          // );
        });
        bluetooth.printNewLine();

        bluetooth.printCustom(
          "----------------------------------------",
          Size.medium.val,
          Align.center.val,
        );
        bluetooth.printNewLine();

        bluetooth.printLeftRight(
          "Total Harga",
          toCurrency(double.parse(total.toString())),
          Size.bold.val,
          charset: "windows-1250",
        );

        if (amountPaid != '') {
          bluetooth.printLeftRight(
            "Jumlah Bayar",
            toCurrency(double.parse(amountPaid ?? "0")),
            Size.bold.val,
            charset: "windows-1250",
          );
          bluetooth.printLeftRight(
            "Kembalian",
            toCurrency(double.parse(
              (int.parse(amountPaid ?? "0") - int.parse(total.toString()))
                  .toString(),
            )),
            Size.bold.val,
            charset: "windows-1250",
          );
        }

        bluetooth.printNewLine();
        bluetooth.printNewLine();
        bluetooth.printCustom(
          "Barang yang sudah dibeli tidak dapat ditukar / dikembalikan.",
          Size.bold.val,
          Align.center.val,
        );

        bluetooth.printNewLine();
        bluetooth.printCustom(
          dateFormatEEEEdMMMMyyyyhhmm(DateTime.now()),
          Size.bold.val,
          Align.center.val,
        );
        // bluetooth.printNewLine();
        // bluetooth.printQRcode(
        //     "Insert Your Own Text to Generate", 200, 200, Align.center.val);
        bluetooth.printNewLine();
        bluetooth.printNewLine();
        bluetooth
            .paperCut(); //some printer not supported (sometime making image not centered)
        //bluetooth.drawerPin2(); // or you can use bluetooth.drawerPin5();
      } else {
        getToast('Printer tidak terhubung');
      }
    });
  }
}
