import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:music_api/utils/model/apimodel.dart';

class Details_screen extends StatefulWidget {
  const Details_screen({Key? key}) : super(key: key);

  @override
  State<Details_screen> createState() => _Details_screenState();
}

class _Details_screenState extends State<Details_screen> {
  double _currentSliderValue = 0;
  late AudioPlayer audioPlayer;
  bool isPlaying = false;

  @override
  void initState() {
    super.initState();
    audioPlayer = AudioPlayer();
    // Set up a completion callback to handle the end of the audio
    audioPlayer.onPlayerStateChanged.listen((event) {
      setState(() {
        isPlaying = false;
        _currentSliderValue = 0;
      });
    });
  }

  @override
  void dispose() {
    audioPlayer.dispose();
    super.dispose();
  }

  void play(Apimodel api) async {
    // Stop the player if it's currently playing
    await audioPlayer.stop();
    // Start playing the new audio source
    await audioPlayer.play(UrlSource(api.source));
    setState(() {
      isPlaying = true;
    });
  }

  void stop() async {
    // Stop the player
    await audioPlayer.stop();
    setState(() {
      isPlaying = false;
      _currentSliderValue = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    Apimodel apimodel = ModalRoute.of(context)!.settings.arguments as Apimodel;

    return Scaffold(
      backgroundColor: Colors.grey,
      body: Column(
        children: [
          Expanded(
            flex: 5,
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.only(
                    left: 20,
                    right: 20,
                  ),
                  height: 400,
                  width: 400,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(
                        apimodel.image,
                      ),
                    ),
                  ),
                ),
                Text(
                  apimodel.title,
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  apimodel.artist,
                ),
              ],
            ),
          ),
          Expanded(
            flex: 3,
            child: Center(
              child: Column(
                children: <Widget>[
                  const SizedBox(
                    height: 20,
                  ),
                  Slider(
                    value: _currentSliderValue,
                    min: 0,
                    max: 100,
                    divisions: 10,
                    label: _currentSliderValue.round().toString(),
                    onChanged: (double value) {
                      setState(() {
                        _currentSliderValue = value;
                      });
                      // Add logic to seek audio to the specified position
                      audioPlayer.seek(Duration(seconds: value.toInt()));
                    },
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        onPressed: () {
                          // Add logic to skip to the previous track
                        },
                        icon: const Icon(Icons.skip_previous_sharp),
                      ),
                      IconButton(
                        onPressed: () {
                          // Toggle play/pause
                          if (isPlaying) {
                            audioPlayer.pause();
                          } else {
                            audioPlayer.resume();
                          }
                          setState(() {
                            isPlaying = !isPlaying;
                          });
                        },
                        icon: Icon(isPlaying ? Icons.pause : Icons.play_arrow),
                      ),
                      IconButton(
                        onPressed: stop,
                        icon: const Icon(Icons.stop),
                      ),
                      IconButton(
                        onPressed: () {
                          isPlaying = !isPlaying;
                          // Add logic to skip to the next track
                        },
                        icon: const Icon(
                          Icons.skip_next_sharp,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      // Add logic for the download button
                    },
                    child: const Icon(
                      Icons.download_for_offline,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
