import 'package:femv2/Screens/splash_screen.dart';
import 'package:femv2/firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'tasbih.dart';
import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';

void  main() async {
  try{
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform);


  }catch (e){

  }
  runApp(MyApp());
    }






class MyApp extends StatefulWidget {
  static final title = 'FEM';

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List screens = [
    Tasbih(),
    const Center(child: const Text('2'),),
    const Center(child: const Text('3'),),
    const Center(child: const Text('4'),),
  ];

  @override
  Widget build(BuildContext context) {

    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'لكل مسلم',
        theme: FlexThemeData.light(
          colorScheme: ColorScheme.light(
            background: Color.fromARGB(255, 255, 255, 255),
            primary: Colors.grey[300]!,
            secondary: Colors.grey[400]!,

          ),
          scheme: FlexScheme.indigoM3,
          surfaceMode: FlexSurfaceMode.levelSurfacesLowScaffold,
          blendLevel: 7,
          subThemesData: const FlexSubThemesData(
            blendOnLevel: 10,
            blendOnColors: false,
            useM2StyleDividerInM3: true,
            navigationBarIndicatorOpacity: 0.14,
            navigationBarBackgroundSchemeColor: SchemeColor.onPrimaryContainer,
          ),
          visualDensity: FlexColorScheme.comfortablePlatformDensity,
          useMaterial3: true,
          swapLegacyOnMaterial3: true,
          // To use the playground font, add GoogleFonts package and uncomment
          fontFamily: "Jannat",

        ),
        darkTheme: FlexThemeData.dark(
          colorScheme: ColorScheme.dark(
            background: Colors.black,
              primary: Colors.grey[800]!,
            secondary: Colors.grey[500]!,

          ),
          scheme: FlexScheme.indigoM3,
          surfaceMode: FlexSurfaceMode.highBackgroundLowScaffold,
          blendLevel: 13,
          appBarElevation: 0.5,
          subThemesData: const FlexSubThemesData(
            blendOnLevel: 20,
            useM2StyleDividerInM3: true,
            navigationBarIndicatorOpacity: 0.14,
            navigationBarBackgroundSchemeColor: SchemeColor.onPrimary,
          ),

          visualDensity: FlexColorScheme.comfortablePlatformDensity,
          useMaterial3: true,
          swapLegacyOnMaterial3: true,
          // To use the Playground font, add GoogleFonts package and uncomment
          fontFamily:"Jannat",
        ),

// If you do not have a themeMode switch, uncomment this line
// to let the device system mode control the theme mode:
// testr zfafa
 themeMode: ThemeMode.dark,


        home: StreamBuilder<User?>(
          stream: FirebaseAuth.instance.userChanges(),
          builder: (context, snapshot) {
            if (snapshot.hasData){
              return Tasbih();
            } else {
              return Tasbih();
            }
          }
      )

    );
  }
}
/*
 StreamBuilder<User?>(
        stream: FirebaseAuth.instance.userChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData){
            return Tasbih();
    } else {
            return Splashscreen();
          }
        }
      )
 */