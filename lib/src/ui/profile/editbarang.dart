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
  var code = Get.arguments[1];
  var name = Get.arguments[2];
  var unit = Get.arguments[3];
  var takePrice = Get.arguments[4];
  var price = Get.arguments[5];
  late TextEditingController _code;
  late TextEditingController _name;
  late TextEditingController _unit;
  late TextEditingController _takePrice;
  late TextEditingController _price;
  ProductController edit = Get.put(ProductController());
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _code = TextEditingController(text: code);
    _name = TextEditingController(text: name);
    _unit = TextEditingController(text: unit);
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
          child: Column(
            children: [
              const SizedBox(
                height: 10,
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
                  controller: _code,
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
              const Spacer(),
              Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: InkWell(
                  onTap: () {
                    edit.editItem(id, _code.text, _name.text, _unit.text,
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
