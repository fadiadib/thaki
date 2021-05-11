import 'package:path/path.dart' as path;
import 'package:sqflite/sqflite.dart';
import 'package:mutex/mutex.dart';

class TkDBHelper {
  static Mutex mutex = Mutex();

  /// Insert data into database, takes id, and data
  static Future<void> insertInDatabase(
    String dbName,
    String createCmd,
    String insertCmd,
    String selectCmd,
    int id,
    String data,
  ) async {
    await mutex.acquire();

    try {
      // Get databases path
      var databasesPath = await getDatabasesPath();

      // Open the database
      Database database = await openDatabase(path.join(databasesPath, dbName),
          version: 1, onCreate: (Database db, int version) async {
        await db.execute(createCmd);
      });

      // Check that the entry does not exist
      var search;
      try {
        search = await database.rawQuery(selectCmd + id.toString());
      } finally {}

      if (search == null || search.isEmpty) {
        // Insert the data
        await database.rawInsert(insertCmd + '(\'$id\', \'$data\')');
      }

      // Close the database
      await database.close();
    } finally {
      mutex.release();
    }
  }

  /// Delete a whole database
  static Future<void> deleteDatabase(
      String dbName, String createCmd, String deleteCmd) async {
    await mutex.acquire();

    try {
      // Get databases path
      var databasesPath = await getDatabasesPath();

      // Open the database
      Database database = await openDatabase(path.join(databasesPath, dbName),
          version: 1, onCreate: (Database db, int version) async {
        await db.execute(createCmd);
      });

      // Insert the data
      await database.rawDelete(deleteCmd);

      // Close the database
      await database.close();
    } finally {
      mutex.release();
    }
  }

  /// Delete data from a database using an id
  static Future<void> deleteFromDatabase(
    String dbName,
    String createCmd,
    String deleteCmd,
    int id,
  ) async {
    await mutex.acquire();

    try {
      // Get databases path
      var databasesPath = await getDatabasesPath();

      // Open the database
      Database database = await openDatabase(path.join(databasesPath, dbName),
          version: 1, onCreate: (Database db, int version) async {
        await db.execute(createCmd);
      });

      // Insert the data
      await database.rawDelete(deleteCmd + id.toString());

      // Close the database
      await database.close();
    } finally {
      mutex.release();
    }
  }

  /// Read from a database
  static Future<List<Map<String, dynamic>>> readFromDatabase(
    String dbName,
    String createCmd,
    String selectCmd,
  ) async {
    // Get databases path
    var databasesPath = await getDatabasesPath();

    // Open the database
    Database database = await openDatabase(path.join(databasesPath, dbName),
        version: 1, onCreate: (Database db, int version) async {
      await db.execute(createCmd);
    });

    // Insert the data
    List<Map<String, dynamic>> result = await database.rawQuery(selectCmd);

    // Close the database
    await database.close();

    return result;
  }
}
