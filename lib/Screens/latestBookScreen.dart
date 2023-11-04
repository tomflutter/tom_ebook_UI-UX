import 'package:ebook/Models/continueReading.dart';
import 'package:ebook/NetworkApi/NetworkApi.dart';
import 'package:ebook/Screens/viewbook.dart';
import 'package:ebook/customroute.dart';
import 'package:flutter/material.dart';

class LatestBookScreen extends StatefulWidget {
  final String categoryid;
  final String categoryname;
  final String authorId;
  final String authorname;
  final String type;

  LatestBookScreen({
    required this.categoryid,
    required this.categoryname,
    required this.type,
    required this.authorId,
    required this.authorname,
  });

  @override
  _LatestBookScreenState createState() => _LatestBookScreenState();
}


class _LatestBookScreenState extends State<LatestBookScreen> {
  NetworkApi networkApi =NetworkApi();
  String title = '';
  @override
  void initState() {
    super.initState();
    if (widget.type == '') {
      getrecent();
    } else if (widget.type == 'Category') {
      getbook();
    } else if (widget.type == 'Favourite') {
      getfav();
    } else if (widget.type == 'Continue') {
      continueReading();
    } else if (widget.type == 'Author') {
      getauthorbook();
    }
  }

  // ignore: deprecated_member_use
  List<ContinueReadingItem> readingitem = [];
  void getrecent() async {
    await networkApi.getrecent();
    readingitem = ContinueReadingModel.list;
    setState(() {});
  }

  void getbook() async {
    await networkApi.getBook(widget.categoryid);
    readingitem = ContinueReadingModel.list;
    setState(() {});
  }

  void getfav() async {
    await networkApi.getFavourite();
    readingitem = ContinueReadingModel.list;
    setState(() {});
  }

  void getauthorbook() async {
    await networkApi.getauthorBook(widget.authorId);
    readingitem = ContinueReadingModel.list;
    setState(() {});
  }

  void continueReading() async {
    await networkApi.getContinueReading();
    readingitem = ContinueReadingModel.list;
    setState(() {});
  }

  Color selectedColour(int position) {
    Color? c;
    if (position % 3 == 0) c = Color.fromRGBO(132, 208, 253, 1);
    if (position % 3 == 1) c = Color.fromRGBO(189, 176, 251, 1);
    if (position % 3 == 2) c = Color.fromRGBO(133, 248, 213, 1);
    return c!;
  }

  String titles() {
    if (widget.type == '') {
      return title = 'Recent Books';
    } else if (widget.type == 'Category') {
      return title = widget.categoryname;
    } else if (widget.type == 'Favourite') {
      return title = 'Favourites';
    } else if (widget.type == 'Continue') {
      return title = 'Continue Reading';
    } else if (widget.type == 'Author') {
      return title = widget.authorname;
    }
    return title;
  }

  rates(number) {
    if (number == 1) return '2.0';
    if (number == 2) return '4.0';
    if (number == 3) return '1.0';
    if (number == 4) return '4.5';
    if (number == 5) return '5.0';
    if (number == 6) return '3.5';
    if (number == 7) return '2.5';
    if (number == 8) return '3.5';
    if (number == 9) return '5.0';
    if (number == 10) return '4.0';
    if (number >= 10) return '4.0';
  }

  Widget popular() {
    return Container(
      padding: EdgeInsets.only(top: 10),
      height: MediaQuery.of(context).size.height,
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 200,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 20,
          mainAxisSpacing: 0,
          mainAxisExtent: 200,
        ),
        itemCount: readingitem.length,
        itemBuilder: (ctx, i) {
          return Column(
            children: <Widget>[
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    CustomRoute(
                      builder: (ctx) =>
                          ViewBookScreen(
                        readingitem[i].bookTitle!,
                        readingitem[i].bookId!,
                        readingitem[i].bookPreview!,
                        readingitem[i].pdf!,
                        type: 'MostPopular',
                      ),
                    ),
                  );
                },
                child: Stack(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: selectedColour(i),
                      ),
                      margin: EdgeInsets.symmetric(vertical: 40),
                      height: 120,
                      width: 170,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Spacer(),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            child: Text(
                              readingitem[i].bookTitle!.length > 25
                                  ? readingitem[i]
                                          .bookTitle
                                          .toString()
                                          .substring(0, 20) +
                                      '...'
                                  : readingitem[i].bookTitle!,
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      right: 45,
                      child: Container(
                        height: 100,
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 10,
                              // spreadRadius: 2,
                              color: Colors.black38,
                              offset: Offset.fromDirection(8, 10),
                            ),
                          ],
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(7),
                          child: Image.network(
                            readingitem[i].bookPreview!,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 150,
                      right: 0,
                      child: Container(
                        height: 40,
                        width: 60,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            SizedBox(
                              width: 5,
                            ),
                            Icon(
                              Icons.star,
                              color: Colors.yellow,
                            ),
                            Container(
                              child: Text(
                                rates(i + 1),
                                overflow: TextOverflow.clip,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 13,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                          ],
                        ),
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 10,
                              color: Colors.black12,
                              offset: Offset.fromDirection(8, 10),
                            ),
                          ],
                          borderRadius: BorderRadius.circular(40),
                          color: Colors.white,
                        ),
                      ),
                    )
                  ],
                  clipBehavior: Clip.none,
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          titles(),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        backgroundColor: Color.fromRGBO(46, 121, 183, 1),
      ),
      body: readingitem.length == 0
          ? Center(
              child: CircularProgressIndicator(),
            )
          : popular(),
    );
  }
}
