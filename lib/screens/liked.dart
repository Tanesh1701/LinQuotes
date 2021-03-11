import 'package:Advice/constant.dart';
import 'package:Advice/database/database_provider.dart';
import 'package:flutter/material.dart';

class Likes extends StatefulWidget {
  
  @override
  _LikesState createState() => _LikesState();
}

class _LikesState extends State<Likes> {
  List quotesLiked = [];
  @override
  void initState() {
    super.initState();
    DatabaseProvider.db.getQuotes().then((value) {
      setState(() {
        quotesLiked.addAll(value);
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          backgroundColor: screenColor,
          title: FontProperties(textToBeUsed: "Liked Quotes", color: quoteColor, sizeFont: 20)),
      body: Container(
        color: screenColor,
        child: ListView.builder(
          itemCount: quotesLiked.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                color: screenColor,
                child: ListTile(
                  trailing: IconButton(
                    icon: Icon(Icons.delete_outline, color: quoteColor, size: 20),
                    onPressed: () {
                        DatabaseProvider.db.delete(quotesLiked[index].id).then((value) {
                        setState(() {
                        quotesLiked.removeAt(index);
                      });
                      });
                    },
                  ),
                  title: FontProperties(textToBeUsed: quotesLiked[index].quote, color: quoteColor, sizeFont: 15),
                  subtitle: Padding(
                    padding: EdgeInsets.only(top: 7),
                    child: FontProperties(textToBeUsed: quotesLiked[index].author, color: authorColor, sizeFont: 13),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
