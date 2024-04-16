import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import 'package:projeto_dev_disp_mob/controllers/trail_controller.dart';
import 'package:projeto_dev_disp_mob/controllers/user_controller.dart';
import 'package:provider/provider.dart';

class RecordTrailPage extends StatefulWidget {
  const RecordTrailPage({super.key});

  @override
  State<RecordTrailPage> createState() => _RecordTrailPageState();
}

class _RecordTrailPageState extends State<RecordTrailPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final trailProvider = Provider.of<TrailController>(context);
    final userProvider = Provider.of<UserController>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Saving Record'),
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Trail name',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'The trail name can\'t be null.';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: _descriptionController,
                maxLines: 4,
                decoration: const InputDecoration(
                  labelText: 'Description',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'The description can\'t be null.';
                  }
                  return null;
                },
              ),
              const Spacer(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                trailProvider.createTrail(
                  'userProvider.loggedUser!.uid!',
                  userProvider.loggedUser!.username,
                  _nameController.text,
                  _descriptionController.text,
                  7.19,
                  308,
                  500,
                  60,
                  const [
                    LatLng(-25.02095165946743, -50.060495950131404),
                    LatLng(-25.020004932573844, -50.06153520675037),
                    LatLng(-25.01989070603476, -50.0626116730901),
                    LatLng(-25.016612033444382, -50.064359654031634),
                    LatLng(-25.015100274658174, -50.061776307357114),
                    LatLng(-25.015430836906418, -50.06051030475191),
                    LatLng(-25.014137750102453, -50.060810712149745),
                    LatLng(-25.00853127629199, -50.06106123111519),
                    LatLng(-25.013747450868873, -50.05436702588947),
                    LatLng(-25.017688050213025, -50.04301755157397),
                    LatLng(-25.014663120094298, -50.04050948002432),
                    LatLng(-25.01569323979217, -50.04327016288908),
                  ],
                ).then((value) {
                  if (value == false) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content:
                            Text('An error ocurred while saving the Trail!'),
                      ),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Trail saved succesfully!'),
                      ),
                    );
                    Navigator.pop(context);
                  }
                });
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.black,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
            ),
            child: const Text('Save'),
          ),
        ),
      ),
    );
  }
}
