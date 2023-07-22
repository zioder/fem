
import 'package:femv2/constants.dart';
import 'package:femv2/size_config.dart';
import 'package:flutter/material.dart';


class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    Sizeconfig().init(context);
    return Container(
      child: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              color: Colors.red,
              gradient: LinearGradient(colors:  [primaryColor,lightprimaryColor],begin: Alignment.bottomLeft,end: Alignment.topRight)
            ),
          ),
          Center(
            child: Image.asset('assets/images/ShortLogo.png'),
          )
        ],
      ),
    );
  }

  ElevatedButton defaultbutton(Function function,String text) {
    return ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30)
                ), backgroundColor: primaryColor,
                  fixedSize: const Size.fromWidth(200),
                  padding: const EdgeInsets.all(10),
              ),
              child: Text(text),
              onPressed: function()
            );
  }
}
