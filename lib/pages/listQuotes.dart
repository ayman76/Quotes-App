import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter_clipboard_manager/flutter_clipboard_manager.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ListQuotePage extends StatefulWidget {
  ListQuotePage({@required this.color1, this.color2});
  final Color color1;
  final Color color2;
  @override
  _ListQuotePageState createState() => _ListQuotePageState();
}

class _ListQuotePageState extends State<ListQuotePage> {
  int quoteNumber = 0;
  String quote = "";

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

  contentText(myQuote, index, size, isPortrait) {
    return Container(
        child: Text(
      '" ${myQuote[index]['content']} "',
      style: TextStyle(
          fontSize: isPortrait ? size.width * 0.055: size.width * 0.035, color: Colors.white, fontWeight: FontWeight.bold),
    ));
  }

  authorText(myQuote, index, size,isPortrait) {
    return Container(
        child: Text(
      'ـــ ${myQuote[index]['author']}',
      style: TextStyle(
          fontSize: isPortrait ? size.width * 0.045: size.width * 0.03, color: Colors.white, fontWeight: FontWeight.bold),
    ));
  }

  clipBoardIcon(isPortrait, size, myQuote, index, context) {
    return InkWell(
      child: FaIcon(
        FontAwesomeIcons.clipboard,
        size: isPortrait ? size.width * 0.1 : size.width * 0.065,
        color: Colors.white,
      ),
      onTap: () {
        quote =
            "\"${myQuote[index]['content']}\" \n - ${myQuote[index]['author']}";
        copyToClipBoard(context, quote);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final double itemHeight = (size.height) / 1.25;
    final double itemWidth = size.width / 2;

    bool isPortrait =
        Orientation.portrait.index == MediaQuery.of(context).orientation.index;
    return SafeArea(
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              widget.color1,
              widget.color2,
            ],
          ),
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: IconButton(
              icon: FaIcon(
                FontAwesomeIcons.home,
                color: Colors.white,
                size: isPortrait ? size.width * 0.09 : size.width * 0.045,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
          body: FutureBuilder(
            future:
                DefaultAssetBundle.of(context).loadString('assets/quotes.json'),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                var myQuote = json.decode((snapshot.data.toString()));
                if (isPortrait) {
                  return ListView.builder(
                    itemCount: myQuote.length,
                    itemBuilder: (context, index) {
                      return Container(
                        margin: EdgeInsets.all(5),
                        child: Card(
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                contentText(myQuote, index, size, isPortrait),
                                SizedBox(height: 10),
                                Row(
                                  children: <Widget>[
                                    Expanded(
                                      flex: 4,
                                      child: authorText(myQuote, index,size, isPortrait),
                                    ),
                                    Expanded(
                                        child: Container(
                                      alignment: Alignment.bottomRight,
                                      child: clipBoardIcon(isPortrait, size,
                                          myQuote, index, context),
                                    )),
                                  ],
                                )
                              ],
                            ),
                          ),
                          elevation: 0,
                          margin: EdgeInsets.all(7),
                          borderOnForeground: true,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          color: Colors.transparent,
                        ),
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.white, width: 3),
                            borderRadius: BorderRadius.circular(20)),
                      );
                    },
                  );
                } else {
                  return GridView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, childAspectRatio: (itemWidth / itemHeight)),
                    itemCount: myQuote.length,
                    itemBuilder: (BuildContext context, index) {
                      return Container(
                        margin: EdgeInsets.all(5),
                        child: Card(
                          child: Padding(
                            padding: const EdgeInsets.all(0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                contentText(myQuote, index, size, isPortrait),
                                SizedBox(height: 10),
                                Row(
                                  children: <Widget>[
                                    Expanded(
                                      flex: 4,
                                      child: authorText(myQuote, index, size, isPortrait),
                                    ),
                                    Expanded(
                                        child: Container(
                                      alignment: Alignment.bottomRight,
                                      child: clipBoardIcon(isPortrait, size,
                                          myQuote, index, context),
                                    )),
                                  ],
                                )
                              ],
                            ),
                          ),
                          elevation: 0,
                          margin: EdgeInsets.all(7),
                          borderOnForeground: true,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          color: Colors.transparent,
                        ),
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.white, width: 3),
                            borderRadius: BorderRadius.circular(20)),
                      );
                    },
                  );
                }
              } else {
                return Center(
                    child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(
                    Colors.blue[800],
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
