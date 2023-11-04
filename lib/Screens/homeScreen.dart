import 'package:ebook/Models/Mostpopular.dart';
import 'package:ebook/Models/author.dart';
import 'package:ebook/Models/categoryModel.dart';
import 'package:ebook/Models/continueReading.dart';
import 'package:ebook/NetworkApi/NetworkApi.dart';
import 'package:ebook/Screens/categoryScreen.dart';
import 'package:ebook/Screens/sidemenu.dart';
import 'package:ebook/Widgets/category.dart';
import 'package:ebook/Widgets/continuereading.dart';
import 'package:ebook/Widgets/tabs.dart';
import 'package:ebook/Screens/latestBookScreen.dart';
import 'package:ebook/staticData.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shrink_sidemenu/shrink_sidemenu.dart';

class HomeScreens extends StatefulWidget {
  @override
  _HomeScreensState createState() => _HomeScreensState();
}

class _HomeScreensState extends State<HomeScreens> {
  final GlobalKey<SideMenuState> sideMenuKey = GlobalKey<SideMenuState>();
  NetworkApi networkApi = NetworkApi();

  String greeting() {
    var hour = DateTime.now().hour;
    if (hour < 12) {
      return 'Good Morning';
    }
    if (hour < 17) {
      return 'Good Afternoon';
    }
    return 'Good Evening';
  }

  @override
  void initState() {
    super.initState();
    continuereading();
    category();
    gettabs();
  }

  List<ContinueReadingItem> readingItem = [];

  void continuereading() async {
    await networkApi.getContinueReading();
    readingItem = ContinueReadingModel.list;
    setState(() {});
  }

  List<CategoryItem> categoryitem = [];

  void category() async {
    await networkApi.getcategory();
    categoryitem = CategoryModel.list;
    setState(() {});
  }

  List<AuthorItem> author = [];
  List<MostPopularItem> popular = [];

  void gettabs() async {
    await networkApi.getAuthor();
    author = AuthorModel.list;
    await networkApi.getMostpopular();
    popular = MostPopularModel.list;
    setState(() {});
  }

  Widget build(BuildContext context) {
    return ScreenUtilInit(
      builder: (context, child) => SideMenu(
        key: sideMenuKey,
        background: Color.fromRGBO(96, 159, 193, 1),
        menu: Sidemenu(),
        type: SideMenuType.shrinkNSlide,
        child: Scaffold(
          appBar: AppBar(
            title: Text('Ebook'),
            backgroundColor: Color.fromRGBO(46, 121, 183, 1),
            elevation: 0,
            leading: IconButton(
              onPressed: () {
                final state = sideMenuKey.currentState;
                if (state!.isOpened)
                  state..closeSideMenu();
                else
                  state.openSideMenu();
              },
              icon: Icon(
                Icons.menu,
              ),
            ),
          ),
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(46, 121, 183, 1),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(40),
                      bottomRight: Radius.circular(40),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.only(left: 10),
                        child: Text(
                          greeting(),
                          style: TextStyle(
                            fontSize: 28,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 10),
                        child: Text(
                          StaticData.username,
                          style: TextStyle(
                            fontSize: 28,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Container(
                        alignment: Alignment.center,
                        child: Container(
                          height: 60,
                          width: MediaQuery.of(context).size.width * 0.9,
                          decoration: BoxDecoration(
                            color: Colors.black38,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              GestureDetector(
                                onTap: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                        builder: (ctx) => LatestBookScreen(categoryid: '', categoryname: '', type: '', authorId: '', authorname: ''),
                                        ),
                                  );
                                },
                                child: Container(
                                  child: Row(
                                    children: [
                                      Image.asset(
                                        StaticData.imagepath + 'book.png',
                                        scale: 1.6,
                                      ),
                                      SizedBox(
                                        width: 8,
                                      ),
                                      Text(
                                        'Latest',
                                        style: TextStyle(
                                          fontSize: 17,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                height: 30,
                                child: VerticalDivider(
                                  color: Colors.white,
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                        builder: (ctx) => CategoryScreen(),
                                        ),
                                  );
                                },
                                child: Container(
                                  alignment: Alignment.center,
                                  child: Row(
                                    children: [
                                      Image.asset(
                                        StaticData.imagepath + 'subfolder.png',
                                        scale: 1.6,
                                      ),
                                      SizedBox(
                                        width: 8,
                                      ),
                                      Text(
                                        'Category',
                                        style: TextStyle(
                                          fontSize: 17,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                height: 30,
                                child: VerticalDivider(
                                  color: Colors.white,
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (ctx) => LatestBookScreen(
                                        type: 'Favourite',
                                        categoryid: '',
                                        categoryname: '',
                                        authorId: '',
                                        authorname: '',
                                      ),
                                    ),
                                  );
                                },
                                child: Container(
                                  child: Row(
                                    children: [
                                      Image.asset(
                                        StaticData.imagepath + 'favourite.png',
                                        scale: 1.6,
                                      ),
                                      SizedBox(
                                        width: 8,
                                      ),
                                      Text(
                                        'Favourite',
                                        style: TextStyle(
                                          fontSize: 17,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                    ],
                  ),
                ),
                if (readingItem.isNotEmpty) ContinueReadingScreen(readingItem),
                CategoryWidget(categoryitem),
                Tabs(author, popular)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
