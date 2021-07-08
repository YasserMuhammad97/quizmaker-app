import 'package:flutter/material.dart';
import 'package:quizmaker/services/database.dart';
import 'package:quizmaker/views/create_quiz.dart';
import 'package:quizmaker/views/play_quiz.dart';
import 'package:quizmaker/widgets/widget.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Stream quizStream;
  DatabaseService databaseService = new DatabaseService();

  Widget quizList() {
    return Container(
        margin: EdgeInsets.symmetric(horizontal: 24),
        child: StreamBuilder(
            stream: quizStream,
            builder: (context, snapshot) {
              return snapshot.data == null
                  ? Container()
                  : ListView.builder(
                      itemCount: snapshot.data.docs.length,
                      itemBuilder: (context, index) {
                        return QuizTile(
                            imgUrl:
                                snapshot.data.docs[index].data()["quizImgUrl"],
                            title:
                                snapshot.data.docs[index].data()["quizTitle"],
                            desc: snapshot.data.docs[index].data()["quizDesc"]
                            ,
                            quizId:snapshot.data.docs[index].data()["quizId"]  );
                      });
            }));
  }

  @override
  void initState() {
    databaseService.getQuizesData().then((val) {
      setState(() {
        quizStream = val;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: appBar(context),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        brightness: Brightness.light,
      ),
      body: quizList(),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CreateQuiz(),
            ),
          );
        },
      ),
    );
  }
}

class QuizTile extends StatelessWidget {
  final String imgUrl;
  final String title;
  final String desc;
  final String quizId;

  QuizTile({@required this.imgUrl, @required this.title, @required this.desc,@required this.quizId});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context)=> PlayQuiz(quizId)));

      },
      child: Container(
        margin: EdgeInsets.only(bottom: 8),
        height: 150,
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                imgUrl,
                width: MediaQuery.of(context).size.width - 48,
                fit: BoxFit.cover,
              ),
            ),
            Container(
              decoration: BoxDecoration(
                  color: Colors.black26, borderRadius: BorderRadius.circular(8)),
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    title,
                    style: TextStyle(color: Colors.white,fontSize: 17,fontWeight: FontWeight.w600),
                  ),
                  SizedBox(height: 6,),
                  Text(
                    desc,
                    style: TextStyle(color: Colors.white,fontSize: 14,fontWeight: FontWeight.w400),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
