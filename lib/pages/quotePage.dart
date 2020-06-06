import 'dart:math';
import 'package:flutter/material.dart';
import 'package:quotes_app/components/flatGradientButton.dart';
import 'dart:convert';
import 'package:quotes_app/constantsColors.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_clipboard_manager/flutter_clipboard_manager.dart';
import 'package:quotes_app/pages/listQuotes.dart';

class QuotePage extends StatefulWidget {
  QuotePage({Key key}) : super(key: key);

  @override
  _QuotePageState createState() => _QuotePageState();
}

class _QuotePageState extends State<QuotePage> {
  int quoteNumber = 0;
  int colorNumber = 0;
  String quote = "";
  double _opacity = 1;
  @override
  void initState() {
    super.initState();
    setState(() {
      quoteNumber = new Random().nextInt(500);
      colorNumber = new Random().nextInt(5);
    });
  }

  quoteSymbol(bool left, size, isPortrait) {
    return Container(
      alignment: left ? Alignment.topLeft : Alignment.bottomRight,
      child: Icon(
        Icons.format_quote,
        color: Colors.white,
        size: isPortrait ? size.width * 0.12 : size.width * 0.05,
      ),
    );
  }

  contentText(text, size, isPortrait) {
    return Container(
      child: Text(
        text,
        style: TextStyle(
            fontSize: isPortrait ? size.width * 0.09 : size.width * 0.05,
            fontWeight: FontWeight.bold,
            color: Colors.white),
      ),
    );
  }

  divder(size) {
    return Container(
      alignment: Alignment.bottomRight,
      child: Divider(
        thickness: 2,
        color: Colors.white,
        indent: size.width / 2,
      ),
    );
  }

  authorText(text, size, isPortrait) {
    return Container(
      alignment: Alignment.bottomRight,
      child: Text(
        text,
        style: TextStyle(
            fontSize: isPortrait ? size.width * 0.05 : size.width * 0.035,
            fontWeight: FontWeight.bold,
            color: Colors.white),
      ),
    );
  }

  listBody(size, isPortrait, content, author) {
    return ListView(
      children: <Widget>[
        quoteSymbol(true, size, isPortrait),
        contentText(content, size, isPortrait),
        quoteSymbol(false, size, isPortrait),
        divder(size),
        authorText(author, size, isPortrait),
      ],
    );
  }

  copyToClipBoard(context1, quote) {
    FlutterClipboardManager.copyToClipBoard(quote).then((result) {
      if (result) {
        final snackBar = SnackBar(
            content: Text('Copied to Clipboard'),
            action: SnackBarAction(
                label: 'Undo',
                onPressed: () {
                  // Some code to undo the change.
                }));
        Scaffold.of(context1).showSnackBar(snackBar);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    bool isPortrait =
        Orientation.portrait.index == MediaQuery.of(context).orientation.index;
    return SafeArea(
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              colors[colorNumber]['color1'],
              colors[colorNumber]['color2'],
            ],
          ),
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.list),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ListQuotePage(
                        color1: colors[colorNumber]['color1'],
                        color2: colors[colorNumber]['color2'],
                      ),
                    ),
                  );
                },
                iconSize: isPortrait ? size.width * 0.12 : size.width * 0.065,
                color: Colors.white,
              ),
            ],
          ),
          body: FutureBuilder(
            future:
                DefaultAssetBundle.of(context).loadString('assets/quotes.json'),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                var myQuote = json.decode((snapshot.data.toString()));
                quote =
                    "\"${myQuote[quoteNumber]['content']}\" \n - ${myQuote[quoteNumber]['author']}";
                print(quote);
                return Column(
                  children: <Widget>[
                    Expanded(
                      flex: 4,
                      child: AnimatedOpacity(
                        opacity: _opacity,
                        duration: Duration(seconds: 1),
                        child: Container(
                          padding: EdgeInsets.all(isPortrait
                              ? size.width * 0.04
                              : size.width * 0.02),
                          child: listBody(
                              size,
                              isPortrait,
                              myQuote[quoteNumber]['content'],
                              myQuote[quoteNumber]['author']),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Container(
                              margin: EdgeInsets.only(
                                  left: size.width * 0.1,
                                  bottom: isPortrait ? 0 : size.height * 0.08),
                              child: InkWell(
                                borderRadius: BorderRadius.circular(50),
                                onTap: () {
                                  copyToClipBoard(context, quote);
                                },
                                child: FaIcon(
                                  FontAwesomeIcons.clipboard,
                                  size: isPortrait
                                      ? size.width * 0.14
                                      : size.width * 0.065,
                                  color: Color(0XFFFFFFFF),
                                ),
                              )),
                          Expanded(
                            flex: 4,
                            child: Container(
                              alignment: Alignment.bottomCenter,
                              margin:
                                  EdgeInsets.only(bottom: size.height * 0.05),
                              child: FlatGradientButton(
                                width: size.width * 0.5,
                                height: isPortrait
                                    ? size.height * 0.07
                                    : size.height * 0.2,
                                child: Text(
                                  'New Quote',
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                gradient: LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                  colors: [
                                    colors[colorNumber]['color2'],
                                    colors[colorNumber]['color1'],
                                  ],
                                ),
                                onPressed: () {
                                  setState(() => _opacity = 0);
                                  Future.delayed(Duration(milliseconds: 500),
                                      () {
                                    setState(() {
                                      _opacity = 1;
                                      quoteNumber = new Random().nextInt(500);
                                      colorNumber = new Random().nextInt(7);
                                    });
                                  });
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              } else {
                return Center(
                    child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(
                    colors[colorNumber]['color2'],
                  ),
                ));
              }
            },
          ),
        ),
      ),
    );
  }
}
