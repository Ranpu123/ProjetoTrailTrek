import 'package:flutter/material.dart';
import 'package:projeto_dev_disp_mob/controllers/trail_controller.dart';
import 'package:projeto_dev_disp_mob/models/trail_model.dart';
import 'package:provider/provider.dart';

class TrailDetailsPage extends StatefulWidget {
  final String id;
  const TrailDetailsPage({super.key, required this.id});

  @override
  State<TrailDetailsPage> createState() => _TrailDetailsPageState();
}

class _TrailDetailsPageState extends State<TrailDetailsPage> {
  late String id;
  late TrailController trailProvider;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      trailProvider = Provider.of<TrailController>(context, listen: false);
      id = widget.id;
    });
  }

  @override
  Widget build(BuildContext context) {
    Trail trail = Trail(
        uid: 'uid',
        username: 'username',
        name: 'name',
        distance: 0,
        elevation: 0,
        maxElevation: 0,
        duration: 0,
        createdAt: DateTime.now(),
        points: [],
        coments: [],
        images: []);

    trailProvider.getTrail(id).then((v) {
      if (v == null) {
        // Se o objeto `Trail` não for encontrado, exiba uma mensagem e redirecione o usuário
        Future.microtask(() {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('A trilha não foi encontrada.')),
          );
          Navigator.pop(context); // Redireciona o usuário para a tela anterior
        });
      } else {
        setState(() {
          trail = v;
        });
      }
    });

    return Scaffold(
      appBar: AppBar(
        leading: Icon(
          Icons.terrain,
          color: Colors.black,
        ),
        title: Text(trail.name),
      ),
    );
  }
}
