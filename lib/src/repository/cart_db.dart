import 'package:kasir_app/src/model/cart_db_model.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';
//mendukug pemrograman asinkron
import 'dart:io';
//bekerja pada file dan directory
import 'package:path_provider/path_provider.dart';
//pubspec.yml

//kelass Dbhelper
class DbHelper {
  static DbHelper? _dbHelper;
  static Database? _database;

  DbHelper._createObject();

  factory DbHelper() {
    if (_dbHelper == null) {
      _dbHelper = DbHelper._createObject();
    }
    return _dbHelper!;
  }

  Future<Database> initDb() async {
    //untuk menentukan nama database dan lokasi yg dibuat
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + 'cart.db';

    //create, read databases
    var todoDatabase = openDatabase(path, version: 1, onCreate: _createDb);

    //mengembalikan nilai object sebagai hasil dari fungsinya
    return todoDatabase;
  }

  //buat tabel baru dengan nama cart
  Future<void> _createDb(Database db, int version) async {
    await db.execute('DROP TABLE IF EXISTS carts');
    await db.execute(
        'CREATE TABLE carts (id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, bill_amount INTEGER)');

    await db.execute('DROP TABLE IF EXISTS cart_details');
    await db.execute(
        'CREATE TABLE cart_details (id INTEGER PRIMARY KEY AUTOINCREMENT, cart_id INTEGER, product_id INTEGER, price INTEGER, quantity INTEGER, product_name STRING, product_unit STRING, FOREIGN KEY (cart_id) REFERENCES carts(id))');
  }

  Future<Database> get database async {
    if (_database == null) {
      _database = await initDb();
    }
    return _database!;
  }

  Future<List<Map<String, dynamic>>> selectCart() async {
    Database db = await this.database;
    var mapList = await db.query('carts', orderBy: 'id');
    return mapList;
  }

//create databases
  Future<int> insertCart(CartDBModel object) async {
    Database db = await this.database;
    int count = await db.insert('carts', object.toMap());
    return count;
  }

//update databases
  Future<int> updateCart(CartDBModel object) async {
    Database db = await this.database;
    int count = await db
        .update('carts', object.toMap(), where: 'id=?', whereArgs: [object.id]);
    return count;
  }

//delete databases
  Future<int> deleteCart(int id) async {
    Database db = await this.database;
    await db.delete('cart_details', where: 'cart_id=?', whereArgs: [id]);
    int count = await db.delete('carts', where: 'id=?', whereArgs: [id]);
    return count;
  }

  // truncate cart
  Future<void> truncateCart() async {
    Database db = await this.database;
    await db.delete('cart_details');
    await db.delete('carts');

    await db.execute('DROP TABLE carts');
    await db.execute('DROP TABLE cart_details');
    await db.execute(
        'CREATE TABLE carts (id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, bill_amount INTEGER)');
    await db.execute(
        'CREATE TABLE cart_details (id INTEGER PRIMARY KEY AUTOINCREMENT, cart_id INTEGER, product_id INTEGER, price INTEGER, quantity INTEGER, product_name STRING, product_unit STRING, FOREIGN KEY (cart_id) REFERENCES carts(id))');
  }

  Future<List<CartDBModel>> getCartList() async {
    var cartMapList = await selectCart();
    int count = cartMapList.length;
    List<CartDBModel> cartList = [];
    for (int i = 0; i < count; i++) {
      cartList.add(CartDBModel.fromMap(cartMapList[i]));
    }
    return cartList;
  }

  Future<List<Map<String, dynamic>>> selectCartDetail(int cart_id) async {
    Database db = await this.database;
    var mapList = await db.query(
      'cart_details',
      orderBy: 'id',
      where: 'cart_id=?',
      whereArgs: [cart_id],
    );
    return mapList;
  }

  //create databases
  Future<int> insertCartDetail(CartDetailDBModel object) async {
    Database db = await this.database;
    int count = await db.insert('cart_details', object.toMap());
    return count;
  }

  //update databases
  Future<int> updateCartDetail(CartDetailDBModel object) async {
    Database db = await this.database;
    int count = await db.update('cart_details', object.toMap(),
        where: 'id=?', whereArgs: [object.id]);
    return count;
  }

  //delete databases
  Future<int> deleteCartDetail(int id) async {
    Database db = await this.database;
    int count = await db.delete('cart_details', where: 'id=?', whereArgs: [id]);
    return count;
  }

  // delete cart detail by cart id
  Future<int> deleteCartDetailByCartId(int cart_id) async {
    Database db = await this.database;
    int count = await db
        .delete('cart_details', where: 'cart_id=?', whereArgs: [cart_id]);
    return count;
  }

  Future<List<CartDetailDBModel>> getCartDetailList(int cart_id) async {
    var cartMapList = await selectCartDetail(cart_id);
    int count = cartMapList.length;
    List<CartDetailDBModel> cartList = [];
    for (int i = 0; i < count; i++) {
      cartList.add(CartDetailDBModel.fromMap(cartMapList[i]));
    }
    return cartList;
  }
}
