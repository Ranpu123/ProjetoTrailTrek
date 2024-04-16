import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class ImageCarousel extends StatelessWidget {
  final List<String> imageUrls;

  ImageCarousel({required this.imageUrls});

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(
        height: 250.0, // Altura do carrossel
        enlargeCenterPage: true, // Destaca a imagem central
        autoPlay: false, // Ativa a reprodução automática
        aspectRatio: 16 / 9,
        enableInfiniteScroll: true,
        autoPlayInterval: Duration(seconds: 5),
        autoPlayAnimationDuration: Duration(milliseconds: 800),
      ),
      items: imageUrls.map((url) {
        return Builder(
          builder: (BuildContext context) {
            return Container(
              width: MediaQuery.of(context).size.width,
              child: Image(
                image: NetworkImage(url),
                fit: BoxFit.cover, // Ajusta a imagem para cobrir todo o espaço
              ),
            );
          },
        );
      }).toList(),
    );
  }
}
