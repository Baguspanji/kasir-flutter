import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:kasir_app/src/config/size_config.dart';
import 'package:kasir_app/src/controller/product_controller.dart';

class TambahBarang extends StatefulWidget {
  static const routeName = '/profile/tambahbarang';
  // const TambahBarang({super.key});

  @override
  State<TambahBarang> createState() => _TambahBarangState();
}

class _TambahBarangState extends State<TambahBarang> {
  TextEditingController code1 = TextEditingController();
  TextEditingController code2 = TextEditingController();
  TextEditingController code3 = TextEditingController();
  TextEditingController code4 = TextEditingController();
  TextEditingController code5 = TextEditingController();
  TextEditingController code6 = TextEditingController();
  TextEditingController code7 = TextEditingController();
  TextEditingController code8 = TextEditingController();
  TextEditingController code9 = TextEditingController();
  TextEditingController code10 = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController deskripsi = TextEditingController();
  TextEditingController unit = TextEditingController();
  TextEditingController takeprice = TextEditingController();
  TextEditingController price = TextEditingController();
  ProductController product = Get.put(ProductController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        centerTitle: true,
        title: const Text(
          "Tambah Barang",
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
                  controller: code1,
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
                  controller: code2,
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
                  controller: code3,
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
                  controller: code4,
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
                  controller: code5,
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
                  controller: code6,
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
                  controller: code7,
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
                  controller: code8,
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
                  controller: code9,
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
                  controller: code10,
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
                  controller: name,
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
                  'Deskripsi',
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
                  controller: deskripsi,
                  decoration: InputDecoration(
                    hintText: "Deskripsi",
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
                  controller: unit,
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
                  controller: takeprice,
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
                  controller: price,
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
                    product.addItem(
                        code1.text,
                        code2.text,
                        code3.text,
                        code4.text,
                        code5.text,
                        code6.text,
                        code7.text,
                        code8.text,
                        code9.text,
                        code10.text,
                        name.text,
                        deskripsi.text,
                        unit.text,
                        takeprice.text, price.text);
                  },
                  child: Container(
                      width: width(context),
                      height: height(context) * 0.050,
                      decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.circular(17)),
                      child: Center(
                          child: product.isLoading.value == true
                              ? const CircularProgressIndicator()
                              : const Text(
                                  'Tambah',
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
