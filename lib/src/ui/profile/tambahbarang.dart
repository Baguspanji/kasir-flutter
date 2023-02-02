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
  TextEditingController code = TextEditingController();
  TextEditingController name = TextEditingController();
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
                  controller: code,
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
              const Spacer(),
              Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: InkWell(
                  onTap: () {
                    product.addItem(code.text, name.text, unit.text,
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
