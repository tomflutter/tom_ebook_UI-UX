import 'dart:io';
import 'dart:math';

import 'package:dio/dio.dart';
import 'package:ebook/Models/comments.dart';
import 'package:ebook/Models/continueReading.dart';
import 'package:ebook/Models/singleBook.dart';
import 'package:ebook/NetworkApi/NetworkApi.dart';
import 'package:ebook/Screens/latestBookScreen.dart';
import 'package:ebook/Screens/pdfView.dart';
import 'package:ebook/appconfig.dart';
import 'package:ebook/customroute.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:palette_generator/palette_generator.dart';
import 'package:path_provider/path_provider.dart';

class ViewBookScreen extends StatefulWidget {
  final String bookname;
  final String bookID;
  final String type;
  final String bookimage;
  final String pdf;

  ViewBookScreen(this.bookname, this.bookID, this.bookimage, this.pdf,
      {required this.type});

  @override
  _ViewBookScreenState createState() => _ViewBookScreenState();
}

class _ViewBookScreenState extends State<ViewBookScreen> {
  List<PaletteColor> colors = [];
  int index = 0;
  NetworkApi networkApi = NetworkApi();
  String pdfs = '';
  bool ontap = false;

  @override
  void initState() {
    super.initState();
    singleItem();
    getrecent();
    getcomments();
    update();
    pdf();
    scrollViewController.addListener(changeColor);
  }

  String pdf() {
    if (widget.type == 'MostPopular') {
      pdfs = NetworkApi.Basurl1 + 'assets/book/Story/' + widget.pdf;
    } else if (widget.type == '') {
      pdfs = widget.pdf;
    }
    return pdfs;
  }

  // ignore: deprecated_member_use
  List<SingleBookItem> bookitem = [];

  void singleItem() async {
    await networkApi.singleItem(widget.bookID);
    bookitem = SingleBookModel.list;
    setState(() {});
  }

  // ignore: deprecated_member_use
  List<ContinueReadingItem> item = [];

  void getrecent() async {
    await networkApi.getrecent();
    item = ContinueReadingModel.list;
    setState(() {});
  }

  void addtofav(String bookid) async {
    await networkApi.addtofav(bookid);
    singleItem();
    setState(() {});
  }

  // ignore: deprecated_member_use
  List<CommentsItem> commnets = [];
  void getcomments() async {
    await networkApi.getComment(widget.bookID);
    commnets = CommentsModel.list;
    setState(() {});
  }

  update() async {
    final PaletteGenerator generator = await PaletteGenerator.fromImageProvider(
        NetworkImage(widget.bookimage),
        size: Size(400, 400),
        maximumColorCount: 20);
    colors.add(
      generator.darkMutedColor != null
          ? generator.dominantColor!
          : PaletteColor(Colors.blue, 2),
    );

    // setState(() {});
  }

  getColor(number) {
    if (number == 1) return Colors.redAccent;
    if (number == 2) return Colors.blueAccent;
    if (number == 3) return Colors.greenAccent;
    if (number == 4) return Colors.purpleAccent;
    if (number == 5) return Colors.deepPurpleAccent;
    if (number == 6) return Colors.pinkAccent;
    if (number == 7) return Colors.blueAccent;
    if (number == 8) return Colors.purpleAccent;
    if (number == 9) return Colors.deepOrangeAccent;
    if (number == 10) return Colors.greenAccent;
    if (number > 10) return Colors.deepPurple;
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
    if (number > 10) return '4.0';
  }

  var gradientColor1 = Colors.black26;

  // ignore: unused_field
  var gradientColor2 = Colors.black26;
  ScrollController scrollViewController =
      ScrollController(initialScrollOffset: 0.0);

  Color selectedColour(int position) {
    Color? c;
    if (position % 3 == 0) c = Color.fromRGBO(132, 208, 253, 1);
    if (position % 3 == 1) c = Color.fromRGBO(189, 176, 251, 1);
    if (position % 3 == 2) c = Color.fromRGBO(133, 248, 213, 1);
    return c!;
  }

  void changeColor() {
    if ((scrollViewController.offset == 0) &&
        (gradientColor1 != Colors.black26)) {
      setState(() {
        gradientColor1 = Colors.black26;
        gradientColor2 = Colors.black26;
      });
    } else if ((scrollViewController.offset <= 40) &&
        (gradientColor1 != Color.fromRGBO(46, 121, 183, 0.4))) {
      setState(() {
        gradientColor1 = Color.fromRGBO(46, 121, 183, 0.4);
        gradientColor2 = Color.fromRGBO(46, 121, 183, 0.4);
      });
    } else if ((scrollViewController.offset <= 100) &&
        (scrollViewController.offset > 40)) {
      var opacity = scrollViewController.offset / 100;
      setState(() {
        gradientColor1 = Color.fromRGBO(46, 121, 183, opacity);
        gradientColor2 = Color.fromRGBO(46, 121, 183, opacity);
      });
    }
  }

  Future<String> _findLocalPath() async {
    final directory = Platform.isAndroid
        ? await getExternalStorageDirectory()
        : await getApplicationDocumentsDirectory();
    return directory!.path;
  }

  String localPath = '';
  double percentage = 0.0;
  bool downloading = false;
  var progress = "";

  Future<void> download() async {
    localPath = (await _findLocalPath()) + '/Download';
    final savedDir = Directory(localPath);
    bool hasExisted = await savedDir.exists();
    if (!hasExisted) {
      savedDir.create();
    }

    Dio dio = Dio();

    var dirToSave = await getApplicationDocumentsDirectory();
    await dio.download(pdfs, "$localPath/" + widget.bookname + ".pdf",
        onReceiveProgress: (rec, total) {
      setState(() {
        downloading = true;
        Future.delayed(Duration(seconds: 2)).then((onvalue) {
          percentage = (percentage + 1.0);
        });
      });
    });

    setState(() {
      downloading = false;
      progress = "Complete";
      Fluttertoast.showToast(
        msg: "Download Completed!" +
            "${dirToSave.path}/" +
            widget.bookname +
            ".pdf",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
      );
      // pr.hide().whenComplete(() {});
    });
  }

  Widget popular() {
    return Container(
      height: 270,
      child: bookitem.length == 0
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: item.length == 0 ? 0 : item.length,
              physics: BouncingScrollPhysics(),
              itemBuilder: (ctx, i) {
                return Column(
                  children: <Widget>[
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).pushReplacement(
                          CustomRoute(
                            builder: (ctx) => ViewBookScreen(
                              item[i].bookTitle!,
                              item[i].bookId!,
                              item[i].bookPreview!,
                              item[i].pdf!,
                              type: '',
                            ),
                          ),
                        );
                      },
                      child: Container(
                        padding: EdgeInsets.only(top: 20),
                        child: Stack(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: selectedColour(i),
                              ),
                              margin: EdgeInsets.symmetric(
                                  vertical: 40, horizontal: 10),
                              height: 120,
                              width: 140,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Spacer(),
                                  Container(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 10),
                                    child: Text(
                                      item[i].bookTitle!.length > 25
                                          ? item[i]
                                                  .bookTitle
                                                  .toString()
                                                  .substring(0, 20) +
                                              '...'
                                          : item[i].bookTitle!,
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
                              right: 39,
                              child: Container(
                                height: 100,
                                decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      blurRadius: 10,
                                      color: Colors.black38,
                                      offset: Offset.fromDirection(8, 10),
                                    ),
                                  ],
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(7),
                                  child: Image.network(
                                    item[i].bookPreview!,
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
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
                    ),
                  ],
                );
              },
            ),
    );
  }

  TextEditingController _textController = TextEditingController();
  double count = 0;

  showExitPopup() {
    return showDialog(
      context: context,
      builder: (context) {
        return ScreenUtilInit(
          builder: (context, child) => AlertDialog(
            backgroundColor: Colors.grey[300],
            insetPadding: EdgeInsets.symmetric(horizontal: 0),
            contentPadding: EdgeInsets.symmetric(horizontal: 0, vertical: 10),
            title: Text('Submit a Review'),
            content: Container(
              height: 150.h,
              child: Card(
                margin: EdgeInsets.all(0),
                child: Column(
                  children: [
                    RatingBar.builder(
                      minRating: 1,
                      itemBuilder: (ctx, _) => Icon(
                        Icons.star,
                        color: Colors.yellow,
                      ),
                      glowColor: Colors.yellow,
                      onRatingUpdate: (data) {
                        count = data;
                      },
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 5),
                      height: 110,
                      child: Container(
                        width: double.infinity,
                        child: TextFormField(
                          controller: _textController,
                          maxLines: 3,
                          keyboardType: TextInputType.multiline,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText:
                                'Share details of your experience at this Book',
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: Text('NO'),
                onPressed: () {
                  Navigator.of(context).pop();
                  _textController.clear();
                },
              ),
              // ignore: deprecated_member_use
              ElevatedButton(
                child: Text(
                  'Yes',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () async {
                  await addRating();
                  await addreview();
                  Navigator.of(context).pop();
                  _textController.clear();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  addRating() async {
    await networkApi.addRatings(widget.bookID, count.toString());
  }

  addreview() async {
    await networkApi.addComments(widget.bookID, _textController.text);
  }

  Widget reviewModel(String name, String reviewtext) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(
          height: 10,
        ),
        Row(
          children: <Widget>[
            SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
              ],
            ),
          ],
        ),
        SizedBox(
          height: 5,
        ),
        Container(
          padding: EdgeInsets.only(left: 10),
          child: Text(
            reviewtext,
            style: TextStyle(
              fontSize: 17,
              color: Colors.grey[600],
            ),
          ),
        ),
        Divider(),
      ],
    );
  }

  Widget rate() {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: EdgeInsets.only(left: 10),
                child: Text(
                  'Rate & Review',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
              ),
              if (commnets.length >= 1)
                Container(
                  padding: EdgeInsets.only(right: 10),
                  child: Text(
                    'View All',
                    style: TextStyle(
                      color: Colors.blue,
                    ),
                  ),
                )
            ],
          ),
          SizedBox(
            height: 10,
          ),
          GestureDetector(
            onTap: () => showExitPopup(),
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 10),
              padding: EdgeInsets.only(left: 10),
              alignment: Alignment.centerLeft,
              width: double.infinity,
              height: 50,
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    blurRadius: 8,
                    offset: Offset.fromDirection(1.1),
                    spreadRadius: 1,
                    color: Colors.black54.withOpacity(0.1),
                  ),
                ],
                borderRadius: BorderRadius.circular(40),
                color: Colors.white,
              ),
              child: Text(
                'Share your experience to help others',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 20,
                ),
              ),
            ),
          ),
          Container(
            alignment: Alignment.topCenter,
            height: min(commnets.length.toDouble() * 80, 200),
            child: commnets.isNotEmpty
                ? ListView.builder(
                    physics: ontap == false
                        ? NeverScrollableScrollPhysics()
                        : BouncingScrollPhysics(),
                    padding: EdgeInsets.symmetric(vertical: 0),
                    itemCount: commnets.length >= 3 && ontap == false
                        ? 3
                        : commnets.length,
                    itemBuilder: (ctx, i) => reviewModel(
                      commnets[i].userName!,
                      commnets[i].comment!,
                    ),
                  )
                : Container(
                    height: 300,
                    child: Center(
                      child: Text(
                        "No Reviews yet",
                      ),
                    ),
                  ),
          ),
          SizedBox(
            height: 15,
          ),
          if (commnets.length > 3 && ontap == false)
            GestureDetector(
              onTap: () {
                setState(() {
                  ontap = !ontap;
                });
              },
              child: Container(
                alignment: Alignment.center,
                child: Text(
                  '${commnets.length - 3} More Reviews',
                  style: TextStyle(
                    color: Colors.blue,
                  ),
                ),
              ),
            ),
          // Divider(),
          SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    AppConfig appConfig = AppConfig(context);
    return bookitem.length == 0
        ? Scaffold(
            appBar: AppBar(
              leading: IconButton(
                icon: Icon(Icons.arrow_back_ios),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              centerTitle: true,
              backgroundColor: gradientColor1,
            ),
            body: Center(
              child: CircularProgressIndicator(),
            ),
          )
        : ScreenUtilInit(
            builder: (context, child) => Scaffold(
              extendBodyBehindAppBar: true,
              resizeToAvoidBottomInset: false,
              appBar: AppBar(
                leading: IconButton(
                  icon: Icon(Icons.arrow_back_ios),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                centerTitle: true,
                title: Text(bookitem[0].authorName!),
                backgroundColor: gradientColor1,
              ),
              body: Container(
                height: MediaQuery.of(context).size.height,
                child: SingleChildScrollView(
                  controller: scrollViewController,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        height: 400.sp,
                        color: Colors.red,
                        child: Stack(
                          fit: StackFit.expand,
                          children: [
                            Container(
                              child: Image.network(
                                bookitem[0].bookPreview!,
                                fit: BoxFit.cover,
                              ),
                            ),
                            Container(
                              color: colors.isEmpty
                                  ? Colors.black26
                                  : colors[index].color.withOpacity(0.7),
                            ),
                            Container(
                              height: appConfig.rHP(15),
                              width: appConfig.rHP(47.74),
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment.bottomCenter,
                                  end: Alignment.topCenter,
                                  colors: [
                                    Colors.black.withOpacity(0.7),
                                    Colors.black12.withOpacity(0.001),
                                  ],
                                ),
                              ),
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Container(
                                  // color: Colors.red,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          bookitem[0].isFavourite == 1
                                              ? Container(
                                                  child: Icon(
                                                    Icons.favorite,
                                                    color: Colors.white,
                                                  ),
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            40),
                                                    color: Colors.white
                                                        .withOpacity(0.4),
                                                    boxShadow: [
                                                      BoxShadow(
                                                        blurRadius: 10,
                                                        color: Colors.black38,
                                                      ),
                                                    ],
                                                  ),
                                                  width: 50,
                                                  height: 50,
                                                )
                                              : GestureDetector(
                                                  onTap: () {
                                                    addtofav(widget.bookID);
                                                  },
                                                  child: Container(
                                                    child: Icon(
                                                      Icons.favorite_border,
                                                      color: Colors.white,
                                                    ),
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              40),
                                                      color: Colors.white
                                                          .withOpacity(0.4),
                                                      boxShadow: [
                                                        BoxShadow(
                                                          blurRadius: 10,
                                                          color: Colors.black38,
                                                        ),
                                                      ],
                                                    ),
                                                    width: 50,
                                                    height: 50,
                                                  ),
                                                ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              download();
                                            },
                                            child: Container(
                                              child: Icon(
                                                Icons.download,
                                                color: Colors.white,
                                              ),
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(40),
                                                color: Colors.white
                                                    .withOpacity(0.4),
                                                boxShadow: [
                                                  BoxShadow(
                                                    blurRadius: 10,
                                                    color: Colors.black38,
                                                  ),
                                                ],
                                              ),
                                              width: 50,
                                              height: 50,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                              ],
                            ),
                            Container(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
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
                                    height: 200,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(20),
                                      child: Image.network(
                                        bookitem[0].bookPreview!,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Container(
                                    child: Text(
                                      widget.bookname,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      if (bookitem[0].bookDescription!.isNotEmpty)
                        Container(
                          height: MediaQuery.of(context).size.height * 0.2,
                          color: Colors.black,
                          child: Row(
                            children: [
                              SizedBox(
                                width: 10,
                              ),
                              Stack(
                                children: [
                                  Container(
                                    height: 100,
                                    width: 5,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(40),
                                      color: Colors.white.withOpacity(0.4),
                                    ),
                                  ),
                                  Container(
                                    height: 40,
                                    width: 5,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(40),
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Container(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 20),
                                    child: Text(
                                      'Description :-',
                                      style: TextStyle(
                                        fontSize: 25,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    children: <Widget>[
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 20),
                                        width:
                                            MediaQuery.of(context).size.width -
                                                20,
                                        // color: Colors.red,
                                        child: Text(
                                          bookitem[0].bookDescription!,
                                          style: TextStyle(
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            InkWell(
                              onTap: () {
                                Navigator.of(context).push(
                                  CustomRoute(builder: (ctx) => PdfViewScreen(
                                        bookitem[0].link!,
                                        widget.type,
                                      ),
                                      ),
                                );
                              },
                              child: Container(
                                alignment: Alignment.center,
                                height: 50,
                                child: Text(
                                  'Start Reading',
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                width: MediaQuery.of(context).size.width * 0.75,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: Color.fromRGBO(46, 121, 183, 1),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      rate(),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                // color: Colors.red,
                                padding: EdgeInsets.only(left: 10, top: 10),
                                child: Text(
                                  'Popular Books',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 25,
                                  ),
                                ),
                              ),
                              Container(
                                // color: Colors.red,
                                padding: EdgeInsets.only(left: 10, top: 0),
                                child: Text(
                                  'Book which have been read most',
                                ),
                              )
                            ],
                          ),
                          Spacer(),
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (ctx) => LatestBookScreen(
                                      categoryid: '',
                                      categoryname: '',
                                      type: '',
                                      authorId: '',
                                      authorname: ''),
                                ),
                              );
                            },
                            child: Container(
                              padding: EdgeInsets.only(right: 10),
                              child: Text(
                                'See more',
                                style: TextStyle(
                                  fontSize: 19,
                                  decoration: TextDecoration.underline,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                      Container(
                        height: 300,
                        child: popular(),
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
  }
}
