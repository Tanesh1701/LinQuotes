import 'dart:convert';
import 'package:flutter/material.dart';
import '../constant.dart';



class MotivateME extends StatefulWidget {
  @override
  _MotivateMEState createState() => _MotivateMEState();
}

class _MotivateMEState extends State<MotivateME> {

  List jsonData = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          backgroundColor: screenColor,
          title: FontProperties(textToBeUsed: 'Motivational Quotes', color: quoteColor, sizeFont: 20)
      ),
      body: Container(
        color: screenColor,
        child: FutureBuilder(
          future: DefaultAssetBundle.of(context).loadString("assets/motivation.json"),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(
                  valueColor: new AlwaysStoppedAnimation<Color>(secondaryColor),
                ),
              );
            }
            jsonData = json.decode(snapshot.data.toString());
            jsonData.shuffle();
            return ListView.builder(
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    color: screenColor,
                    child: ListTile(
                    title: FontProperties(textToBeUsed: jsonData[index]["quote"], color: quoteColor, sizeFont: 15),
                      subtitle: Padding(
                        padding: EdgeInsets.only(top: 7),
                        child: FontProperties(textToBeUsed: jsonData[index]["author"], color: authorColor, sizeFont: 13)
                      ),
                    ),
                  ),
                );
              },
              itemCount: jsonData == null ? 0 : jsonData.length,
            );
          }
        ),
      ),
    );
  }
}