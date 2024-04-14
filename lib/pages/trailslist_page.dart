import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:projeto_dev_disp_mob/services/Trail/local_trails_repository.dart';
import 'package:provider/provider.dart';

class TrailsListPage extends StatefulWidget {
  const TrailsListPage({super.key});

  @override
  State<TrailsListPage> createState() => _TrailsListPageState();
}

class _TrailsListPageState extends State<TrailsListPage> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: ListView.separated(
        itemCount: 50,
        itemBuilder: (context, index) {
          return Card(
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
                            '$index Trilha do morro da santa - Alagados Ponta Grossa',
                            maxLines: 2,
                            style: TextStyle(height: 0),
                          ),
                        )
                      ],
                    ),
                    const Row(
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Divider(),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Distance',
                                      style: TextStyle(
                                          color: Colors.black26,
                                          fontSize: 8,
                                          height: 0),
                                    ),
                                    Text(
                                      '7,19 Km',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 12,
                                          height: 0),
                                    )
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Elevation',
                                      style: TextStyle(
                                          color: Colors.black26,
                                          fontSize: 8,
                                          height: 0),
                                    ),
                                    Text(
                                      '308 m',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 12,
                                          height: 0),
                                    )
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Rating',
                                      style: TextStyle(
                                          color: Colors.black26,
                                          fontSize: 8,
                                          height: 0),
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          '(0) 0.0',
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 12,
                                              height: 0),
                                        ),
                                        Icon(
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
                        Column()
                      ],
                    )
                  ],
                ),
              ));
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
