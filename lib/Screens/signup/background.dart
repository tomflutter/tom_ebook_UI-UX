import 'package:ebook/staticData.dart';
import 'package:flutter/material.dart';

class BackGround extends StatelessWidget {
  final Widget child; // Tandai child sebagai final
  BackGround({
    Key? key,
    required this.child,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      height: size.height,
      width: double.infinity,
      child: Stack(
        fit: StackFit.expand,
        alignment: Alignment.center,
        children: <Widget>[
          Positioned(
            top: -30,
            right: 100,
            child: Column(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * 0.5,
                  child: Image.asset(
                    StaticData.imagepath + 'bg1.png',
                    // fit: BoxFit.cover,
                  ),
                ),
              ],
            ),
          ),
          child,
        ],
      ),
    );
  }
}
