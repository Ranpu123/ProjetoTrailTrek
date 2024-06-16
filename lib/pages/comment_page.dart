import 'package:comment_box/comment/comment.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:projeto_dev_disp_mob/controllers/trail_controller.dart';
import 'package:projeto_dev_disp_mob/controllers/user_controller.dart';
import 'package:projeto_dev_disp_mob/models/coments_model.dart';
import 'package:projeto_dev_disp_mob/models/trail_model.dart';
import 'package:projeto_dev_disp_mob/models/user_model.dart';
import 'package:provider/provider.dart';

class CommentPage extends StatefulWidget {
  final Trail trail;
  const CommentPage({super.key, required this.trail});

  @override
  _CommentPage createState() => _CommentPage();
}

class _CommentPage extends State<CommentPage> {
  final formKey = GlobalKey<FormState>();
  final TextEditingController commentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final userController = Provider.of<UserController>(context);
    final trailController = Provider.of<TrailController>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        titleSpacing: 0,
        leading: const Icon(
          Icons.terrain,
        ),
        title: Text('Trails'),
      ),
      body: CommentBox(
        userImage: CommentBox.commentImageParser(
            imageURLorPath: userController.loggedUser!.profileImage ??
                'https://firebasestorage.googleapis.com/v0/b/projdevdispmob.appspot.com/o/imagem_2024-05-28_142532369.png?alt=media&token=b0da3897-86c1-4f73-9056-25c25ea0ba09'),
        labelText: 'Write a comment...',
        errorText: 'Comment cannot be blank',
        withBorder: false,
        sendButtonMethod: () async {
          if (formKey.currentState!.validate()) {
            //User user = await userController.getCurrentUser();
            Coment comment = Coment(
              uid: userController.loggedUser!.uid!, //as String
              username: userController.loggedUser!.username,
              description: commentController.text,
              rating: 5.0,
              createdAt: DateTime.now(),
            );
            bool success =
                await trailController.addComment(widget.trail, comment);
            if (success) {
              commentController.clear();
              FocusScope.of(context).unfocus();
              setState(() {});
            } else {
              print('Erro ao adicionar comentário.');
            }
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
        child: FutureBuilder<Trail?>(
          future: trailController.getTrail(widget.trail.id!), //as String
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError || snapshot.data == null) {
              return Text('Erro ao carregar comentários');
            } else {
              return ListView(
                children: snapshot.data!.coments
                    .map((comment) => Padding(
                          padding:
                              const EdgeInsets.fromLTRB(2.0, 5.0, 2.0, 0.0),
                          child: ListTile(
                            leading: GestureDetector(
                              onTap: () async {
                                print("Comment Clicked");
                              },
                              child: Container(
                                height: 50.0,
                                width: 50.0,
                                decoration: const BoxDecoration(
                                  color: Colors.black,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(50)),
                                ),
                                child: CircleAvatar(
                                  radius: 50,
                                  backgroundImage: CommentBox.commentImageParser(
                                      imageURLorPath: userController
                                              .loggedUser!.profileImage ??
                                          'https://firebasestorage.googleapis.com/v0/b/projdevdispmob.appspot.com/o/imagem_2024-05-28_142532369.png?alt=media&token=b0da3897-86c1-4f73-9056-25c25ea0ba09'),
                                ),
                              ),
                            ),
                            title: Text(
                              comment.username,
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            ),
                            subtitle: Text(comment.description ?? ''),
                            trailing: Text(
                              DateFormat('yyyy-MM-dd HH:mm')
                                  .format(comment.createdAt),
                              style: const TextStyle(fontSize: 10),
                            ),
                          ),
                        ))
                    .toList(),
              );
            }
          },
        ),
      ),
    );
  }
}
