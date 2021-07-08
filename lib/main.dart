import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:quizmaker/helper/functions.dart';
import 'package:quizmaker/views/home.dart';
import 'package:quizmaker/views/signin.dart';

void main()async {
    WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MyApp());
}


class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _isLoggedin = false;
  
  @override
  void initState() {
    checkUserLogginStatus();
    super.initState();
  }

  checkUserLogginStatus()async{
    HelperFuncitons.getUserLoggedInDetails().then((value) {
      setState(() {
        _isLoggedin = value;
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        
        primarySwatch: Colors.blue,
      ),
      home:(_isLoggedin ?? false )? Home():  Signin(),
    );
  }
}
