import 'package:ebook/Screens/latestBookScreen.dart';
import 'package:ebook/Screens/viewbook.dart';
import 'package:ebook/customroute.dart';
import 'package:flutter/material.dart';

class Tabs extends StatefulWidget {
  final List author;
  final List popular;

  Tabs(this.author, this.popular);

  @override
  _TabsState createState() => _TabsState();
}

class _TabsState extends State<Tabs> {
  double selectorPosiontX = 20.0;
  final double selectorWidth = 150.0;
  int currentselection = 1;
  GlobalKey key1 = GlobalKey();
  GlobalKey key2 = GlobalKey();
  _selectedItem(int i) {
    currentselection = i;
    GlobalKey selectedglobalkey = GlobalKey();
    switch (i) {
      case 1:
        selectedglobalkey = key1;
        break;
      case 2:
        selectedglobalkey = key2;
        break;
      default:
    }
    selectWidgetPosition(selectedglobalkey);
    setState(() {});
  }

  selectWidgetPosition(GlobalKey selectedKey) {
    RenderBox? renderBox;
    renderBox = selectedKey.currentContext!.findRenderObject() as RenderBox?;
    final widgetposition = renderBox!.localToGlobal(Offset.zero);
    final widgetsize = renderBox.size;
    selectorPosiontX =
        widgetposition.dx - ((selectorWidth - widgetsize.width + 20) / 2);
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance
        .addPostFrameCallback((_) => selectWidgetPosition(key1));
  }

  Widget items() {
    if (currentselection == 1) return author();
    if (currentselection == 2) return popular();

    return Container();
  }

  Color selectedColour(int position) {
    Color? c;
    if (position % 3 == 0) c = Color.fromRGBO(132, 208, 253, 1);
    if (position % 3 == 1) c = Color.fromRGBO(189, 176, 251, 1);
    if (position % 3 == 2) c = Color.fromRGBO(133, 248, 213, 1);
    return c!;
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
  }

  Widget author() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      // color: Colors.red,
      height: 330,
      child: ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: widget.author.length,
        itemBuilder: (ctx, i) {
          return GestureDetector(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (ctx) =>
                      LatestBookScreen(
                    authorId: widget.author[i].authorId,
                    authorname: widget.author[i].authorName,
                    type: 'Author', categoryid: '', categoryname: '',
                  ),
                ),
              );
            },
            child: Column(
              children: [
                Stack(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 10,
                            // spreadRadius: 2,
                            color: Colors.black12,
                            offset: Offset.fromDirection(8, 10),
                          ),
                        ],
                      ),
                      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      child: Column(
                        children: [
                          Container(
                            height: 200,
                            width: 140,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Image.network(
                                widget.author[i].authorImage,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            widget.author[i].authorName,
                            style: TextStyle(
                              fontSize: 18,
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      top: 235,
                      right: 0,
                      child: Container(
                        height: 40,
                        width: 90,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            SizedBox(
                              width: 5,
                            ),
                            Icon(
                              Icons.book,
                              color: Color.fromRGBO(46, 121, 183, 1),
                            ),
                            Text(
                              widget.author[i].books.toString(),
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 19,
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
                              // spreadRadius: 2,
                              color: Colors.black26,
                              offset: Offset.fromDirection(8, 10),
                            ),
                          ],
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(40),
                        ),
                      ),
                    )
                  ],
                  clipBehavior: Clip.none,
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget popular() {
    return Container(
      height: 330,
      // color: Colors.black,
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 200,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 20,
          mainAxisSpacing: 0,
          mainAxisExtent: 200,
        ),
        itemCount: widget.popular.length,
        itemBuilder: (ctx, i) {
          return Column(
            children: <Widget>[
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    CustomRoute(
                      builder: (ctx) => ViewBookScreen(
                        widget.popular[i].bookTitle,
                        widget.popular[i].bookId,
                        widget.popular[i].bookPreview,
                        widget.popular[i].bookPdf,
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
                              widget.popular[i].bookTitle.length > 25
                                  ? widget.popular[i].bookTitle
                                          .toString()
                                          .substring(0, 20) +
                                      '...'
                                  : widget.popular[i].bookTitle,
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
                            widget.popular[i].bookPreview,
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
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          decoration: BoxDecoration(
            color: Color.fromRGBO(46, 121, 183, 1),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            ),
          ),
          margin: EdgeInsets.symmetric(horizontal: 10),
          alignment: Alignment.center,
          height: 50,
          child: Stack(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(
                        width: 19,
                      ),
                      InkWell(
                        onTap: () => _selectedItem(1),
                        key: key1,
                        child: Text(
                          'Author',
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      Container(
                        height: 30,
                        child: VerticalDivider(
                          color: Colors.white,
                        ),
                      ),
                      InkWell(
                        key: key2,
                        onTap: () => _selectedItem(2),
                        child: Text(
                          'Latest Books',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 0,
                      ),
                    ],
                  ),
                ],
              ),
              AnimatedPositioned(
                duration: const Duration(milliseconds: 400),
                curve: Curves.fastOutSlowIn,
                left: selectorPosiontX,
                top: 45,
                child: Container(
                  height: 3,
                  width: selectorWidth,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(40),
                  ),
                ),
              ),
              SizedBox(
                height: 300,
              ),
            ],
          ),
        ),
        SizedBox(
          height: 3,
        ),
        Container(
          // height: MediaQuery.of(context).size.height * 0.5,
          child: items(),
        ),
      ],
    );
  }
}
