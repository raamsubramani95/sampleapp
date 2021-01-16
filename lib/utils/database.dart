import 'dart:io';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:teamemployees/models/employees_object.dart';
import 'package:teamemployees/models/team_object.dart';

class DB {
  static final DB db = DB();
  static Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;

    _database = await initDB();
//    _database = await initDB2();
    return _database;
  }

  Future<Database> initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "Team.db");
    return await openDatabase(path, version: 1, onOpen: (db) {},
        onCreate: (Database db, int version) async {
          await db.execute("CREATE TABLE Team("
              "team_id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,"
              "team_name TEXT"
              "team_lead TEXT"
              ")");
          await db.execute("CREATE TABLE Employees("
              "id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,"
              "name TEXT,"
              "age TEXT,"
              "city TEXT,"
              "teamlead TEXT,"
              "team TEXT"
              ")");
        });
  }

  addteam(Team newTeam) async {
    final db = await database;
    var raw = await db.rawInsert(
        "INSERT Into Team (team_name)"
            " VALUES (?)",
        [
          newTeam.team_name,
        ]);
    return raw;
  }
  getteam() async {
    final db = await database;
    var teamlist = await db.rawQuery("SELECT * FROM Team");
    return teamlist;
  }
  deleteteamr(int id) async {
    final db = await database;
    return db.delete("Team", where: "team_id = ?", whereArgs: [id]);
  }



  addemploy(Employees newEmployees) async {
    final db = await database;
    var raw = await db.rawInsert(
        "INSERT Into Employees (name,age,city,team,teamlead)"
            " VALUES (?,?,?,?,?)",
        [
          newEmployees.name,
          newEmployees.age,
          newEmployees.city,
          newEmployees.team,
          newEmployees.teamlead,
        ]);
    return raw;
  }
  getemploy() async {
    final db = await database;
    var emlpoyeeslist = await db.rawQuery("SELECT * FROM Employees");
    return emlpoyeeslist;
  }
  deleteemploy(int id) async {
    final db = await database;
    return db.delete("Employees", where: "id = ?", whereArgs: [id]);
  }
}