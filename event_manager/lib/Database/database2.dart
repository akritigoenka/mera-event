import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import 'event item class.dart';


class DatabaseHelper{
  static final DatabaseHelper _instance =new DatabaseHelper.internal();
  final String eventtable="eventTable";
  final String columnId = 'id';
  final String columnEventName = 'EventName';
  final String columnEventBudget ='EventBudget';
  final String columnEventTicketedflag='flag';
  final String columnInvitedPeople='InvitedPeople';
  final String columnDateday='day';
  final String columnDatemonth="month";
  final String columnDateyear='year';
  final String columnTicketPrice='TicketPrice';


  final String peopletable='peopletable';
  final String columneventId='eventid';
//  final String columnId = 'id';
  final String columnname='Name';
  final String columnplus='plus';
  final String columncontactno='ContactNo';
  final String columnamountpaid='AmountPaid';
  final String columnconfirmationflag='Confirmationflag';
  final String columnpaidflag='Paidflag';
  final String columnreceivedflag='Receivedflag';

  final String todotable='todotable';
  final String todoitem="todoitem";

  final String expensetable='expensetable';
  final String cost="cost";
  final String columnspenton='spenton';

  factory DatabaseHelper()=>_instance;
  static Database _db;

  Future<Database> get db async{
    if(_db!=null){
      return _db;
    }
    _db=await initDb();

    return _db;
  }
  DatabaseHelper.internal();

  initDb() async{
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path= join(documentDirectory.path,'qwdb.db');

    var ourdb = await openDatabase(path, version :2, onCreate: _onCreate);
    return ourdb;
  }

  void _onCreate(Database db, int newVersion) async {
    await db.execute(
        "CREATE TABLE IF NOT EXISTS $eventtable("
            "$columnId INTEGER PRIMARY KEY,"
            "$columnEventName TEXT,"
            "$columnEventBudget REAL,"
            "$columnTicketPrice REAL,"
            "$columnDateday INTEGER,"
            "$columnDatemonth INTEGER,"
            "$columnDateyear INTEGER,"
            "$columnEventTicketedflag INTEGER)"
    );

    await db.execute(
        "CREATE TABLE IF NOT EXISTS $peopletable("
            "$columnId INTEGER PRIMARY KEY,"
            "$columneventId INTEGER,"
            "$columnplus INTEGER,"
            "$columnname TEXT,"
            "$columncontactno INTEGER,"
            "$columnamountpaid REAL,"
            "$columnconfirmationflag INTEGER,"
            "$columnpaidflag INTEGER,"
            "$columnreceivedflag INTEGER)"
    );

    await db.execute(
        "CREATE TABLE IF NOT EXISTS $todotable("
            "$columnId INTEGER PRIMARY KEY,"
            "$columneventId INTEGER,"
            "$todoitem TEXT"
        ")"
    );

    await db.execute(
        "CREATE TABLE IF NOT EXISTS $expensetable("
            "$columnId INTEGER PRIMARY KEY,"
            "$columneventId INTEGER,"
            "$cost REAL,"
            "$columnspenton TEXT"
            ")"
    );
    //CRUD - create , read, update, delete
  }
  Future<int> saveEvent(MyEventItems myevent)async{
     var dbClient = await db;
     int res = await dbClient.insert("$eventtable",myevent.toMap());
     return res;
  }

  Future<int> saveInvitee(people invitee)async{
    var dbClient = await db;
    int res = await dbClient.insert("$peopletable",invitee.toMap());
    return res;
  }

  Future<int> saveItem(todo item)async{
    var dbClient = await db;
    int res = await dbClient.insert("$todotable",item.toMap());
    return res;
  }

  Future<int> saveExpense(expenses expense)async{
    var dbClient = await db;
    int res = await dbClient.insert("$expensetable",expense.toMap());
    return res;
  }

  Future<List> getAllEvents() async{
    var dbClient=await db;
    var result=await dbClient.rawQuery("SELECT *FROM $eventtable");
    return result.toList();
  }

  Future<List> getAllInvitees(int eventid) async{
    var dbClient=await db;
    var result=await dbClient.rawQuery("SELECT *FROM $peopletable WHERE $columneventId = $eventid");
    return result.toList();
  }

  Future<List> getAllItems(int eventid) async{
    var dbClient=await db;
    var result=await dbClient.rawQuery("SELECT *FROM $todotable WHERE $columneventId = $eventid");
    return result.toList();
  }

  Future<List> getAllexpenses(int eventid) async{
    var dbClient=await db;
    var result=await dbClient.rawQuery("SELECT *FROM $expensetable WHERE $columneventId = $eventid");
    return result.toList();
  }

//  Future<int> getEventCount() async{
//    var dbClient= await db;
//    return Sqflite.firstIntValue(await dbClient.rawQuery("SELECT COUNT(*) FROM $eventtable")
//    );
//  }
//
//  Future<int> getPeopleCount() async{
//    var dbClient= await db;
//    return Sqflite.firstIntValue(await dbClient.rawQuery("SELECT COUNT(*) FROM $peopletable")
//    );
//  }
//
//  Future<int> getitemCount() async{
//    var dbClient= await db;
//    return Sqflite.firstIntValue(await dbClient.rawQuery("SELECT COUNT(*) FROM $todotable")
//    );
//  }
//
  Future<int> getexpenseSum(MyEventItems event) async{
    var dbClient= await db;
    return Sqflite.firstIntValue(await dbClient.rawQuery(
        "SELECT $cost "
            "SUM($cost) "
            "FROM $expensetable "
            "GROUPBY $columneventId "
            ));
  }


  Future<MyEventItems> getEvent(int id) async{
    var dbClient= await db;
    var result = await dbClient.rawQuery(
      "SELECT * FROM $eventtable WHERE $columnId = $id"
    );
    if(result.length==0)return null;
    return new MyEventItems.fromMap(result.first);
  }

  Future<List> getalleventdates() async{
    var dbClient= await db;
    var result= await dbClient.rawQuery(
        "SELECT $columnEventName, $columnDateday, $columnDatemonth, $columnDateyear FROM $eventtable"
    );
    return result;
  }

  Future<people> getPerson(int id,int eventid) async{
    var dbClient= await db;
    var result = await dbClient.rawQuery(
        "SELECT * FROM $peopletable WHERE $columnId = $id AND $columneventId = $eventid"
    );
    if(result.length==0)return null;
    return new people.fromMap(result.first);
  }

  Future<people> getItem(int id,int eventid) async{
    var dbClient= await db;
    var result = await dbClient.rawQuery(
        "SELECT * FROM $todotable WHERE $columnId = $id AND $columneventId = $eventid"
    );
    if(result.length==0)return null;
    return new people.fromMap(result.first);
  }

   Future deleteEvent(int id) async{
     var dbClient= await db;
     return await dbClient.delete(eventtable,where: "$columnId = ?", whereArgs: [id]);
   }

  Future deletePerson(int id) async{
    var dbClient= await db;
    return await dbClient.delete(peopletable,where: "$columnId = ?", whereArgs: [id]);
//    return await dbClient.rawQuery(
//        "DELETE FROM $peopletable WHERE $columnId = $id AND $columneventId = $eventid"
//    );
  }
  Future deleteItem(int id) async{
    var dbClient= await db;
    return await dbClient.delete(todotable,where: "$columnId = ?", whereArgs: [id]);
//    );
  }

  Future deleteExpense(int id) async{
    var dbClient= await db;
    return await dbClient.delete(expensetable,where: "$columnId = ?", whereArgs: [id]);
//    );
  }

  Future<int> updateEvent(MyEventItems myevent) async{
    var dbClient =await db;
    return await dbClient.update(eventtable, myevent.toMap(), where: "$columnId = ?", whereArgs: [myevent.id]);
  }

  Future<int> updatePerson(people person) async{
    var dbClient =await db;
    return await dbClient.update(peopletable, person.toMap(), where: "$columnId = ?", whereArgs: [person.id]);
  }

  Future<int> updateItem(todo item) async{
    var dbClient =await db;
    return await dbClient.update(todotable, item.toMap(), where: "$columnId = ?", whereArgs: [item.id]);
  }

  Future<int> updateExpense(expenses expense) async{
    var dbClient =await db;
    return await dbClient.update(todotable, expense.toMap(), where: "$columnId = ?", whereArgs: [expense.id]);
  }

  Future close() async {
    var dbClient= await db;
    return dbClient.close();
  }

  Future dropeventtable() async{
    var dbClient= await db;
    await dbClient.rawQuery(
        "DROP TABLE $eventtable"
    );
    print("event table dropped");
  }
  Future dropepeopletable() async{
    var dbClient= await db;
    await dbClient.rawQuery(
        "DROP TABLE $peopletable"
    );
    print("people table dropped");
  }
}