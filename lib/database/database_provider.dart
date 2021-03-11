import 'package:Advice/model/model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseProvider {
  static const String TABLE_QUOTES = "quoteTable";
  static const String COLUMN_ID = "id";
  static const String COLUMN_QUOTE = "quote";
  static const String COLUMN_AUTHOR = "author";
  //static const String COLUMN_CATEGORY = "category";

  DatabaseProvider._();
  static final DatabaseProvider db = DatabaseProvider._();

  Database _database;

  Future<Database> get database async {
    if (_database != null) {
      return _database;
    }
    _database = await createDatabase();

    return _database;
  }

  Future<Database> createDatabase() async {
    String dbPath = await getDatabasesPath();

    return await openDatabase(join(dbPath, "quoteTableDB.db"), version: 1,
        onCreate: (Database database, int version) async {
      await database.execute(
          "CREATE TABLE $TABLE_QUOTES($COLUMN_ID INTEGER PRIMARY KEY, $COLUMN_QUOTE TEXT, $COLUMN_AUTHOR TEXT)"); //$COLUMN_CATEGORY TEXT)");
    }
    );
  }

  Future<List<Quote>> getQuotes() async {
    final db = await database;

    var quoteses = await db.query(
      TABLE_QUOTES,
      columns: [COLUMN_ID, COLUMN_QUOTE, COLUMN_AUTHOR] //COLUMN_CATEGORY]
    );

    List<Quote> listQuotes = List<Quote>();

    quoteses.forEach((currentQuote) { 
      Quote quote = Quote.fromMap(currentQuote);
      listQuotes.add(quote);
    });
    return listQuotes;

  }
  Future<Quote> insert(Quote quote) async {
    final db = await database;
    quote.id = await db.insert(TABLE_QUOTES, quote.toMap());
    return quote;
  }

  Future<int>delete(int id) async {
    final db = await database;

    return await db.delete(
      TABLE_QUOTES,
      where: "id=?",
      whereArgs: [id]
    );
  }
}
