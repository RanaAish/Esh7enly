// ignore_for_file: camel_case_types, unused_import, prefer_const_declarations, unused_local_variable, depend_on_referenced_packages

import 'package:esh7enly/models/category.dart';
import 'package:esh7enly/models/provider.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../models/services.dart';

class categoryDatabase {
  static final categoryDatabase instance = categoryDatabase._init();

  static Database? _database;

  categoryDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('categories.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    final idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    final textType = 'TEXT';
    final boolType = 'BOOLEAN';
    final integerType = 'INTEGER';

    await db.execute('''
CREATE TABLE $tablecategories ( 
  ${Categorymodel.id} $idType, 
  ${Categorymodel.name_ar} $textType,
  ${Categorymodel.name_en} $textType,
  ${Categorymodel.description_ar} $textType,
  ${Categorymodel.description_en} $textType,
  ${Categorymodel.logo} $textType,
  ${Categorymodel.sort} $integerType
  )
''');
  }

  Future<Category> create(Category note) async {
    final db = await instance.database;
    final id = await db.insert(tablecategories, note.toJson());
    return note.copy();
  }

  Future<Category> readNote(int id) async {
    final db = await instance.database;

    final maps = await db.query(
      tablecategories,
      columns: Categorymodel.values,
      where: '${Categorymodel.id} = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return Category.fromJson(maps.first);
    } else {
      throw Exception('ID $id not found');
    }
  }

  Future<List<Category>> readAllNotes() async {
    final db = await instance.database;

    // final orderBy = '${ProviderFields.name_ar} ASC';
    // final result =
    //     await db.rawQuery('SELECT * FROM $tableNotes ORDER BY $orderBy');

    final result = await db.query(tablecategories);

    return result.map((json) => Category.fromJson(json)).toList();
  }

  Future close() async {
    final db = await instance.database;

    db.close();
  }

  Future<bool> getcount() async {
    final db = await instance.database;
    final result = await db.query(tablecategories);
    if (result.map((json) => Category.fromJson(json)).toList().isEmpty) {
      return true;
    } else {
      return false;
    }
  }
 
}
