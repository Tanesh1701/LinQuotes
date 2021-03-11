import 'dart:convert';
import 'package:Advice/constant.dart';
import 'package:Advice/database/database_provider.dart';
import 'package:Advice/model/model.dart';
import 'package:Advice/screens/motivate.dart';
import 'package:Advice/screens/randomquote.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'liked.dart';


class Homescreen extends StatefulWidget {
  @override
  _HomescreenState createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  int checkedIndex = -1;
  List myData;
  List<Quote> quotes = [];
  Quote likedQuote;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.sort, size: 30, color: Colors.white),
          onPressed: () => _scaffoldKey.currentState.openDrawer(),
        ),
        centerTitle: true,
        backgroundColor: screenColor,
        title: FontProperties(textToBeUsed: "Lorem Ipsum", color: quoteColor, sizeFont: 20)
      ),
      body: Container(
        color: screenColor,
        child: FutureBuilder(
          future: DefaultAssetBundle.of(context).loadString("assets/quotes.json"),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(
                  valueColor: new AlwaysStoppedAnimation<Color>(secondaryColor),
                ),
              );
            }
            myData = json.decode(snapshot.data.toString());
            quotes = List<Quote>.from(myData.map((i) => Quote.fromJson(i)));
            return ListView.builder(
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    color: screenColor,
                    child: ListTile(
                      trailing: IconButton(
                        icon: checkedIndex == index ? Icon(Icons.favorite, color: secondaryColor) : Icon(Icons.favorite_border, color: quoteColor),
                        iconSize: 20,
                        onPressed: () {
                          likedQuote = Quote(quote: myData[index]["quote"], author: myData[index]["author"]);
                          DatabaseProvider.db.insert(likedQuote);
                          setState(() {
                            checkedIndex = index;
                          });
                        },
                      ),
                    title: FontProperties(textToBeUsed: quotes[index].quote, color: quoteColor, sizeFont: 15),
                      subtitle: Padding(
                        padding: EdgeInsets.only(top: 7),
                        child: FontProperties(textToBeUsed: quotes[index].author, color: authorColor, sizeFont: 13)
                      ),
                    ),
                  ),
                );
              },
              itemCount: quotes == null ? 0 : quotes.length,
            );
          }
        ),
      ),
      drawer: Drawer(
        child: Container(
          color: screenColor,
          child: ListView(
            children: [
              DrawerTiles(label: "Liked Quotes", goToRoute: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => Likes()));
                }),
              DrawerTiles(label: "Random Quote", goToRoute: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => RandomQuote(myData)));
                }),
                DrawerTiles(label: "Motivational Quotes", goToRoute: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => MotivateME()));
                }),
            ]
          ),
        ),
      ),
    );
  }
}

class DrawerTiles extends StatelessWidget {
  final String label;
  final Function goToRoute;
  DrawerTiles({this.label, this.goToRoute});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text(
          label,
          style: GoogleFonts.roboto(
            textStyle: TextStyle(
              color: quoteColor,
              fontSize: 15
            )
          ),
        ),
      ),
      onTap: goToRoute,
    );
  }
}