import 'package:ebook/Models/signinModel.dart';
import 'package:ebook/NetworkApi/NetworkApi.dart';
import 'package:ebook/Screens/signin/signin.dart';
import 'package:ebook/Screens/signup/background.dart';
import 'package:ebook/customroute.dart';
import 'package:ebook/dialog.dart';
import 'package:ebook/Screens/homeScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../staticData.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  NetworkApi networkApi = NetworkApi();
  TextEditingController passcontroller = TextEditingController();
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController usernamecontroller = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey();
  final GlobalKey<State> keyLoader = GlobalKey<State>();

  bool _showPassword = true;
  // ignore: deprecated_member_use
  List<SignInItem> data = [];

  onpress() async {
    if (!formKey.currentState!.validate()) {
      return;
    }
    formKey.currentState!.save();

String email = emailcontroller.text;
String password = passcontroller.text;

if (email.isEmpty || password.isEmpty) {
  return;
}
    Dialogs.showLoadingDialog(context, keyLoader);

    await networkApi
        .postSignup(
      emailcontroller.text,
      passcontroller.text,
      usernamecontroller.text,
    )
        .then((value) {
      setState(() {
        data = SignInModel.list;
        Navigator.of(keyLoader.currentContext!, rootNavigator: true).pop();
      });
    });
    try {
      if (data[0].userId == null) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('check Your credetials!')));
        return;
      }
    } on RangeError catch (_) {
      return ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Check Your Credentials!'),
          backgroundColor: Colors.redAccent,
        ),
      );
    }
    StaticData.userid = data[0].userId!;
    StaticData.username = data[0].userName!;
    sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences!.setBool("isfirst", false);
    sharedPreferences!.setString("name", data[0].userId!);
    sharedPreferences!.setString("username", data[0].userName!);
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (ctx) => HomeScreens(),
      ),
    );
  }

  SharedPreferences? sharedPreferences;
  // networkApi networkApi;
  @override
  void initState() {
    super.initState();
  }

  final FirebaseAuth auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();
  Future<User> signInWithGoogle(BuildContext context) async {
    Center(
      child: Container(
        height: 300,
        child: Card(
          child: Row(
            children: <Widget>[
              CircularProgressIndicator(),
              Text('Loading'),
            ],
          ),
        ),
      ),
    );
    GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();
    GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount!.authentication;
    Center(
      child: CircularProgressIndicator(),
    );
    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleSignInAuthentication.accessToken,
      idToken: googleSignInAuthentication.idToken,
    );
    User? user = (await auth.signInWithCredential(credential)).user;

    assert(!user!.isAnonymous);
    assert(await user!.getIdToken() != null);

    final User currentUser = auth.currentUser!;
    assert(user!.uid == currentUser.uid);
    googlesignin(
      user!.email!,
      user.displayName!,
    );

    return user;
  }

  googlesignin(
    String email,
    String name,
  ) async {
    if (mounted) {
      await networkApi.postGoogleSignin(email, name).then((value) {
        setState(() {
          data = SignInModel.list;
        });
      });
      try {
        if (data[0].userId == null) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text('check Your credetials!')));
          return;
        }
      } on RangeError catch (_) {
        return ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('User is Already Registered!'),
            backgroundColor: Colors.redAccent,
          ),
        );
      }
      StaticData.userid = data[0].userId!;
      StaticData.username = data[0].userName!;
      setState(() {});
      sharedPreferences = await SharedPreferences.getInstance();
      sharedPreferences!.setBool("isfirst", false);
      sharedPreferences!.setString("name", data[0].userId!);
      sharedPreferences!.setString("username", data[0].userName!);
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (ctx) => HomeScreens(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      builder: (context, child) => Scaffold(
        body: BackGround(
          child: Container(
            child: SingleChildScrollView(
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.5,
                    ),
                    Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: EdgeInsets.only(left: 10),
                            child: Text(
                              'Create Account',
                              style: TextStyle(
                                fontSize: 32.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            child: TextFormField(
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Email is Empty';
                                }
                                return null;
                              },
                              controller: emailcontroller,
                              decoration: InputDecoration(labelText: 'Email'),
                            ),
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            child: TextFormField(
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Username is Empty';
                                }
                                return null;
                              },
                              controller: usernamecontroller,
                              decoration:
                              InputDecoration(labelText: 'Username'),
                            ),
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            child: TextFormField(
                              controller: passcontroller,
                              obscureText: _showPassword,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Password is Empty';
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                labelText: 'Password',
                                suffixIcon: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      _showPassword = !_showPassword;
                                    });
                                  },
                                  icon: _showPassword
                                      ? FaIcon(
                                    FontAwesomeIcons.eye,
                                  )
                                      : FaIcon(
                                    FontAwesomeIcons.eyeSlash,
                                  ),
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.05,
                          ),
                          Row(
                            children: [
                              Container(
                                padding: EdgeInsets.only(left: 10),
                                child: Text(
                                  'Sign up',
                                  style: TextStyle(
                                    fontSize: 22.sp,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Spacer(),
                              GestureDetector(
                                onTap: () => signInWithGoogle(context),
                                child: Container(
                                  child: Image.asset(
                                    StaticData.imagepath + 'ic_google.png',
                                    scale: 4,
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              GestureDetector(
                                onTap: () {
                                  onpress();
                                },
                                child: Container(
                                  height: 40.h,
                                  width: 40.h,
                                  child: Icon(
                                    Icons.keyboard_arrow_right,
                                    size: 40,
                                    color: Colors.white,
                                  ),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(40),
                                    gradient: LinearGradient(
                                      begin: Alignment.topRight,
                                      end: Alignment.bottomLeft,
                                      colors: [
                                        Color.fromRGBO(23, 61, 92, 1),
                                        Color.fromRGBO(46, 121, 183, 1),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(
                                  CustomRoute(builder: (ctx) => LoginScreen()));
                            },
                            child: Container(
                              padding: EdgeInsets.only(left: 10),
                              child: Text(
                                'Sign In',
                                style: TextStyle(
                                  decoration: TextDecoration.underline,
                                  fontSize: 22.sp,
                                  fontWeight: FontWeight.bold,
                                ),
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
          ),
        ),
      ),
    );
  }
}
