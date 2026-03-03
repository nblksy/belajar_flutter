import 'package:belajar_flutter/day15/database/sqflite.dart';
import 'package:belajar_flutter/tugas_11/models/order_model.dart';

class OrderController {
  static Future<int> insertOrder(OrderModel order) async {
    final dbs = await DBHelper.db();
    return await dbs.insert('orders', order.toMap());
  }

  static Future<List<OrderModel>> getOrders() async {
    final dbs = await DBHelper.db();
    final List<Map<String, dynamic>> maps = await dbs.query('orders');
    return maps.map((e) => OrderModel.fromMap(e)).toList();
  }

  static Future<int> updateOrder(OrderModel order) async {
    final dbs = await DBHelper.db();

    if (order.id == null) {
      throw Exception("ID wajib ada untuk update");
    }

    return await dbs.update(
      'orders',
      order.toMap(),
      where: 'id = ?',
      whereArgs: [order.id],
    );
  }

  static Future<int> deleteOrder(int id) async {
    final dbs = await DBHelper.db();

    return await dbs.delete('orders', where: 'id = ?', whereArgs: [id]);
  }
}
