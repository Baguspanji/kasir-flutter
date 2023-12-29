import 'package:sqflite/sqflite.dart';

String tableCart = 'cart';
String columnId = '_id';
String columnName = 'name';
String columnPrice = 'price';
String columnQty = 'qty';
String columnUnit = 'unit';

class CartDBModel {
  int? id;
  String? name;
  int? price;
  int? qty;
  String? unit;

  Map<String, Object?> toMap() {
    var map = <String, Object?>{
      columnName: name,
      columnPrice: price,
      columnQty: qty,
      columnUnit: unit,
    };

    if (id != null) {
      map[columnId] = id;
    }

    return map;
  }

  CartDBModel();

  CartDBModel.fromMap(Map<dynamic, dynamic> map) {
    id = map[columnId];
    name = map[columnName];
    price = map[columnPrice];
    qty = map[columnQty];
    unit = map[columnUnit];
  }
}

class CartDB {
  Database? db;

  Future open() async {
    var databasesPath = await getDatabasesPath();
    String path = databasesPath + 'cart.db';
    // print(path);

    db = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      await db.execute('''
        create table $tableCart ( 
          $columnId integer primary key autoincrement, 
          $columnName text not null,
          $columnPrice integer not null,
          $columnQty integer not null,
          $columnUnit text not null)
        ''');
    });
  }

  Future<List<CartDBModel>> getCartAll() async {
    List<Map> maps = await db!.query(
      tableCart,
      columns: [columnId, columnName, columnPrice, columnQty, columnUnit],
    );

    return maps.length > 0 ? [...maps.map((e) => CartDBModel.fromMap(e))] : [];
  }

  Future<CartDBModel> getCart(int id) async {
    List<Map> maps = await db!.query(tableCart,
        columns: [columnId, columnName, columnPrice, columnQty, columnUnit],
        where: '$columnId = ?',
        whereArgs: [id]);

    return maps.length > 0
        ? CartDBModel.fromMap(maps.first)
        : CartDBModel.fromMap({});
  }

  Future<int> getCountCart() async {
    List<Map> maps = await db!.query(tableCart, columns: ['COUNT(*)']);
    print(maps);

    return 0;
  }

  Future<CartDBModel> insert(CartDBModel cart) async {
    cart.id = await db!.insert(tableCart, cart.toMap());
    return cart;
  }

  Future<int> update(CartDBModel cart) async {
    return await db!.update(tableCart, cart.toMap(),
        where: '$columnId = ?', whereArgs: [cart.id]);
  }

  Future<int> delete(int id) async {
    return await db!.delete(tableCart, where: '$columnId = ?', whereArgs: [id]);
  }

  Future<int> deleteAll() async {
    return await db!.delete(tableCart);
  }

  Future close() async => db!.close();
}
