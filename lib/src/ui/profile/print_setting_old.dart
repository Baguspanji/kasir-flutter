import 'package:flutter/material.dart';
import 'dart:async';
import 'package:blue_thermal_printer/blue_thermal_printer.dart';
import 'package:flutter/services.dart';
import 'package:kasir_app/src/config/constans_config.dart';
import 'package:kasir_app/src/config/size_config.dart';
import 'package:kasir_app/src/ui/profile/test_print.dart';

class PrintSettingUI extends StatefulWidget {
  static const routeName = '/profile/print_setting';

  @override
  State<PrintSettingUI> createState() => _PrintSettingUIState();
}

class _PrintSettingUIState extends State<PrintSettingUI> {
  BlueThermalPrinter bluetooth = BlueThermalPrinter.instance;

  List<BluetoothDevice> _devices = [];
  BluetoothDevice? _device;
  bool _connected = false;
  TestPrint testPrint = TestPrint();

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  Future<void> initPlatformState() async {
    // TODO here add a permission request using permission_handler
    // if permission is not granted, kzaki's thermal print plugin will ask for location permission
    // which will invariably crash the app even if user agrees so we'd better ask it upfront

    // var statusLocation = Permission.location;
    // if (await statusLocation.isGranted != true) {
    //   await Permission.location.request();
    // }
    // if (await statusLocation.isGranted) {
    // ...
    // } else {
    // showDialogSayingThatThisPermissionIsRequired());
    // }
    bool? isConnected = await bluetooth.isConnected;
    List<BluetoothDevice> devices = [];
    setState(() {});
    try {
      devices = await bluetooth.getBondedDevices();
    } on PlatformException {}

    bluetooth.onStateChanged().listen((state) {
      switch (state) {
        case BlueThermalPrinter.CONNECTED:
          setState(() {
            _connected = true;
            print("bluetooth device state: connected");
          });
          break;
        case BlueThermalPrinter.DISCONNECTED:
          setState(() {
            _connected = false;
            print("bluetooth device state: disconnected");
          });
          break;
        case BlueThermalPrinter.DISCONNECT_REQUESTED:
          setState(() {
            _connected = false;
            print("bluetooth device state: disconnect requested");
          });
          break;
        // case BlueThermalPrinter.STATE_TURNING_OFF:
        //   setState(() {
        //     _connected = false;
        //     print("bluetooth device state: bluetooth turning off");
        //   });
        //   break;
        case BlueThermalPrinter.STATE_OFF:
          setState(() {
            _connected = false;
            print("bluetooth device state: bluetooth off");
          });
          break;
        // case BlueThermalPrinter.STATE_ON:
        //   setState(() {
        //     _connected = false;
        //     print("bluetooth device state: bluetooth on");
        //   });
        //   break;
        // case BlueThermalPrinter.STATE_TURNING_ON:
        //   setState(() {
        //     _connected = false;
        //     print("bluetooth device state: bluetooth turning on");
        //   });
        //   break;
        case BlueThermalPrinter.ERROR:
          setState(() {
            _connected = false;
            print("bluetooth device state: error");
          });
          break;
        default:
          print(state);
          break;
      }
    });

    if (!mounted) return;
    setState(() {
      _devices = devices;
    });

    if (isConnected == true) {
      setState(() {
        _connected = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            SizedBox(height: height(context) * 0.01),
            Container(
              width: width(context),
              height: height(context) * 0.04,
              margin: EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () => Navigator.pop(context),
                    child: Icon(
                      Icons.arrow_back_ios,
                      size: 20,
                    ),
                  ),
                  SizedBox(width: width(context) * 0.02),
                  Text(
                    'Pengaturan Printer',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.black87,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Spacer(),
                ],
              ),
            ),
            SizedBox(height: height(context) * 0.02),
            Container(
              width: width(context),
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Device',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.black87,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(height: height(context) * 0.01),
                  Container(
                    width: width(context),
                    height: height(context) * 0.06,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.2),
                          spreadRadius: 1,
                          blurRadius: 1,
                          offset: Offset(0, 1),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 10),
                          child: Icon(
                            Icons.print,
                            color: Colors.black87,
                          ),
                        ),
                        Expanded(
                          child: DropdownButton(
                            hint: Text('Pilih Device'),
                            underline: SizedBox(),
                            items: _getDeviceItems(),
                            onChanged: (BluetoothDevice? value) =>
                                setState(() => _device = value),
                            value: _device,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: height(context) * 0.02),
                  Row(
                    children: [
                      Text(
                        'Status :',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.black87,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      SizedBox(width: width(context) * 0.02),
                      Text(
                        _connected ? 'Connected' : 'Disconnected',
                        style: TextStyle(
                          fontSize: 18,
                          color: _connected ? Colors.green : Colors.red,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: height(context) * 0.02),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      button(
                        'Refresh',
                        color: Colors.grey,
                        radius: 10,
                        padding: EdgeInsets.symmetric(
                          horizontal: 40,
                          vertical: 10,
                        ),
                        onPressed: () {
                          initPlatformState();
                        },
                      ),
                      button(
                        _connected ? 'Disconnect' : 'Connect',
                        color: _connected ? Colors.red : Colors.green,
                        radius: 10,
                        padding: EdgeInsets.symmetric(
                          horizontal: 40,
                          vertical: 10,
                        ),
                        onPressed: _connected ? _disconnect : _connect,
                      )
                    ],
                  ),
                  SizedBox(height: height(context) * 0.1),
                  // Center(
                  //   child: button(
                  //     'Test Print',
                  //     color: _connected ? Colors.red : Colors.green,
                  //     radius: 10,
                  //     padding: EdgeInsets.symmetric(
                  //       horizontal: 40,
                  //       vertical: 10,
                  //     ),
                  //     onPressed: (() => testPrint.sample()),
                  //   ),
                  // ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<DropdownMenuItem<BluetoothDevice>> _getDeviceItems() {
    List<DropdownMenuItem<BluetoothDevice>> items = [];
    if (_devices.isEmpty) {
      items.add(DropdownMenuItem(
        child: Text('NONE'),
      ));
    } else {
      _devices.forEach((device) {
        items.add(DropdownMenuItem(
          child: Text(device.name ?? ""),
          value: device,
        ));
      });
    }
    return items;
  }

  void _connect() {
    if (_device != null) {
      bluetooth.isConnected.then((isConnected) {
        print(isConnected);
        if (isConnected == false) {
          bluetooth.connect(_device!).catchError((error) {
            setState(() => _connected = isConnected!);
          });
        }
        setState(() => _connected = isConnected!);
      });
    } else {
      getToast('No device selected.');
    }
  }

  void _disconnect() {
    bluetooth.disconnect();
    setState(() => _connected = false);
  }
}
