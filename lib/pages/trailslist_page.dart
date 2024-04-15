import 'package:flutter/material.dart';
import 'package:projeto_dev_disp_mob/controllers/trail_controller.dart';
import 'package:projeto_dev_disp_mob/pages/trail_detail_page.dart';
import 'package:provider/provider.dart';

class TrailsListPage extends StatefulWidget {
  const TrailsListPage({super.key});

  @override
  State<TrailsListPage> createState() => _TrailsListPageState();
}

class _TrailsListPageState extends State<TrailsListPage> {
  @override
  Widget build(BuildContext context) {
    final trailProvider = Provider.of<TrailController>(context);

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView.separated(
        itemCount: trailProvider.trails.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        TrailDetailsPage(id: trailProvider.trails[index].id),
                  ));
            },
            child: Card(
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          const Icon(
                            Icons.nordic_walking,
                            color: Colors.black54,
                          ),
                          Flexible(
                            child: Text(
                              trailProvider.trails[index].name,
                              maxLines: 2,
                              style: const TextStyle(height: 0),
                            ),
                          )
                        ],
                      ),
                      Row(
                        children: [
                          Column(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        'Distance',
                                        style: TextStyle(
                                            color: Colors.black26,
                                            fontSize: 8,
                                            height: 0),
                                      ),
                                      Text(
                                        '${trailProvider.trails[index].distance} Km',
                                        style: const TextStyle(
                                            color: Colors.black,
                                            fontSize: 12,
                                            height: 0),
                                      )
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        'Elevation',
                                        style: TextStyle(
                                            color: Colors.black26,
                                            fontSize: 8,
                                            height: 0),
                                      ),
                                      Text(
                                        '${trailProvider.trails[index].elevation} m',
                                        style: const TextStyle(
                                            color: Colors.black,
                                            fontSize: 12,
                                            height: 0),
                                      )
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        'Rating',
                                        style: TextStyle(
                                            color: Colors.black26,
                                            fontSize: 8,
                                            height: 0),
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            '(${trailProvider.trails[index].coments.length}) ${trailProvider.trails[index].trailRating()}',
                                            style: const TextStyle(
                                                color: Colors.black,
                                                fontSize: 12,
                                                height: 0),
                                          ),
                                          const Icon(
                                            Icons.star,
                                            color: Colors.amber,
                                            size: 12,
                                          )
                                        ],
                                      )
                                    ],
                                  )
                                ],
                              )
                            ],
                          ),
                          const SizedBox(
                            width: 15,
                          ),
                          Expanded(
                            child: Column(
                              children: [
                                Container(
                                  height:
                                      MediaQuery.of(context).size.width * 0.30,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(
                                        8), // Bordas arredondadas
                                    image: DecorationImage(
                                      image: NetworkImage(
                                        trailProvider.trails[index].images
                                            .first, // URL da imagem
                                      ),
                                      fit: BoxFit
                                          .cover, // Ajusta a imagem para cobrir o container
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                )),
          );
        },
        separatorBuilder: (context, index) {
          return const Divider(
            color: Colors.transparent,
            height: 5,
          );
        },
      ),
    );
  }
}
