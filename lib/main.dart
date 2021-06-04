import 'package:expandable/expandable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:mailto/mailto.dart';
import 'package:url_launcher/url_launcher.dart';

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
  void _openEmailIntent() async {
    final mailtoLink = Mailto(
      subject: 'Chess coaching inquiry',
      body: '''
Name: 
Age: 
Rating:
      ''',
      to: ['satya@malugu.com'],
    ).toString();
    print('$mailtoLink');
    await launch('$mailtoLink');
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: Column(
              children: <Widget>[
                Text(
                  'Over the board outdoor chess by National Master - Satyajit Malugu',
                  style: Theme.of(context).textTheme.headline5,
                ),
                ExpandablePanel(
                  header: Text('VCC Class + Tournament: Jun 12th 10AM'),
                  collapsed: Text(''),
                  expanded: Text(
                      '''Over the board class, some pizza and rated tournament
Class starts at 10AM sharp. Then there will be break and we start the tournament at about 11. Pizza will be served as lunch. 
Masks are required for class time.
Class will be focused on opening principles and exploitation of opening mistakes.
Tournament Game 25 + 5 sec increment. Mini swiss/Quad 3 round event. Real pieces, real clock, real notation.
If you would like class only or tournament only for a lower price, that's an option too.

\$50 entry fee. Prize fund 50% of entree fees. Special prize for notation accuracy.'''),
                ),
                SizedBox(height: 16),
                ExpandablePanel(
                  header: Text('Past events'),
                  collapsed: Text(''),
                  expanded: Column(children: [
                    Text(
                        'VCC Kickoff: OTB Class + Rated Tournament on Memorial day - May 31st'),
                    Row(children: [
                      Linkify(
                        text:
                            '''Get ready for some over the board chess! We are going to kickoff VCC by a class + rated tournament event.
Class starts at 2PM sharp and should be finished by 3. There will be break for about 15 mins and then we start the tournament. Wrap up around 6PM.
Masks are required for the entire duration.
Class will cover basic over the board rules including notation and tactics on f7.
Game 25 + 5 sec increment. Quad 3 round event. Real pieces, real clock, real notation.
If you would like class only or tournament only for a lower price, that's an option too.
\$50 entry fee. Prize fund 50% of entree fees. Special prize for notation accuracy.
''',
                      ),
                      Expanded(
                          child: Image.asset(
                        'images/VCC-kickoff-class.jpg',
                        height: 300,
                        width: 300,
                      )),
                    ]),
                    Linkify(
                      text:
                          'Ratings cross table posted at: http://chess.ratingsnw.com/report20-21/VijayChessClubMemDay.html',
                    ),
                  ]),
                ),
                SizedBox(height: 16),
                ExpandablePanel(
                  header: Text('Location'),
                  collapsed: Text(''),
                  expanded: Text('2512 242nd Ave SE, Sammamish'),
                ),
                SizedBox(height: 16),
                ExpandablePanel(
                  header: Text('Why in person?'),
                  collapsed: Text(''),
                  expanded: Text('''
Serious chess tournaments happen over the board and I would like students to get prepared for them. Also for retention and engagement, real life can't be beat. 
Resources available over the internet for chess improvement are vast and I will help motivated students to supplement class learnings.
'''),
                ),
                SizedBox(height: 16),
                ExpandablePanel(
                    header: Text('About'),
                    collapsed: Text(''),
                    expanded: Column(
                      children: [
                        ExpandablePanel(
                          header: Text('About me'),
                          collapsed: Text(''),
                          expanded: Linkify(
                              onOpen: (link) => launch(link.url), text: '''
I started learning chess at 11 years of age and became serious and had a full time coach from 13. My coaches inculcated in me a growth mindset and attacking play. 
My peak chess performance was reached in about 3 years of professional stint. I played mostly in Andhra, India and I won the state championships in Under-14, Under-15, Under-19 and state official. 
I continued playing semi-professionally after joining college and won several collegiate and University championships. I was the captain for the Andhra university where our team got into top 10 in nationals. 
I was also captain for the GITAM college team which won the intercollegiate all 4 years. During this period I also started coaching other students and a kid who I coached won national under-7 championship. 
After few years I came to the US and played in a few tournaments and with in couple of years I got the NM title

chess.com profile: https://www.chess.com/member/smalugu
lichess profile: https://lichess.org/@/smalugu
Linkedin: https://www.linkedin.com/in/satyajitmalugu/  
'''),
                        ),
                        SizedBox(height: 16),
                        ExpandablePanel(
                          header: Text('Coaching style'),
                          collapsed: Text(''),
                          expanded: Text('''
While I coach at various levels, my skill and passion shines for committed players who want to compete in tournaments.
My focus in teaching will be on practical OTB play with analysis of previous games and retrospection. I teach skills that avoid making blunders and improvement from each serious tournament game. 
I specialize in middle game and attacking style because I believe this brings rapid development. My coach has this favorite quote, "even if the opponent is a world champion, he has the same set of pieces and has to work with the same rules to defeat you".
You are in control of your game, its a great equalizer. Currently my focus is on teaching my young son and hence my rates are very low because he accompanies me during the class. 
A quote from a 12 yr old student\'s parent "Thanks to your coaching, he has been showing more interest in chess than anything else so far
'''),
                        ),
                      ],
                    ))
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _openEmailIntent,
        tooltip: 'Contact',
        child: Icon(Icons.mail_outlined),
      ),
      persistentFooterButtons: <Widget>[
        Linkify(
            onOpen: (link) => launch(link.url),
            text:
                'Made with flutter, code hosted at https://github.com/prolificcoder/vijaychess'),
      ],
    );
  }
}
