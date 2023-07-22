import 'dart:ui';
import 'package:femv2/Screens/prayer_screen.dart';
import 'package:femv2/Screens/settings_screen.dart';
import 'package:femv2/constants.dart';
import 'package:flutter/material.dart';
import 'package:responsive_navigation_bar/responsive_navigation_bar.dart';
import 'Screens/HomeScreen.dart';
import 'Screens/tasbeehat_screen.dart';
class Tasbih extends StatefulWidget {
  const Tasbih({Key? key}) : super(key: key);

  @override
  _TasbihState createState() => _TasbihState();
}

class _TasbihState extends State<Tasbih> {
  int selectedIndex = 0;
  void changeTab() {
    if (mounted) setState(() {});
  }
  final Screens= [
    HomeScreen(),
    TabssehatScreen(),
    Container(),
    Container(child: Text('الزكاة'),),
    SettingsScreen()

  ];
  final destinationsNav = const <Widget>[
  NavigationDestination(
  icon: Icon(Icons.home),
  label: 'الرئيسية',
  ),
  NavigationDestination(
  icon: Icon(Icons.commute),
  label: 'التسبيح',
  ),
  NavigationDestination(
  icon: Icon(Icons.bookmark_border),
  label: 'الصلاة',
  ),
  NavigationDestination(
  icon: Icon(Icons.commute),
  label: 'الزكاة',
  ),
  NavigationDestination(
  icon: Icon(Icons.settings),
  label: 'الإعدادات',
  ),
  ];
  final destinationsRail= const <NavigationRailDestination>[
    NavigationRailDestination(
      icon: Icon(Icons.home),
      label: Text('الرئيسية')
    ),
    NavigationRailDestination(
      icon: Icon(Icons.commute),
      label: Text('التسبيح')
    ),
    NavigationRailDestination(
      icon: Icon(Icons.bookmark_border),
      label: Text('الصلاة'),
    ),
    NavigationRailDestination(
      icon: Icon(Icons.commute),
      label:Text( 'الزكاة'),
    ),
    NavigationRailDestination(
      icon: Icon(Icons.settings),
      label:Text('الإعدادات'),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    double displayWidth=MediaQuery.of(context).size.width;
    return displayWidth<=500 ?Scaffold(
      bottomNavigationBar: buildNavBarPhones(),
      backgroundColor: primaryColor,
      body: Screens[selectedIndex]
    ):Scaffold(
      backgroundColor: primaryColor,
      body: SafeArea(
        child: Row(
          children: [
            Padding(
              padding: EdgeInsets.all(20),
              child: Card(
                child: NavigationRail(
                  indicatorColor: primaryColor,
                  labelType: NavigationRailLabelType.selected,
                  groupAlignment: 1.0,
                  destinations: destinationsRail, selectedIndex: selectedIndex,onDestinationSelected:(int index) {
                  setState(() {
                    selectedIndex = index;
                  });
                }, ),
              ),
            ),
            Expanded(child: Screens[selectedIndex]),
            
          ],
        ),
      ),
    );
  }

  Padding buildNavBarPhones() {
    return Padding(
      padding: EdgeInsets.all(20),
      child: Card(
        
        
        child: Container(
          child: NavigationBar(
            labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
            selectedIndex: selectedIndex,
            indicatorColor: primaryColor,
            onDestinationSelected: (int index) {
  setState(() {
  selectedIndex = index;
  });
  },
              destinations:destinationsNav ),
        ),
      ),
    );
  }
}
class Tasbiha {

}


class TopBarFb3 extends StatelessWidget {
  final String title;
  final String upperTitle;
  final String name;
  const TopBarFb3({required this.title, required this.upperTitle,required this.name ,Key? key})
      : super(key: key);
  final primaryColor = const Color(0xff4338CA);
  final secondaryColor = const Color(0xff6D28D9);
  final accentColor = const Color(0xffffffff);
  final backgroundColor = const Color(0xffffffff);
  final errorColor = const Color(0xffEF4444);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width*0.9,
      height: 100,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
          gradient: LinearGradient(colors: [primaryColor, secondaryColor])),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          textDirection: TextDirection.rtl,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              textDirection: TextDirection.rtl,
              children: [
                Text(title, style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 14,
                        fontWeight: FontWeight.normal)),
                SizedBox(width: 10,),
                Text(name, style: const TextStyle(
                  color: superlightgreenColor,
                        fontSize: 20,
                        fontWeight: FontWeight.bold)),
              ],
            ),
            Text(upperTitle,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold))
          ],
        ),
      ),
    );
  }
}
class GlassCardFb1 extends StatelessWidget {
  final String text;
  final String subtitle;
  const GlassCardFb1({required this.text, required this.subtitle, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
        child: Container(
          width: 150.0,
          height: 100.0,
          decoration: BoxDecoration(
              border: Border.all(color: Colors.white, width: .25),
              borderRadius: BorderRadius.circular(15.0),
              color: Colors.grey.shade200.withOpacity(0.15)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(text,
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold)),
              const SizedBox(
                height: 3,
              ),
              Text(subtitle,
                  style: const TextStyle(
                      color: Colors.white54,
                      fontSize: 12,
                      fontWeight: FontWeight.normal)),
              const Text('00:05:48',style:TextStyle(
                color: Colors.white
              ),)
            ],
          ),
        ),
      ),
    );
  }
}
class PromoCard extends StatelessWidget {
  final String? tasbiha;
  final String? text ;
  const PromoCard({Key? key, this.text, this.tasbiha}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 150,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          gradient: const LinearGradient(
              colors: [Color(0xff53E88B), Color(0xff15BE77)])),
      child: Stack(
        children: [
          Opacity(
            opacity: .5,
            child: Image.network(
                "https://firebasestorage.googleapis.com/v0/b/flutterbricks-public.appspot.com/o/BACKGROUND%202.png?alt=media&token=0d003860-ba2f-4782-a5ee-5d5684cdc244",
                fit: BoxFit.cover),
          ),
           Align(
            alignment: Alignment.topRight,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                textDirection: TextDirection.rtl,
                children: [
                  Text('واصل اخر تسبيحة لك '),
                  Text(
                    text!,
                    style:  TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                        fontSize: 22,
                        fontWeight: FontWeight.bold),
                  ), Text(
                    tasbiha!,
                    style: const TextStyle(
                        color: Colors.blueGrey,
                        fontSize: 20,
                        fontWeight: FontWeight.w300),
                  ),

                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
