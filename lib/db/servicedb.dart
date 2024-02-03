// ignore_for_file: unused_import, depend_on_referenced_packages, prefer_const_declarations, unused_local_variable

import 'package:esh7enly/models/provider.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:esh7enly/models/parameters.dart';
import '../models/services.dart';

class ServiceDatabase {
  static final ServiceDatabase instance = ServiceDatabase._init();

  static Database? _database;

  ServiceDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('SERVICES.db');
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
    final list = 'LIST';

    await db.execute('''
CREATE TABLE $tableservices ( 
   ${ServiveFields.id} $idType, 
   ${ServiveFields.provider_id} $integerType, 
   ${ServiveFields.name_ar} $textType,
   ${ServiveFields.name_en} $textType,
   ${ServiveFields.description_ar} $textType,
   ${ServiveFields.description_en} $textType,
   ${ServiveFields.logo} $textType,
   ${ServiveFields.sort} $integerType,
   ${ServiveFields.powered_by_ar} $textType,
   ${ServiveFields.powered_by_en} $textType,
   ${ServiveFields.icon} $textType,
   ${ServiveFields.price_value} $textType,
   ${ServiveFields.price_value_list} $textType,
   ${ServiveFields.price_min_value} $textType,
   ${ServiveFields.price_max_value} $textType,
   ${ServiveFields.type_code} $textType,
   ${ServiveFields.accept_amount_input} $integerType, 
   ${ServiveFields.accept_change_paid_amount} $integerType, 
   ${ServiveFields.accept_check_integration_provider_status} $integerType, 
   ${ServiveFields.price_type} $integerType,
    ${ServiveFields.type} $integerType
  )
''');
    await db.execute('''
CREATE TABLE $tableparametrs ( 
   ${parametersFields.id} $idType, 
   ${parametersFields.service_id} $integerType, 
   ${parametersFields.name_ar} $textType,
   ${parametersFields.name_en} $textType,
   ${parametersFields.internal_id} $textType,
   ${parametersFields.sort} $integerType,
   ${parametersFields.type} $integerType,
   ${parametersFields.display} $integerType,
   ${parametersFields.max_length} $integerType,
   ${parametersFields.min_length} $integerType,
   ${parametersFields.required} $integerType,
   ${parametersFields.type_values} $textType,
   ${parametersFields.is_client_number} $integerType
  )
''');
  }

  Future<Services> createservice(Services service) async {
    final db = await instance.database;

    final id = await db.insert(tableservices, service.toJson());
    return service.copy(); //id: id
  }

  Future<parameters> createparameter(parameters parameter) async {
    final db = await instance.database;

    //final id = 
    await db.insert(tableparametrs, parameter.toJson());
    return parameter.copy(); //id: id
  }

  Future<List<Services>> readAllservices() async {
    final db = await instance.database;

    // final orderBy = '${ProviderFields.name_ar} ASC';
    // final result =
    //     await db.rawQuery('SELECT * FROM $tableNotes ORDER BY $orderBy');

    final result = await db.query(tableservices);

    return result.map((json) => Services.fromJson(json)).toList();
  }

  Future<List<parameters>> readAllparameters() async {
    final db = await instance.database;

    final result = await db.query(tableparametrs);

    return result.map((json) => parameters.fromJson(json, 1)).toList();
  }

  Future close() async {
    final db = await instance.database;

    db.close();
  }

  Future<bool> getcountservice() async {
    final db = await instance.database;
    final result = await db.query(tableservices);
    if (result.map((json) => Services.fromJson(json)).toList().isEmpty) {
      return true;
    } else {
      return false;
    }
  }
}
