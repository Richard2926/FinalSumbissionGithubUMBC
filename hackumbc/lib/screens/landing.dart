import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

import '../globaldata.dart';
import 'explore.dart';

class Landing extends StatefulWidget {
  const Landing({Key? key}) : super(key: key);

  @override
  State<Landing> createState() => _LandingState();
}

class _LandingState extends State<Landing> {
  final TextEditingController _maxPriceController = TextEditingController();
  late VideoPlayerController _controller;

  // TODO 5: Override the initState() method and setup your VideoPlayerController
  @override
  void initState() {
    super.initState();
    // Pointing the video controller to our local asset.
    _controller = VideoPlayerController.asset("assets/large.mp4")
      ..initialize().then((_) {
        // Once the video has been loaded we play the video and set looping to true.
        _controller.play();
        _controller.setLooping(true);
        // Ensure the first frame is shown after the video is initialized.
        setState(() {});
      });
  }
  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          SizedBox.expand(
            child: FittedBox(
              // If your background video doesn't look right, try changing the BoxFit property.
              // BoxFit.fill created the look I was going for.
              fit: BoxFit.fill,
              child: SizedBox(
                width: _controller.value.size?.width ?? 0,
                height: _controller.value.size?.height ?? 0,
                child: VideoPlayer(_controller),
              ),
            ),
          ),
          Center(
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(top: MediaQuery.of(context).size.height / 5),
                  child: const Text(
                    'Cheap Eats',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontFamily: 'Cookie', fontSize: 50, color: Colors.white),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 50.0),
                  child: Container(
                    width: MediaQuery.of(context).size.width / 5,
                    child: TextField(
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.white,
                        fontFamily: 'Cookie',
                        fontSize: 25,
                      ),
                      controller: _maxPriceController,
                      decoration: const InputDecoration(
                        hintStyle: TextStyle(
                          // fontFamily: '',
                          fontSize: 25,
                          color: Color.fromRGBO(189, 195, 199, 1),
                        ),
                        hintText: '10',
                        hoverColor: Colors.white,
                        prefixIcon: Icon(Icons.monetization_on_sharp, color: Colors.pinkAccent),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding:
                      EdgeInsets.only(top: MediaQuery.of(context).size.height / 30, bottom: MediaQuery.of(context).size.height / 60),
                  child: const Text(
                    'What\'s Your budget for eating out today!',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontFamily: 'Cookie', fontSize: 15, color: Colors.white),
                  ),
                ),
                MaterialButton(
                  onPressed: () {
                    if(_maxPriceController.value.text != "") {
                      budget = int.parse(_maxPriceController.value.text);
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const Explore()),
                      );
                    }
                  },
                  color: Colors.pinkAccent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.symmetric(vertical: 4.0, horizontal: 45.0),
                    child: Text(
                      "Find Me Food!",
                      style: TextStyle(color: Colors.white, fontSize: 25, fontFamily: "Cookie"),
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
