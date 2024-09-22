import 'package:flutter/material.dart';
import '../models/artist.dart';

class ArtistCardScreen extends StatelessWidget {
  const ArtistCardScreen();
  @override
  Widget build(BuildContext context) {
    final alfred = Artist(
      firstName: "Alfred",
      lastName: "Sisley",
      country: "France",
      birthYear: 1839,
      deathYear: 1899,
      artWorksCount: 471,
      photoPath: 'assets/images/img_alfred_sisley.png',
      paintingPath: 'assets/images/img_alfred_sisley_painting.png',
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Artist Card'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ArtistCard(artist: alfred),
      ),
    );
  }
}

class ArtistCard extends StatelessWidget {
  final Artist artist;

  const ArtistCard({required this.artist});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Card(
          color: const Color(0xFFFFFAF0),
          elevation: 8,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Stack(
                  children: [
                    ClipOval(
                      child: Image.asset(
                        artist.photoPath,
                        width: 70,
                        height: 70,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const Positioned(
                      bottom: 0,
                      right: 0,
                      child: Icon(
                        Icons.favorite,
                        color: Colors.red,
                      ),
                    ),
                  ],
                ),
                const SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${artist.firstName} ${artist.lastName}',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      '${artist.birthYear}-${artist.deathYear} (${artist.country})',
                      style: Theme.of(context).textTheme.labelMedium,
                    ),
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: '${artist.artWorksCount}',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.blue,
                            ),
                          ),
                          const TextSpan(
                            text: ' Artworks',
                            style: TextStyle(
                              fontWeight: FontWeight.normal,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 8),
        Image.asset(
          artist.paintingPath,
          fit: BoxFit.cover,
          width: double.infinity,
        ),
      ],
    );
  }
}

/* void main() {
  runApp(MaterialApp(
    theme: ThemeData(
      primarySwatch: Colors.blue,
    ),
    home: ArtistCardScreen(),
  ));
} */
