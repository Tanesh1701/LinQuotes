import 'package:Advice/database/database_provider.dart';

class Quote {
  String quote;
  String author;
  //String category;
  int id;

  Quote({this.quote, this.author});

  factory Quote.fromJson(Map<String, dynamic> json) {
    return new Quote(
      quote: json['quote'] as String,
      author: json['author'] as String,
      //category: json['category'] as String,
    );
  }


  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      DatabaseProvider.COLUMN_QUOTE: quote,
      DatabaseProvider.COLUMN_AUTHOR: author,
      //DatabaseProvider.COLUMN_CATEGORY: category,
    };



    if (id!=null) {
      map[DatabaseProvider.COLUMN_ID] = id;
    }

    return map;
  }

  Quote.fromMap(Map<String, dynamic> map) {
    id = map[DatabaseProvider.COLUMN_ID];
    quote = map[DatabaseProvider.COLUMN_QUOTE];
    author = map[DatabaseProvider.COLUMN_AUTHOR];
    //category = map[DatabaseProvider.COLUMN_CATEGORY];
  }
}