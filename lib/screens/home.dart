import 'dart:convert';
import 'dart:math';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:forqan/main.dart';
import 'package:forqan/models/surah.dart';
import 'package:forqan/screens/reading_page.dart';
import 'package:quran/quran.dart' as quran;
import 'package:google_fonts/google_fonts.dart';
import 'package:forqan/main.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  bool home = true;
  List<Surah> surahList = [];
  int selectedIndex = 0;
  bool isReverse = false;
  ScrollController _controller = ScrollController();
  @override
  void initState() {
    readJson();
    super.initState();
  }

  Future<void> readJson() async {
    final String response = await rootBundle.loadString('assets/surah.json');
    final data = await json.decode(response);
    for (var item in data["chapters"]) {
      surahList.add(Surah.fromMap(item));
    }
    debugPrint(surahList.length.toString());
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return (home)
        ? Scaffold(
            appBar: AppBar(
              actions: [
                IconButton(
                    onPressed: () {
                      setState(() {
                        home = !home;
                      });
                    },
                    icon: Icon(
                      Icons.arrow_forward,
                      color: Colors.black,
                    ))
              ],
              backgroundColor: Colors.grey,
              title: Text(
                "قراني معي",
                style: TextStyle(
                    fontFamily: 'Kitab',
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
              ),
              leading: Transform.rotate(
                angle: isReverse ? pi : 2 * pi,
                child: IconButton(
                    icon: Icon(
                      Icons.sort,
                      color: Colors.black,
                    ),
                    onPressed: () {
                      setState(() {
                        isReverse = !isReverse;
                      });
                    }),
              ),
            ),
            body: surahList.isEmpty
                ? Center(child: CircularProgressIndicator())
                : chaptersList(
                    isReverse ? surahList.reversed.toList() : surahList),
          )
        : MyApp();
  }

  Widget chaptersList(List<Surah> chapters) {
    return ListView.separated(
      controller: _controller,
      itemBuilder: (context, index) => ListTile(
        leading: CircleAvatar(
          child: Text(
            chapters[index].id.toString(),
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.grey,
        ),
        title: Text(chapters[index].name),
        subtitle: Text(chapters[index].versesCount.toString()),
        trailing: Text(
          chapters[index].arabicName,
          style: GoogleFonts.cairo(
            fontSize: 18,
          ),
        ),
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute<void>(
            builder: (BuildContext context) =>
                SurahPage(surah: chapters[index]),
          ),
        ),
      ),
      separatorBuilder: (context, index) => Divider(height: 1),
      itemCount: chapters.length,
    );
  }
}
