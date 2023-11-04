import 'package:ebook/Screens/signin/signin.dart';
import 'package:ebook/behaviour.dart';
import 'package:ebook/bg.dart';
import 'package:ebook/customroute.dart';
import 'package:ebook/staticData.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OnboardingScreen extends StatefulWidget {
  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final int numPages = 3;
  final PageController pageController = PageController(initialPage: 0);
  int currentPage = 0;

  List<Widget> PageIndicator() {
    List<Widget> list = [];
    for (int i = 0; i < numPages; i++) {
      list.add(i == currentPage ? indicator(true) : indicator(false));
    }
    return list;
  }

  Widget indicator(bool isActive) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 150),
      margin: EdgeInsets.symmetric(horizontal: 8.0),
      height: 8.0,
      width: isActive ? 24.0 : 16.0,
      decoration: BoxDecoration(
        color: isActive
            ? Color.fromRGBO(46, 121, 183, 1)
            : Color.fromRGBO(46, 121, 183, 1).withOpacity(0.4),
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
    );
  }

  // ignore: unused_element
  Widget indicators(bool isActive) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 150),
      margin: EdgeInsets.symmetric(horizontal: 8.0),
      height: 8.0,
      width: isActive ? 24.0 : 16.0,
      decoration: BoxDecoration(
        color: Color.fromRGBO(46, 121, 183, 1),
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(builder: (BuildContext context, Widget? child) {
      return Scaffold(
        body: AnnotatedRegion<SystemUiOverlayStyle>(
          value: SystemUiOverlayStyle.light,
          child: Container(
            decoration: BoxDecoration(color: Colors.white),
            child: Bg(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 0.0),
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: MediaQuery.of(context).padding.top,
                    ),
                    MediaQuery.of(context).size.height > 850
                        ? SizedBox(
                      height: 20,
                    )
                        : Container(),
                    Container(
                      height: MediaQuery.of(context).size.height * 0.8,
                      child: ScrollConfiguration(
                        behavior: MyBehavior(),
                        child: PageView(
                          physics: ClampingScrollPhysics(),
                          controller: pageController,
                          onPageChanged: (int page) {
                            setState(() {
                              currentPage = page;
                            });
                          },
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.all(0.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Center(
                                    child: Image(
                                      image: AssetImage(
                                        StaticData.imagepath +
                                            'onboarding0.png',
                                      ),
                                      height: 250.h,
                                      width: 250.h,
                                    ),
                                  ),
                                  SizedBox(height: 30.h),
                                  Container(
                                    padding: EdgeInsets.only(left: 20),
                                    width: double.infinity,
                                    child: Text(
                                      'Explore\nLearn & Save',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontFamily: 'CM Sans Serif',
                                        fontWeight: FontWeight.bold,
                                        fontSize: 22.sp,
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 15.h),
                                  Container(
                                    margin: EdgeInsets.only(left: 20),
                                    height: 5.h,
                                    width: 100.h,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(40),
                                      color: Color.fromRGBO(46, 121, 183, 1),
                                    ),
                                  ),
                                  SizedBox(height: 15.h),
                                  Container(
                                    padding: EdgeInsets.only(left: 20),
                                    child: Text(
                                      'Lorem ipsum dolor sit amet, consect adipiscing elit, sed do eiusmod tempor incididunt ut labore et.',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 16.h,
                                        height: 1.2,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(0.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Center(
                                    child: Image(
                                      image: AssetImage(
                                        StaticData.imagepath +
                                            'onboarding0.png',
                                      ),
                                      height: 250.h,
                                      width: 250.h,
                                    ),
                                  ),
                                  SizedBox(height: 30.h),
                                  Container(
                                    padding: EdgeInsets.only(left: 20),
                                    child: Text(
                                      'Stay Update',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontFamily: 'CM Sans Serif',
                                        fontWeight: FontWeight.bold,
                                        fontSize: 22.sp,
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 15.h),
                                  Container(
                                    margin: EdgeInsets.only(left: 20),
                                    height: 5.h,
                                    width: 100.h,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(40),
                                      color: Color.fromRGBO(46, 121, 183, 1),
                                    ),
                                  ),
                                  SizedBox(height: 15.0),
                                  Container(
                                    padding: EdgeInsets.only(left: 20),
                                    child: Text(
                                      'Lorem ipsum dolor sit amet, consect adipiscing elit, sed do eiusmod tempor incididunt ut labore et.',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 16.h,
                                        height: 1.2,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(0.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Center(
                                    child: Image(
                                      image: AssetImage(
                                        StaticData.imagepath +
                                            'onboarding0.png',
                                      ),
                                      height: 250.h,
                                      width: 250.h,
                                    ),
                                  ),
                                  SizedBox(height: 30.h),
                                  Container(
                                    padding: EdgeInsets.only(left: 20),
                                    child: Text(
                                      'Keep Reading\nyou\'ll fall in love',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontFamily: 'CM Sans Serif',
                                        fontWeight: FontWeight.bold,
                                        fontSize: 22.sp,
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 15.h),
                                  Container(
                                    margin: EdgeInsets.only(left: 20),
                                    height: 5.h,
                                    width: 100.h,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(40),
                                      color: Color.fromRGBO(46, 121, 183, 1),
                                    ),
                                  ),
                                  SizedBox(height: 15.0),
                                  Container(
                                    padding: EdgeInsets.only(left: 20),
                                    child: Text(
                                      'Lorem ipsum dolor sit amet, consect adipiscing elit, sed do eiusmod tempor incididunt ut labore et.',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 16.h,
                                        height: 1.2,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: PageIndicator(),
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    currentPage != numPages - 1
                        ? Expanded(
                      child: Align(
                        alignment: FractionalOffset.bottomRight,
                        // ignore: deprecated_member_use
                        child: TextButton(
                          onPressed: () {
                            pageController.nextPage(
                              duration: Duration(milliseconds: 500),
                              curve: Curves.easeIn,
                            );
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                alignment: Alignment.centerRight,
                                // ignore: deprecated_member_use
                                child: TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pushReplacement(
                                      CustomRoute(
                                        builder: (ctx) => LoginScreen(),
                                      ),
                                    );
                                  },
                                  child: Text(
                                    'Skip',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 20.0,
                                    ),
                                  ),
                                ),
                              ),
                              Spacer(),
                              Text(
                                'Next',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 22.0,
                                ),
                              ),
                              SizedBox(width: 10.0),
                              Icon(
                                Icons.arrow_forward,
                                color: Colors.black,
                                size: 30.0,
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                        : Text(''),
                  ],
                ),
              ),
            ),
          ),
        ),
        bottomSheet: currentPage == numPages - 1
            ? Container(
          alignment: Alignment.center,
          height: 100.0,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
            color: Color.fromRGBO(46, 121, 183, 1),
          ),
          width: double.infinity,
          child: GestureDetector(
            onTap: () {
              Navigator.of(context).pushReplacement(
                CustomRoute(
                  builder: (ctx) => LoginScreen(),
                ),
              );
            },
            child: Center(
              // padding: EdgeInsets.only(bottom: 30.0),
              child: Text(
                'Get started',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        )
            : Text(''),
      );
    },
    );
  }
}