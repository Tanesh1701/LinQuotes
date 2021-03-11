import 'package:Advice/constant.dart';
import 'package:admob_flutter/admob_flutter.dart';
import 'package:flutter/material.dart';
import 'dart:math';

class RandomQuote extends StatefulWidget {
  final List quoteList;
  RandomQuote(this.quoteList);


  @override
  _RandomQuoteState createState() => _RandomQuoteState();
}

class _RandomQuoteState extends State<RandomQuote> {
  int randomNumber;
  @override
  void initState() {
    Random random = new Random();
    randomNumber = random.nextInt(widget.quoteList.length);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.black,
          title: FontProperties(textToBeUsed: "Random Quote", color: quoteColor, sizeFont: 20)),
      body: Container(
        height: double.maxFinite,
        color: Colors.black,
        child: Column(
          children: [
            ListTile(
              title: FontProperties(textToBeUsed: widget.quoteList[randomNumber]['quote'], color: quoteColor, sizeFont: 15),
              subtitle: Padding(
                padding: EdgeInsets.only(top: 7),
                child: FontProperties(textToBeUsed: widget.quoteList[randomNumber]['author'], color: authorColor, sizeFont: 13),
              ),
            ),
            SizedBox(height: 400),
            AdmobBanner(adUnitId: "ca-app-pub-3940256099942544/6300978111", adSize: AdmobBannerSize.LARGE_BANNER)
          ],
        ),
      ),
    );
  }
}
