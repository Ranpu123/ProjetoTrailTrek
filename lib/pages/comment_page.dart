import 'package:comment_box/comment/comment.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

//example base of pub.dev
class CommentPage extends StatefulWidget {
  @override
  _CommentPage createState() => _CommentPage();
}

class _CommentPage extends State<CommentPage> {
  final formKey = GlobalKey<FormState>();
  final TextEditingController commentController = TextEditingController();
  List filedata = [
    {
      'name': 'teste da silva',
      'pic': 'images/avatar.png',
      'message': 'I love this trail!',
      'date': '2021-01-01 12:00:00'
    },
    {
      'name': 'teste pereira',
      'pic': 'images/avatar.png',
      'message': 'Very cool',
      'date': '2021-01-01 12:00:00'
    },
  ];

  Widget commentChild(data) {
    return ListView(
      children: [
        for (var i = 0; i < data.length; i++)
          Padding(
            padding: const EdgeInsets.fromLTRB(2.0, 5.0, 2.0, 0.0),
            child: ListTile(
              leading: GestureDetector(
                onTap: () async {
                  // Display the image in large form.
                  print("Comment Clicked");
                },
                child: Container(
                  height: 50.0,
                  width: 50.0,
                  decoration: const BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.all(Radius.circular(50)),
                  ),
                  child: CircleAvatar(
                    radius: 50,
                    backgroundImage: CommentBox.commentImageParser(
                        imageURLorPath: data[i]['pic']),
                  ),
                ),
              ),
              title: Text(
                data[i]['name'],
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(data[i]['message']),
              trailing: Text(
                data[i]['date'],
                style: const TextStyle(fontSize: 10),
              ),
            ),
          )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        titleSpacing: 0,
        leading: const Icon(
          Icons.terrain,
        ),
        title: Text(
          'Trails',
          style: GoogleFonts.roboto(fontWeight: FontWeight.bold),
        ),
      ),
      body: CommentBox(
        userImage:
            CommentBox.commentImageParser(imageURLorPath: 'images/avatar.png'),
        labelText: 'Write a comment...',
        errorText: 'Comment cannot be blank',
        withBorder: false,
        sendButtonMethod: () {
          if (formKey.currentState!.validate()) {
            print(commentController.text);
            setState(() {
              var value = {
                'name': 'Username',
                'pic': 'images/avatar.png',
                'message': commentController.text,
                'date': '2021-01-01 12:00:00'
              };
              filedata.insert(0, value);
            });
            commentController.clear();
            FocusScope.of(context).unfocus();
          } else {
            print("Not validated");
          }
        },
        formKey: formKey,
        commentController: commentController,
        backgroundColor: Colors.white,
        textColor: Colors.black,
        sendWidget: const Icon(
          Icons.send_sharp,
          size: 30,
          color: Colors.black,
          shadows: <Shadow>[
            Shadow(
              color: Colors.grey,
              offset: Offset(2.0, 2.0),
              blurRadius: 3.0,
            ),
          ],
        ),
        child: commentChild(filedata),
      ),
    );
  }
}
