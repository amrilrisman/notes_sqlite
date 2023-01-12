import 'package:notes_app_sqflite/models/notes_models.dart';
import 'package:sqflite/sqflite.dart';

class DataBaseService {
  /// variabel untuk initial objeck kelas ini
  static DataBaseService? _instance;
  Database? _database;
  static const String _nameTable = "my_notes";

  // initial objek pada kelas ini
  DataBaseService.initialized() {
    _instance = this;
  }
  factory DataBaseService() => _instance ?? DataBaseService.initialized();

  // initialized pada databases

  Future<Database?> _createDatabase() async {
    try {
      var pathDB = await getDatabasesPath();
      var createDB = openDatabase(
        pathDB,
        version: 1,
        onCreate: (db, version) async {
          await db.execute(
            '''CREATE TABLE $_nameTable (id INTEGER PRIMARY KEY, title TEXT, description TEXT)''',
          );
        },
      );
      return createDB;
    } catch (e) {
      print('database error ');
      return null;
    }
  }

  Future<Database?> get createDataBase async => _createDatabase();

  // insert database
  Future<bool> post(NoteModels data) async {
    try {
      final db = await createDataBase;
      await db!.insert(_nameTable, data.toJson());
      return true;
    } catch (e) {
      print('Gagal menambahkan data');
      return false;
    }
  }

  // get data from database
  Future<List<NoteModels>> get() async {
    try {
      final db = await createDataBase;
      // mengambil row pada database
      final List<Map<String, Object?>> data = await db!.query(_nameTable);
      print(data);
      return data.map((e) => NoteModels.fromJson(e)).toList();
    } catch (e) {
      return [];
    }
  }

  Future<NoteModels> getByID({required int id}) async {
    try {
      final db = await createDataBase;
      final List<Map<String, dynamic>> data =
          await db!.query(_nameTable, where: 'id=?', whereArgs: [id]);
      print(data);
      print(data);
      return data.map((e) => NoteModels.fromJson(e)).first;
    } catch (e) {
      print('gagal mengambil detail data');
      return NoteModels.fromJson({});
    }
  }

  // update data at database
  Future<bool> put(NoteModels note) async {
    print(note.id);
    try {
      final db = await createDataBase;
      await db!.update(
        _nameTable,
        note.toJson(),
        where: 'id=?',
        whereArgs: [note.id],
      );
      return true;
    } catch (e) {
      print('Gagal Update Data');
      return false;
    }
  }

  // delete data from database by id
  Future<bool> delete({required int id}) async {
    try {
      final db = await createDataBase;
      await db!.delete(
        _nameTable,
        where: "id=?",
        whereArgs: [id],
      );

      return true;
    } catch (e) {
      print('gagal Delet Data');
      return false;
    }
  }
}
