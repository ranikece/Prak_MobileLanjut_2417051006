import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

class AssetsMediaPage extends StatefulWidget {
  const AssetsMediaPage({super.key});

  @override
  State<AssetsMediaPage> createState() => _AssetsMediaPageState();
}

class _AssetsMediaPageState extends State<AssetsMediaPage> {
  final AudioPlayer audioPlayer = AudioPlayer();

  bool isPlaying = false;

  Future<void> playAudio() async {
    if (isPlaying) {
      await audioPlayer.pause();

      setState(() {
        isPlaying = false;
      });
    } else {
      await audioPlayer.play(AssetSource('audio/funny.mp3'));

      setState(() {
        isPlaying = true;
      });
    }
  }

  @override
  void dispose() {
    audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Assets & Media')),

      // DRAWER
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(color: Colors.blue),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(Icons.account_circle, size: 60, color: Colors.white),

                  SizedBox(height: 10),

                  Text(
                    'Assets & Media',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  Text(
                    'Pertemuan 6',
                    style: TextStyle(color: Colors.white, fontSize: 14),
                  ),
                ],
              ),
            ),

            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Home'),
              onTap: () {
                Navigator.pop(context);
              },
            ),

            ListTile(
              leading: const Icon(Icons.info),
              title: const Text('Detail'),
              onTap: () {
                Navigator.pop(context);

                Navigator.pushNamed(
                  context,
                  '/detail',
                  arguments: 'Data dari Assets & Media',
                );
              },
            ),
          ],
        ),
      ),

      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              // PROFILE
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.blue.shade50,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  children: [
                    ClipOval(
                      child: Image.asset(
                        'assets/images/kucing.jpg',
                        width: 130,
                        height: 130,
                        fit: BoxFit.cover,
                      ),
                    ),

                    const SizedBox(height: 15),

                    const Text(
                      'Putri Maharani',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 5),

                    const Text(
                      'NPM: 2417051006',
                      style: TextStyle(fontFamily: 'Poppins', fontSize: 14),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 25),

              // AUDIO
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  children: [
                    const Icon(Icons.music_note, size: 50),

                    const SizedBox(height: 10),

                    const Text(
                      'My Audio',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 15),

                    IconButton(
                      iconSize: 50,
                      onPressed: playAudio,
                      icon: Icon(
                        isPlaying ? Icons.pause_circle : Icons.play_circle,
                      ),
                    ),

                    const Text(
                      'Play / Pause',
                      style: TextStyle(fontFamily: 'Poppins'),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
