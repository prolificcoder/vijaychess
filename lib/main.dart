import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Vijay chess club',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Vijay chess club'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  void _incrementCounter() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Column(
            children: <Widget>[
              Text(
                'Over the board outdoor chess lessons',
                style: Theme.of(context).textTheme.headline5,
              ),
              SizedBox(height: 16),
              ExpandablePanel(
                header: Text('One hour classes'),
                collapsed: Text(''),
                expanded: Text(
                    'Get started with one hour group lessons, \$20 per class. Max 8 kids at one time. Timings depend on kids level'),
              ),
              SizedBox(height: 16),
              Text('Location: 2512 242nd Ave SE, Sammamish'),
              SizedBox(height: 16),
              ExpandablePanel(
                header: Text('RSVP'),
                collapsed: Text(''),
                expanded: Text(
                    'RSVP in the form below and you will hear back from me with confirmation'),
              ),
              SizedBox(height: 16),
              ExpandablePanel(
                header: Text('About me'),
                collapsed: Text(''),
                expanded: Text(
                    'I started learning chess at 11 years of age and became serious and had a full time coach from 13. My coaches inculcated in me a growth mindset and attacking play. My peak chess performance was reached in about 3 years of professional stint. I played mostly in Andhra Pradesh (combined then), India and I was the state championships in Under-14, Under-15, Under-19 and state official championships. I continued playing semi-professionally after joining college and won several collegiate and University championships. I was the captain for the Andhra university and our team got into top 10. I was also captain for the Gitam college team which won the intercollegiate all 4 years. During this period I also started coaching other students and a kid who I coached won national under-7 championship. After few years I came to the US and played in a few tournaments and with in couple of years I got the NM title'),
              ),
              SizedBox(height: 16),
              ExpandablePanel(
                header: Text('Coaching style'),
                collapsed: Text(''),
                expanded: Text('While I coach at various levels, my skill and passion shines for committed players who want to compete in tournaments. My focus in teaching will be on practical OTB play with analysis of previous games and retrospection. I teach skills that avoid making blunders and improvement from each serious tournament game. I specialize in middle game and attacking style because I believe this brings rapid development. My coach has this favorite quote, "even if the opponent is a world champion, he has the same set of pieces and has to work with the same rules to defeat you". You are in control of your game, its a great equalizer. Currently my focus is on teaching my young son and hence my rates are very low because he accompanies me during the class. A quote from a 12 yr old student\'s parent "Thanks to your coaching, he has been showing more interest in chess than anything else so far'),
              ),
              Text('Contact me for additional details'),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Contact',
        child: Icon(Icons.mail_outlined),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
