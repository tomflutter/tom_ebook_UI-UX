import 'package:ebook/Screens/categoryScreen.dart';
import 'package:ebook/Screens/latestBookScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../customroute.dart';

class CategoryWidget extends StatelessWidget {
  final List category;
  CategoryWidget(this.category);
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      builder: (context, child) => Column(
        children: [
          Container(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.only(left: 10, top: 10),
                      child: Text(
                        'Category',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 22.sp,
                        ),
                      ),
                    ),
                    Container(
                      // color: Colors.red,
                      padding: EdgeInsets.only(left: 12, top: 0),
                      child: Text(
                        'List of book category wise',
                      ),
                    )
                  ],
                ),
                Spacer(),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (ctx) => CategoryScreen(),
                      ),
                    );
                  },
                  child: Container(
                    padding: EdgeInsets.only(right: 10),
                    child: Text(
                      'See more',
                      style: TextStyle(
                        fontSize: 17.sp,
                        decoration: TextDecoration.underline,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          Container(
            height: 140,
            // color: Colors.red,
            width: MediaQuery.of(context).size.width,
            child: GridView.builder(
              key: ValueKey(Colors.red),
              gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 160,
                childAspectRatio: 3 / 3,
                crossAxisSpacing: 0,
                mainAxisSpacing: 00,
                mainAxisExtent: 59,
              ),
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: category.length,
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                      CustomRoute(
                        builder: (ctx) =>
                            LatestBookScreen(
                          categoryid: category[index].categoryId,
                          categoryname: category[index].categoryName,
                          type: 'Category', authorId: '', authorname: '',
                        ),
                      ),
                    );
                  },
                  child: Container(
                    // height: 20,
                    child: Column(
                      children: [
                        Container(
                          padding: EdgeInsets.all(10),
                          alignment: Alignment.center,
                          margin: EdgeInsets.symmetric(
                            horizontal: 4,
                            vertical: 10,
                          ),
                          decoration: BoxDecoration(
                            border: Border.all(
                              width: 1,
                              color: Color.fromRGBO(46, 121, 183, 1),
                            ),
                            borderRadius: BorderRadius.circular(40),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                blurRadius: 10,
                                color: Colors.black12,
                              ),
                            ],
                          ),
                          child: Text(
                            category[index].categoryName,
                            style: TextStyle(
                              fontSize: 12.sp,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
