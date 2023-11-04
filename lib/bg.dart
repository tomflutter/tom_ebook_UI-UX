import 'package:ebook/staticData.dart';
import 'package:flutter/material.dart';

class Bg extends StatelessWidget {
  final Widget child; // Ini diperbarui menjadi 'final'

  Bg({
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
            left: 100,
            child: Column(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * 0.5,
                  child: Image.asset(
                    StaticData.imagepath + 'bg3.png',
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
