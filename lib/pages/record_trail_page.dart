import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:latlong2/latlong.dart';
import 'package:location/location.dart';
import 'package:projeto_dev_disp_mob/controllers/trail_controller.dart';
import 'package:projeto_dev_disp_mob/controllers/user_controller.dart';
import 'package:provider/provider.dart';

class RecordTrailPage extends StatefulWidget {
  final List<LocationData> recordedPoints;
  final double totalDistance;
  final double maxElevation;
  final Duration duration;

  const RecordTrailPage({
    Key? key,
    required this.recordedPoints,
    required this.totalDistance,
    required this.maxElevation,
    required this.duration,
  }) : super(key: key);

  @override
  State<RecordTrailPage> createState() => _RecordTrailPageState();
}

class _RecordTrailPageState extends State<RecordTrailPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  List<XFile> _images = [];

  Future<void> _pickImages() async {
    List<XFile> pickedImages = await multiImagePicker();
    setState(() {
      _images = pickedImages;
    });
  }

  Future<List<XFile>> multiImagePicker() async {
    List<XFile> _images = [];
    _images = await ImagePicker().pickMultiImage();
    return _images;
  }

  void _removeImage(int index) {
    setState(() {
      _images.removeAt(index);
    });
  }

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
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: ElevatedButton(
                  onPressed: _pickImages,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                        vertical: 15, horizontal: 20),
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                  ),
                  child: Text('Select Images'),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: _images.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(_images[index].name),
                          FutureBuilder<int>(
                            future: _images[index].length(),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.done) {
                                return Text(
                                    '${(snapshot.data! / (1024)).toStringAsFixed(2)} KB');
                              } else {
                                return SizedBox.shrink();
                              }
                            },
                          ),
                          GestureDetector(
                            onTap: () => _removeImage(index),
                            child: Icon(Icons.close),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
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
                var distance = widget.totalDistance; // Distância total
                var elevation = widget.maxElevation; // Elevação máxima
                var durationInMinutes =
                    widget.duration.inMinutes.toDouble(); // Duração em minutos

                // Convertendo para um lista
                var latLngList = widget.recordedPoints.map((point) {
                  return LatLng(point.latitude!, point.longitude!);
                }).toList();

                trailProvider
                    .createTrail(
                  userProvider.loggedUser!.uid!,
                  userProvider.loggedUser!.username,
                  _nameController.text,
                  _descriptionController.text,
                  distance,
                  elevation,
                  elevation,
                  durationInMinutes,
                  latLngList,
                  _images,
                )
                    .then((value) {
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
