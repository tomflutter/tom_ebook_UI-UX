import 'package:ebook/Models/categoryModel.dart';
import 'package:ebook/NetworkApi/NetworkApi.dart';
import 'package:ebook/Screens/latestBookScreen.dart';
import 'package:ebook/customroute.dart';
import 'package:flutter/material.dart';

class CategoryScreen extends StatefulWidget {
  @override
  _CategoryScreenState createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  NetworkApi networkApi = NetworkApi();
  @override
  void initState() {
    super.initState();
    getcategory();
  }

  // ignore: deprecated_member_use
  List<CategoryItem> category = [];
  void getcategory() async {
    await networkApi.getcategory();
    category = CategoryModel.list;
    setState(() {});
  }

  Color selectedColour(int position) {
    Color? c;
    if (position % 3 == 0) c = Color.fromRGBO(132, 208, 253, 1);
    if (position % 3 == 1) c = Color.fromRGBO(189, 176, 251, 1);
    if (position % 3 == 2) c = Color.fromRGBO(133, 248, 213, 1);
    return c!;
  }

  Widget popular() {
    return Container(
      padding: EdgeInsets.only(top: 10),
      height: MediaQuery.of(context).size.height,
      // color: Colors.black,
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 200,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 20,
          mainAxisSpacing: 0,
          mainAxisExtent: 200,
        ),
        itemCount: category.length,
        itemBuilder: (ctx, i) {
          return Column(
            children: <Widget>[
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    CustomRoute(
                      builder: (ctx) =>
                          LatestBookScreen(
                        categoryid: category[i].categoryId!,
                        categoryname: category[i].categoryName!,
                        type: 'Category', authorId: '', authorname: '',
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
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Spacer(),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            child: Text(
                              category[i].categoryName!.length > 25
                                  ? category[i]
                                          .categoryName
                                          .toString()
                                          .substring(0, 20) +
                                      '...'
                                  : category[i].categoryName!,
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
                      right: 40,
                      child: Container(
                        height: 120,
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
                            category[i].categoryImage!,
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
                              Icons.book,
                              color: Color.fromRGBO(46, 121, 183, 1),
                            ),
                            Container(
                              child: Text(
                                category[i].books.toString(),
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
        title: Text('Categories'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        backgroundColor: Color.fromRGBO(46, 121, 183, 1),
      ),
      body: popular(),
    );
  }
}
