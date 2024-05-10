import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:projeto_dev_disp_mob/pages/comment_page.dart';
import 'package:projeto_dev_disp_mob/pages/edit_trail_page.dart';
import 'package:projeto_dev_disp_mob/services/Auth/auth_service.dart';
import 'package:projeto_dev_disp_mob/widget/carousel.dart';
import 'package:latlong2/latlong.dart';
import 'package:projeto_dev_disp_mob/models/trail_model.dart';
import 'package:intl/intl.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:provider/provider.dart';

class TrailDetailsPage extends StatefulWidget {
  final Trail trail;
  const TrailDetailsPage({super.key, required this.trail});

  @override
  State<TrailDetailsPage> createState() => _TrailDetailsPageState();
}

class _TrailDetailsPageState extends State<TrailDetailsPage> {
  Trail? trail;
  @override
  bool _isFavorited = false;
  void _toggleFavorite() {
    setState(() {
      _isFavorited = !_isFavorited;
    });
  }

  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {});
  }

  @override
  Widget build(BuildContext context) {
    trail = widget.trail;
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        leading: const Icon(
          Icons.terrain,
          color: Colors.black,
        ),
        title: Text(trail!.name),
      ),
      body: ListView(
        children: [
          Column(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.6,
                child: FlutterMap(
                  options: MapOptions(initialCenter: trail!.averageLatLng()),
                  children: [
                    TileLayer(
                      urlTemplate:
                          'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                      userAgentPackageName:
                          'br.com.projetoDDM.projeto_dev_disp_mob',
                    ),
                    MarkerLayer(
                        markers: createMarkersFromPoints(trail!.points)),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8),
                child: Column(
                  children: [
                    Row(
                      children: [
                        const Icon(
                          Icons.nordic_walking,
                          color: Colors.black54,
                          size: 28,
                        ),
                        Flexible(
                          fit: FlexFit.tight,
                          child: Text(
                            trail!.name,
                            maxLines: 2,
                            style: const TextStyle(
                                fontSize: 24,
                                height: 0,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        (trail!.uid == context.read<AuthService>().usuario!.uid)
                            ? IconButton(
                                onPressed: () {
                                  editTrail(trail!);
                                },
                                icon: const Icon(
                                  Icons.edit,
                                  color: Colors.black54,
                                  size: 20,
                                ),
                              )
                            : const Padding(padding: EdgeInsets.all(0)),
                      ],
                    ),
                    const Divider(),
                    Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 50, vertical: 8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Trail Recorded by: ',
                              style: TextStyle(color: Colors.black87)),
                          Container(
                            height: 50,
                            decoration: BoxDecoration(
                                color: Colors.black26,
                                borderRadius: BorderRadius.circular(5)),
                            child: Row(
                              children: [
                                const Icon(
                                  Icons.person_2,
                                  color: Colors.black54,
                                  size: 28,
                                ),
                                Flexible(
                                  child: Text(
                                    trail!.username,
                                    maxLines: 2,
                                    style: const TextStyle(
                                        fontSize: 16, height: 0),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 50),
                      child: Column(
                        children: [
                          IntrinsicHeight(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'Distance',
                                      style: TextStyle(
                                          color: Colors.black26,
                                          fontSize: 14,
                                          height: 0),
                                    ),
                                    Text(
                                      '${trail!.distance} Km',
                                      style: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 18,
                                          height: 0),
                                    )
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    const Text(
                                      'Elevation',
                                      style: TextStyle(
                                          color: Colors.black26,
                                          fontSize: 14,
                                          height: 0),
                                    ),
                                    Text(
                                      '${trail!.elevation} m',
                                      style: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 18,
                                          height: 0),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                          const Divider(),
                          IntrinsicHeight(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'Duration',
                                      style: TextStyle(
                                          color: Colors.black26,
                                          fontSize: 14,
                                          height: 0),
                                    ),
                                    Text(
                                      trail!.getHoursAndMinutes(),
                                      style: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 18,
                                          height: 0),
                                    )
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    const Text(
                                      'Max. Elevation',
                                      style: TextStyle(
                                          color: Colors.black26,
                                          fontSize: 14,
                                          height: 0),
                                    ),
                                    Text(
                                      '${trail!.maxElevation} m',
                                      style: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 18,
                                          height: 0),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                          const Divider(),
                          IntrinsicHeight(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    const Text(
                                      'Posted in',
                                      style: TextStyle(
                                          color: Colors.black26,
                                          fontSize: 14,
                                          height: 0),
                                    ),
                                    Text(
                                      DateFormat('dd/MM/yyyy')
                                          .format(trail!.createdAt),
                                      style: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 18,
                                          height: 0),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              const Divider(),
              ImageCarousel(imageUrls: trail!.images),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 8, horizontal: 50),
                child: Column(
                  children: [
                    Text(
                      trail!.description,
                    ),
                  ],
                ),
              ),
              const Divider(),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 8, horizontal: 50),
                child: Row(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Text('Rating and Coments: '),
                        Row(
                          children: [
                            RatingBarIndicator(
                              rating: trail!.trailRating(),
                              itemCount: 5,
                              itemSize: 30.0,
                              itemBuilder: (context, _) => const Icon(
                                Icons.star,
                                color: Colors.amber,
                              ),
                            ),
                            Text(
                                '(${trail!.coments.length}) ${trail!.trailRating()}'),
                          ],
                        ),
                      ],
                    ),
                    IconButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => CommentPage()),
                        );
                      },
                      icon: const Icon(
                        Icons.chat,
                        color: Colors.black,
                      ),
                    ),
                    IconButton(
                      icon: Icon(
                        _isFavorited
                            ? Icons.favorite
                            : Icons.favorite_border_outlined,
                        color: _isFavorited ? Colors.red : null,
                      ),
                      onPressed: _toggleFavorite,
                    ),
                  ],
                ),
              ),
              const Divider(),
            ],
          ),
        ],
      ),
    );
  }

  List<Marker> createMarkersFromPoints(List<LatLng> points) {
    List<Marker> list = [];
    if (points.isNotEmpty) {
      for (int i = 0; i < points.length; i++) {
        list.add(Marker(
          point: points[i],
          child: Icon(Icons.location_pin,
              color: (i == 0 || i == points.length - 1)
                  ? Colors.amber
                  : Colors.redAccent,
              size: (i == 0 || i == points.length - 1) ? 30 : 20,
              shadows: const [Shadow(blurRadius: 2, color: Colors.black87)]),
        ));
      }
    }
    return list;
  }

  void editTrail(Trail otrail) {
    Navigator.push(context, MaterialPageRoute(
      builder: (context) {
        return EditTrailPage(
          trail: otrail,
        );
      },
    ));
  }
}
