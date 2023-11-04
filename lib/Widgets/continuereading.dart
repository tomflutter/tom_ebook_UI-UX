import 'package:ebook/Screens/latestBookScreen.dart';
import 'package:ebook/Screens/viewbook.dart';
import 'package:ebook/customroute.dart';
import 'package:flutter/material.dart';

class ContinueReadingScreen extends StatelessWidget {
  final List readingItem;

  ContinueReadingScreen(this.readingItem);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              children: [
                Container(
                  padding: EdgeInsets.only(left: 4, top: 10),
                  child: Text(
                    'Continue Reading',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                    ),
                  ),
                ),
                Container(
                  // color: Colors.red,
                  padding: EdgeInsets.only(left: 12, top: 0),
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
                      type: 'Continue',
                      categoryid: '',
                      categoryname: '',
                      authorId: '',
                      authorname: '',
                    ),
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
          // color: Colors.red,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: readingItem.length,
            itemBuilder: (ctx, i) {
              return GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    CustomRoute(
                      builder: (ctx) => ViewBookScreen(
                        readingItem[i].bookTitle,
                        readingItem[i].bookId,
                        readingItem[i].bookPreview,
                        readingItem[i].pdf,
                        type: '',
                      ),
                    ),
                  );
                },
                child: Container(
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 10, vertical: 14),
                    // height: 100,
                    // aspectRatio: 3 / 7,
                    child: Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                blurRadius: 10,
                                color: Colors.black12,
                              ),
                            ],
                          ),
                          height: 200,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.network(
                              readingItem[i].bookPreview,
                              fit: BoxFit.cover,
                              scale: 3,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 9,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              alignment: Alignment.center,
                              width: 120,
                              child: Text(
                                readingItem[i].bookTitle.length > 10
                                    ? readingItem[i]
                                            .bookTitle
                                            .toString()
                                            .substring(0, 10) +
                                        '...'
                                    : readingItem[i].bookTitle,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                              ),
                            ),
                            Container(
                              width: 120,
                              child: Text(
                                // readingItem[i].authorName.length > 6
                                //     ? readingItem[i]
                                //             .authorName
                                //             .toString()
                                //             .substring(0, 8) +
                                //         '...'
                                //     :
                                readingItem[i].authorName,
                                textAlign: TextAlign.center,

                                style: TextStyle(
                                    // fontWeight: FontWeight.bold,
                                    // fontSize: 20,
                                    ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
