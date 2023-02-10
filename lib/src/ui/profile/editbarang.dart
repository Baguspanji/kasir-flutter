import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kasir_app/src/config/size_config.dart';
import 'package:kasir_app/src/controller/product_controller.dart';

class EditBarang extends StatefulWidget {
  static const routeName = '/profile/editbarang';
  // const EditBarang({super.key});

  @override
  State<EditBarang> createState() => _EditBarangState();
}

class _EditBarangState extends State<EditBarang> {
  var id = Get.arguments[0];
  var code1 = Get.arguments[1];
  var code2 = Get.arguments[2];
  var code3 = Get.arguments[3];
  var code4 = Get.arguments[4];
  var code5 = Get.arguments[5];
  var code6 = Get.arguments[6];
  var code7 = Get.arguments[7];
  var code8 = Get.arguments[8];
  var code9 = Get.arguments[9];
  var code10 = Get.arguments[10];
  var name = Get.arguments[11];
  String unit = Get.arguments[12];
  var takePrice = Get.arguments[13];
  var price = Get.arguments[14];
  late TextEditingController _code1;
  late TextEditingController _code2;
  late TextEditingController _code3;
  late TextEditingController _code4;
  late TextEditingController _code5;
  late TextEditingController _code6;
  late TextEditingController _code7;
  late TextEditingController _code8;
  late TextEditingController _code9;
  late TextEditingController _code10;
  late TextEditingController _name;
  late TextEditingController _unit;
  late TextEditingController _takePrice;
  late TextEditingController _price;
  ProductController edit = Get.put(ProductController());
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _code1 = TextEditingController(text: code1);
    _code2 = TextEditingController(text: code2);
    _code3 = TextEditingController(text: code3);
    _code4 = TextEditingController(text: code4);
    _code5 = TextEditingController(text: code5);
    _code6 = TextEditingController(text: code6);
    _code7 = TextEditingController(text: code7);
    _code8 = TextEditingController(text: code8);
    _code9 = TextEditingController(text: code8);
    _code10 = TextEditingController(text: code10);
    _name = TextEditingController(text: name);
    _unit = TextEditingController(
        text: unit.replaceAll(RegExp('[0-9!@#%^&*(),/.?":{}|<>]'), ""));
    _takePrice = TextEditingController(text: takePrice);
    _price = TextEditingController(text: price);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        centerTitle: true,
        title: const Text(
          "Edit Barang",
          style: TextStyle(
            fontSize: 20,
            color: Colors.black87,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: ListView(
            children: [
              const SizedBox(
                height: 10,
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  'Code 1',
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: height(context) * 0.021),
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Container(
                width: width(context),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.white,
                  border: Border.all(
                    color: Colors.grey,
                    width: 2,
                  ),
                ),
                child: TextField(
                  controller: _code1,
                  decoration: InputDecoration(
                    hintText: "Code",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  'Code 2',
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: height(context) * 0.021),
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Container(
                width: width(context),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.white,
                  border: Border.all(
                    color: Colors.grey,
                    width: 2,
                  ),
                ),
                child: TextField(
                  controller: _code2,
                  decoration: InputDecoration(
                    hintText: "Code",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  'Code 3',
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: height(context) * 0.021),
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Container(
                width: width(context),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.white,
                  border: Border.all(
                    color: Colors.grey,
                    width: 2,
                  ),
                ),
                child: TextField(
                  controller: _code3,
                  decoration: InputDecoration(
                    hintText: "Code",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  'Code 4',
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: height(context) * 0.021),
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Container(
                width: width(context),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.white,
                  border: Border.all(
                    color: Colors.grey,
                    width: 2,
                  ),
                ),
                child: TextField(
                  controller: _code4,
                  decoration: InputDecoration(
                    hintText: "Code",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  'Code 5',
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: height(context) * 0.021),
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Container(
                width: width(context),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.white,
                  border: Border.all(
                    color: Colors.grey,
                    width: 2,
                  ),
                ),
                child: TextField(
                  controller: _code5,
                  decoration: InputDecoration(
                    hintText: "Code",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  'Code 6',
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: height(context) * 0.021),
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Container(
                width: width(context),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.white,
                  border: Border.all(
                    color: Colors.grey,
                    width: 2,
                  ),
                ),
                child: TextField(
                  controller: _code6,
                  decoration: InputDecoration(
                    hintText: "Code",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  'Code 7',
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: height(context) * 0.021),
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Container(
                width: width(context),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.white,
                  border: Border.all(
                    color: Colors.grey,
                    width: 2,
                  ),
                ),
                child: TextField(
                  controller: _code7,
                  decoration: InputDecoration(
                    hintText: "Code",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  'Code 8',
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: height(context) * 0.021),
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Container(
                width: width(context),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.white,
                  border: Border.all(
                    color: Colors.grey,
                    width: 2,
                  ),
                ),
                child: TextField(
                  controller: _code8,
                  decoration: InputDecoration(
                    hintText: "Code",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  'Code 9',
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: height(context) * 0.021),
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Container(
                width: width(context),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.white,
                  border: Border.all(
                    color: Colors.grey,
                    width: 2,
                  ),
                ),
                child: TextField(
                  controller: _code9,
                  decoration: InputDecoration(
                    hintText: "Code",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  'Code 10',
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: height(context) * 0.021),
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Container(
                width: width(context),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.white,
                  border: Border.all(
                    color: Colors.grey,
                    width: 2,
                  ),
                ),
                child: TextField(
                  controller: _code10,
                  decoration: InputDecoration(
                    hintText: "Code",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  'Nama',
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: height(context) * 0.021),
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Container(
                width: width(context),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.white,
                  border: Border.all(
                    color: Colors.grey,
                    width: 2,
                  ),
                ),
                child: TextField(
                  controller: _name,
                  decoration: InputDecoration(
                    hintText: "Nama",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  'Unit',
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: height(context) * 0.021),
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Container(
                width: width(context),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.white,
                  border: Border.all(
                    color: Colors.grey,
                    width: 2,
                  ),
                ),
                child: TextField(
                  controller: _unit,
                  decoration: InputDecoration(
                    hintText: "PCS",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  'Take Price',
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: height(context) * 0.021),
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Container(
                width: width(context),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.white,
                  border: Border.all(
                    color: Colors.grey,
                    width: 2,
                  ),
                ),
                child: TextField(
                  controller: _takePrice,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: "Take Price",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  'Harga',
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: height(context) * 0.021),
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Container(
                width: width(context),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.white,
                  border: Border.all(
                    color: Colors.grey,
                    width: 2,
                  ),
                ),
                child: TextField(
                  controller: _price,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: "Price",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: InkWell(
                  onTap: () {
                    edit.editItem(id, _code1.text, _name.text, _unit.text,
                        _takePrice.text, _price.text);
                  },
                  child: Container(
                      width: width(context),
                      height: height(context) * 0.050,
                      decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.circular(17)),
                      child: Center(
                          child: edit.isLoading.value == true
                              ? const CircularProgressIndicator()
                              : const Text(
                                  'Edit',
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.white,
                                    // fontWeight: FontWeight.w600,
                                  ),
                                ))),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
