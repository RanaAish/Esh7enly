
// ignore_for_file: prefer_const_declarations, unused_local_variable, non_constant_identifier_names, depend_on_referenced_packages

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import '../models/Image.dart';

class ImageDatabase {
  static final ImageDatabase instance = ImageDatabase._init();

  static Database? _database;

  ImageDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('IMAGESlist.db');
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
CREATE TABLE $tableimages ( 
  ${ImagesFields.path} $textType, 
  ${ImagesFields.service_id} $integerType
  )
''');
  }

  Future<Imageparameters> createimage(Imageparameters IMAGE) async {
    final db = await instance.database;
    final id = await db.insert(tableimages, IMAGE.toJson());
    return IMAGE.copy();
  }

  Future<List<Imageparameters>> readAllimages() async {
    final db = await instance.database;

    // final orderBy = '${ProviderFields.name_ar} ASC';
    // final result =
    //     await db.rawQuery('SELECT * FROM $tableNotes ORDER BY $orderBy');

    final result = await db.query(tableimages);

    return result.map((json) => Imageparameters.fromJson(json)).toList();
  }

  Future close() async {
    final db = await instance.database;

    db.close();
  }

  Future<bool> getcount() async {
    final db = await instance.database;
    final result = await db.query(tableimages);
    if (result.map((json) => Imageparameters.fromJson(json)).toList().isEmpty) {
      return true;
    } else {
      return false;
    }
  }
}
