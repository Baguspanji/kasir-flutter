import 'package:flutter/material.dart';
import 'package:kasir_app/src/config/size_config.dart';
import 'package:kasir_app/src/model/cart_db_model.dart';
import 'package:kasir_app/src/repository/cart_db.dart';

class HomeUI2 extends StatefulWidget {
  @override
  State<HomeUI2> createState() => _HomeUI2State();
}

class _HomeUI2State extends State<HomeUI2> {
  DbHelper dbHelper = DbHelper();
  int count = 0;
  List<CartDBModel> cartList = [];

  @override
  void initState() {
    getCart();
    super.initState();
  }

  getCart() async {
    cartList = await dbHelper.getCartList();

    if (cartList.isEmpty) {
      addCart();
    }
    setState(() {
      count = cartList.length;
    });
  }

  addCart() async {
    dbHelper.insertCart(CartDBModel.fromMap({
      'name': '',
      'bill_amount': 0,
    }));
    getCart();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          SizedBox(height: height(context) * 0.01),
          Container(
            width: width(context),
            height: height(context) * 0.04,
            margin: EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Daftar Keranjang',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.black87,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Spacer(),
                GestureDetector(
                  onTap: () => addCart(),
                  child: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Icon(
                      Icons.add,
                      color: Colors.black87,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: height(context) * 0.02),
          Expanded(
            child: Container(
              width: width(context),
              height: height(context),
              margin: EdgeInsets.symmetric(horizontal: 20),
              child: FutureBuilder(
                future: dbHelper.getCartList(),
                builder: (context, AsyncSnapshot<List<CartDBModel>> snapshot) {
                  if (snapshot.hasData) {
                    cartList = snapshot.data!;
                    count = cartList.length;
                    return ListView.builder(
                      itemCount: count,
                      itemBuilder: (context, index) {
                        return Container(
                          width: width(context),
                          padding: EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 10,
                          ),
                          margin: EdgeInsets.only(bottom: 10),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.2),
                                spreadRadius: 1,
                                blurRadius: 5,
                                offset: Offset(0, 3),
                              ),
                            ],
                          ),
                          child: Row(
                            children: [
                              Text('Keranjang ${index + 1}'),
                              Spacer(),
                              GestureDetector(
                                onTap: () {
                                  dbHelper.deleteCart(cartList[index].id!);
                                  getCart();
                                },
                                child: Container(
                                  width: 20,
                                  height: 20,
                                  decoration: BoxDecoration(
                                    color: Colors.grey.withOpacity(0.2),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Icon(
                                    Icons.delete,
                                    color: Colors.red,
                                    size: 15,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  } else {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
