import 'package:flutter/material.dart';
import 'package:projeto_dev_disp_mob/controllers/trail_controller.dart';
import 'package:projeto_dev_disp_mob/controllers/user_controller.dart';
import 'package:projeto_dev_disp_mob/models/trail_model.dart';
import 'package:provider/provider.dart';

class EditTrailPage extends StatefulWidget {
  final Trail trail;
  const EditTrailPage({super.key, required this.trail});

  @override
  State<EditTrailPage> createState() => _EditTrailPageState();
}

class _EditTrailPageState extends State<EditTrailPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _nameController.text = widget.trail.name;
    _descriptionController.text = widget.trail.description;
  }

  @override
  Widget build(BuildContext context) {
    final trailProvider = Provider.of<TrailController>(context);
    final userProvider = Provider.of<UserController>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Updating Record'),
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
                trailProvider
                    .updateTrail(
                  widget.trail.id!,
                  userProvider.loggedUser!.uid!,
                  userProvider.loggedUser!.username,
                  _nameController.text,
                  _descriptionController.text,
                  widget.trail.distance,
                  widget.trail.elevation,
                  widget.trail.maxElevation,
                  widget.trail.duration,
                  widget.trail.createdAt,
                  widget.trail.points,
                  widget.trail.coments,
                  widget.trail.images,
                )
                    .then((value) {
                  if (value == false) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content:
                            Text('An error ocurred while updating the Trail!'),
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
