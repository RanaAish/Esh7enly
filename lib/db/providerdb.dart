// ignore_for_file: depend_on_referenced_packages, prefer_const_declarations, unused_local_variable

import 'package:esh7enly/models/provider.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';



class ProviderDatabase {
  static final ProviderDatabase instance = ProviderDatabase._init();

  static Database? _database;

  ProviderDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('PROVIDERS.db');
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
CREATE TABLE $tableproviders ( 
  ${ProviderFields.id} $idType, 
  ${ProviderFields.category_id} $integerType, 
  ${ProviderFields.name_ar} $textType,
  ${ProviderFields.name_en} $textType,
  ${ProviderFields.description_ar} $textType,
  ${ProviderFields.description_en} $textType,
  ${ProviderFields.logo} $textType,
  ${ProviderFields.sort} $integerType
  )
''');
  }

  Future<Provider> create(Provider note) async {
    final db = await instance.database;
    final id = await db.insert(tableproviders, note.toJson());
    return note.copy();
  }

  Future<Provider> readNote(int id) async {
    final db = await instance.database;

    final maps = await db.query(
      tableproviders,
      columns: ProviderFields.values,
      where: '${ProviderFields.id} = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return Provider.fromJson(maps.first);
    } else {
      throw Exception('ID $id not found');
    }
  }

  Future<List<Provider>> readAllNotes() async {
    final db = await instance.database;

    // final orderBy = '${ProviderFields.name_ar} ASC';
    // final result =
    //     await db.rawQuery('SELECT * FROM $tableNotes ORDER BY $orderBy');

    final result = await db.query(tableproviders);

    return result.map((json) => Provider.fromJson(json)).toList();
  }

  Future close() async {
    final db = await instance.database;

    db.close();
  }

  Future<bool> getcount() async {
    final db = await instance.database;
    final result = await db.query(tableproviders);
    if (result.map((json) => Provider.fromJson(json)).toList().isEmpty) {
      return true;
    } else {
      return false;
    }
  }
}
