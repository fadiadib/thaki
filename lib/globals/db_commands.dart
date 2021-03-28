/// Notifications database
// Table and columns
const String kNtfTableName = 'notifications';
const String kNtfIDColumnName = 'nid';
const String kNtfDataColumnName = 'json';

// Commands
const String kCreateNtfDBCmd =
    'CREATE TABLE $kNtfTableName (id INTEGER PRIMARY KEY AUTOINCREMENT, $kNtfIDColumnName INTEGER, $kNtfDataColumnName TEXT)';
const String kInsertNtfDBCmd =
    'INSERT INTO $kNtfTableName ($kNtfIDColumnName, $kNtfDataColumnName) VALUES ';
const String kDeleteNtfDBCmd =
    'DELETE FROM $kNtfTableName WHERE $kNtfIDColumnName=';
const String kDeleteAllNtfDBCmd = 'DELETE FROM $kNtfTableName';
const String kSelectBtfDBCmd = 'SELECT $kNtfDataColumnName FROM $kNtfTableName';
const String kSelectIdNtfDBCmd =
    'SELECT $kNtfDataColumnName FROM $kNtfTableName WHERE $kNtfIDColumnName=';
