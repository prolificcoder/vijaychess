import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expandable/expandable.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:mailto/mailto.dart';
import 'package:url_launcher/url_launcher.dart';

import 'model/players.dart';
// ignore: library_prefixes
import 'constants.dart' as Constants;

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(VCCApp());
}

class VCCApp extends StatelessWidget {
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
  bool _initialized = false;
  bool _error = false;

  void initializedFlutterFire() async {
    try {
      await Firebase.initializeApp();
      setState(() {
        _initialized = true;
      });
    } catch (e) {
      setState(() {
        _error = true;
      });
    }
  }

  @override
  void initState() {
    initializedFlutterFire();
    super.initState();
  }

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
    print(mailtoLink);
    await launch(mailtoLink);
  }

  @override
  Widget build(BuildContext context) {
    if (_error) {
      return ErrorWidget(_error);
    }
    if (!_initialized) {
      return CircularProgressIndicator();
    }
    final players = FirebaseFirestore.instance.collection('VCC-July');

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
                  header: Text(
                      'VCC Summer OTB Tournament + Knockout Chess Pong! : July 31st',
                      style: Theme.of(context).textTheme.subtitle1),
                  collapsed: FutureBuilder<QuerySnapshot>(
                      future: players.get(),
                      builder: (context, snapshot) {
                        if (snapshot.hasError) {
                          return Text("Something went wrong ${snapshot.error}");
                        }
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Text("loading...");
                        }
                        List<Player> players = [];
                        for (var doc in snapshot.data!.docs) {
                          Map<String, dynamic>? data =
                              doc.data() as Map<String, dynamic>?;
                          if (data != null &&
                              data['status'].toString() == 'Confirmed' &&
                              data['status'].toString() == 'Available') {
                            players.add(Player(
                                status: data['status'],
                                id: data['ID'],
                                firstName: data['first_name'],
                                lastName: data['last_name'],
                                rating: int.parse(data['rating'])));
                          }
                        }
                        players.sort((b, a) => a.rating.compareTo(b.rating));

                        return Column(children: [
                          Text(
                              'Roster as of now, will add players as they confirm, cap at 12'),
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: DataTable(
                                columns: [
                                  DataColumn(
                                      label: Text(
                                    'Status',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  )),
                                  DataColumn(
                                      label: Text(
                                    'First Name',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  )),
                                  DataColumn(
                                      label: Text(
                                    'Last Name',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  )),
                                  DataColumn(
                                      label: Text(
                                    'Rating',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  )),
                                ],
                                rows: List<DataRow>.generate(
                                    players.length,
                                    (index) => DataRow(cells: [
                                          DataCell(Text(players[index].status)),
                                          DataCell(
                                              Text(players[index].firstName)),
                                          DataCell(
                                              Text(players[index].lastName)),
                                          DataCell(Text(players[index]
                                              .rating
                                              .toString())),
                                        ]))),
                          ),
                        ]);
                      }),
                  expanded: Text('''Over the board tournament and pizza
First round starts at 10, should be done by around 1PM. Pizza will be served as lunch. 
Masks are required for entire duration.
Tournament Game 25 + 5 sec increment. Quad 3 round event. Real pieces, real clock, real notation.

After the quads are done, we will start the chess pong knockout. Either 4 or 8 players
Format, best of 5 games. Alternate blitz chess (3+1) + ping pong, if score is even after 4 rounds, tie breaker is decided by choose hand.
One hand a pawn, another a pong ball, opponent choses the hand. 

\$30 entry fee. Prize fund 50% of entree fees + trophies for winners. Special prize for notation accuracy.'''),
                ),
                SizedBox(height: 16),
                ExpandablePanel(
                  header: Text('Advance your chess through analysis'),
                  expanded: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                            'Small group analysis sessions for motivated students, who are spending ~10 hours on chess a week.'),
                        Text(
                            'Format: 45 mins session, price \$30, expect 2 hours of home work. We will pick a game that students played and analyze over the board without computers help. I will teach the analysis technique and refine students work.'),
                        Text(
                            'Either OTB or online over skype on a real board (no computers allowed). You will need a book and pencil')
                      ]),
                  collapsed: Text(''),
                ),
                SizedBox(height: 16),
                ExpandablePanel(
                  header: Text('Past events',
                      style: Theme.of(context).textTheme.subtitle1),
                  collapsed: Text(''),
                  expanded: Column(children: [
                    ExpandableNotifier(
                      child: ExpandablePanel(
                          header: Text('VCC Class + Tournament: July 10th',
                              style: Theme.of(context).textTheme.subtitle1),
                          collapsed: Text(''),
                          expanded: Column(children: [
                            Text(
                                '''We had a great turnout for this event with 10 kids and 2 adults joined as eveners.
                                '''),
                            CarouselSlider(
                                options: CarouselOptions(),
                                items: Constants.julyImageList
                                    .map((item) => Container(
                                            child: Image.asset(
                                          'images/' + item,
                                        )))
                                    .toList()),
                          ])),
                    ),
                    ExpandableNotifier(
                      child: ExpandablePanel(
                          header: Text('VCC Class + Tournament: Jun 12th',
                              style: Theme.of(context).textTheme.subtitle1),
                          collapsed: Text(''),
                          expanded: Column(children: [
                            Text(
                                '''Over the board class, some pizza and rated tournament
Class starts at 10AM sharp. Then there will be break and we start the tournament at about 11. Pizza will be served as lunch. 
Masks are required for class time. Capped at max 10 players
Class will be focused on opening principles and exploitation of opening mistakes.
Tournament Game 25 + 5 sec increment. Mini swiss/Quad 3 round event. Real pieces, real clock, real notation.

\$50 entry fee. Prize fund 50% of entree fees. Special prize for notation accuracy.
Rating results: http://chess.ratingsnw.com/report20-21/VijayChessClub061221.html'''),
                            CarouselSlider(
                                options: CarouselOptions(),
                                items: Constants.juneImageList
                                    .map((item) => Container(
                                            child: Image.asset(
                                          'images/' + item,
                                        )))
                                    .toList()),
                          ])),
                    ),
                    SizedBox(height: 16),
                    ExpandableNotifier(
                      child: ExpandablePanel(
                          header: Text(
                              'VCC Kickoff: OTB Class + Rated Tournament on Memorial day - May 31st'),
                          collapsed: Text(''),
                          expanded: Column(children: [
                            Text(
                                '''Get ready for some over the board chess! We are going to kickoff VCC by a class + rated tournament event.
Class starts at 2PM sharp and should be finished by 3. There will be break for about 15 mins and then we start the tournament. Wrap up around 6PM.
Masks are required for the entire duration.
Class will cover basic over the board rules including notation and tactics on f7.
Game 25 + 5 sec increment. Quad 3 round event. Real pieces, real clock, real notation.
If you would like class only or tournament only for a lower price, that's an option too.
\$50 entry fee. Prize fund 50% of entree fees. Special prize for notation accuracy.
'''),
                            CarouselSlider(
                                options: CarouselOptions(),
                                items: Constants.kickoffImageList
                                    .map((item) => Container(
                                            child: Image.asset(
                                          'images/' + item,
                                        )))
                                    .toList()),
                            Linkify(
                                text:
                                    'Ratings cross table posted at: http://chess.ratingsnw.com/report20-21/VijayChessClubMemDay.html',
                                options: LinkifyOptions(humanize: false)),
                          ])),
                    ),
                  ]),
                ),
                SizedBox(height: 16),
                ExpandablePanel(
                  header: Text('Location',
                      style: Theme.of(context).textTheme.subtitle1),
                  collapsed: Text(''),
                  expanded: Text('2512 242nd Ave SE, Sammamish'),
                ),
                SizedBox(height: 16),
                ExpandablePanel(
                  header: Text('Why in person?',
                      style: Theme.of(context).textTheme.subtitle1),
                  collapsed: Text(''),
                  expanded: Text('''
Serious chess tournaments happen over the board and I would like students to get prepared for them. Also for retention and engagement, real life can't be beat. 
Resources available over the internet for chess improvement are vast and I will help motivated students to supplement class learnings.
'''),
                ),
                SizedBox(height: 16),
                ExpandablePanel(
                    header: Text('About',
                        style: Theme.of(context).textTheme.subtitle1),
                    collapsed: Text(''),
                    expanded: Column(
                      children: [
                        ExpandableNotifier(
                          child: ExpandablePanel(
                              header: Text('Motivation',
                                  style: Theme.of(context).textTheme.subtitle2),
                              collapsed: Text(''),
                              expanded: Text(
                                  "My dad's (now expired) name is Vijaya Kumar, he taught me how pieces move when I was 6 but what is extra ordinary is that he kept on pushing me go for chess coaching and he didn't rest until he found a great coach for me. He never said no for coaching or money for tournament or skipping school for practise, he completely believed in me. I hope to motivate my son as much as my dad motivates me everyday to do my best. Vijay means winning(or winner) I hope students here win what they are after!")),
                        ),
                        SizedBox(height: 16),
                        ExpandableNotifier(
                          child: ExpandablePanel(
                            header: Text('Chess career',
                                style: Theme.of(context).textTheme.subtitle2),
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
                        ),
                        SizedBox(height: 16),
                        ExpandableNotifier(
                          child: ExpandablePanel(
                            header: Text('Coaching style',
                                style: Theme.of(context).textTheme.subtitle2),
                            collapsed: Text(''),
                            expanded: Text('''
While I coach at various levels, my skill and passion shines for committed players who want to compete in tournaments.
My focus in teaching will be on practical OTB play with analysis of previous games and retrospection. I teach skills that avoid making blunders and improvement from each serious tournament game. 
I specialize in middle game and attacking style because I believe this brings rapid development. My coach has this favorite quote, "even if the opponent is a world champion, he has the same set of pieces and has to work with the same rules to defeat you".
You are in control of your game, its a great equalizer. Currently my focus is on teaching my young son and hence my rates are very low because he accompanies me during the class. 
A quote from a 12 yr old student's parent "Thanks to your coaching, he has been showing more interest in chess than anything else so far
'''),
                          ),
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

  // List<DataRow> _createRows(QuerySnapshot snapshot) {
  //   List<DataRow> newList =
  //       snapshot.docs.map((DocumentSnapshot documentSnapshot) {
  //     return new DataRow(cells: [
  //       DataCell(Text(
  //           documentSnapshot.data()["someDataYouWantToProcessForCellData"]))
  //     ]);
  //   }).toList();

  //   return newList;
  // }
}
