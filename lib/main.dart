import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  XFile? video;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: video == null ? renderEmpty() : renderVideo(),
    );
  }

  Widget renderVideo() {
    return const Center(
        child: Text(
      'data',
      style: TextStyle(fontSize: 50),
    ));
  }

  Widget renderEmpty() {
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: setBoxDecoration(),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _Logo(
            onTap: onTap,
          ),
          const SizedBox(height: 30.0),
          const VideoText(),
        ],
      ),
    );
  }

  onTap() async {
    final video = await ImagePicker().pickVideo(source: ImageSource.gallery);
    if (video != null) {
      this.video = video;
      setState(() {});
    }
  }

  BoxDecoration setBoxDecoration() {
    return const BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          Color(0xff293A74),
          Color(0xff080808),
        ],
      ),
    );
  }
}

class _Logo extends StatelessWidget {
  final VoidCallback onTap;
  const _Logo({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: onTap, child: Image.asset('asset/image/logo.png'));
  }
}

class VideoText extends StatelessWidget {
  const VideoText({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    const textStyle = TextStyle(fontSize: 30, color: Colors.white);
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'VIDEO',
          style: textStyle,
        ),
        Text(
          'PLAYER',
          style: textStyle.copyWith(fontWeight: FontWeight.w700),
        )
      ],
    );
  }
}
