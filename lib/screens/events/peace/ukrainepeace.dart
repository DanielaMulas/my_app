import 'package:flutter/material.dart';
//import 'package:my_app/screens/events/humanrights/runningevent.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:my_app/models/authorization.dart';
import 'package:my_app/models/steps.dart';
import 'package:intl/intl.dart';

class UkrPeace extends StatefulWidget {
  UkrPeace({Key? key}) : super(key: key);

  static const route = '/ukrpeace/';
  static const routename = 'UkrPeace';

  @override
  State<UkrPeace> createState() => _UkrPeaceState();
}

class _UkrPeaceState extends State<UkrPeace> {
  var uri = Uri(
    scheme: 'https',
    host: 'unfpa.org',
    path: 'donate/Ukraine-a?utm_campaign=HO-UA-22-Ukraine&utm_content=evergreen&gclid=CjwKCAiA1JGRBhBSEiwAxXblwULSSi1DDIzP6plSTz6QXYPRCsEeAlCRoHlpGFsQ4qf3-GGDL3iIeRoCJ9IQAvD_BwE',
  );

  final Authorization auth = Authorization();
  DateTime start_day = DateTime(2023, 2, 24);
  DateTime end_day = DateTime(2023, 2, 27);
  String formattedStartDisplay =
      DateFormat('dd/MM/yyyy').format(DateTime(2023, 2, 24));
  String formattedEndDisplay =
      DateFormat('dd/MM/yyyy').format(DateTime(2023, 2, 27));

  int points = 0;
  int money = 0;

  @override
  void initState() {
    super.initState();
    auth.requestDataPeriod(context, start_day, end_day).then((data) {
      if (data != null) {
        final totalSteps = data.fold<int>(0, (sum, step) => sum + step.value);

        setState(() {
          if (totalSteps < 20000) {
            points = 50;
          } else if (totalSteps >= 20000 && totalSteps < 50000) {
            points = 100;
          } else {
            points = 200;
          }
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          child: const Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
          onTap: () => Navigator.pop(context),
        ),
        title: Text('Peace', style: TextStyle(color: Colors.black)),
        elevation: 0,
        backgroundColor: Color.fromARGB(255, 173, 248, 175),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //Goal
              const Text(
                'Our goal',
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 59, 126, 62),
                ),
                textAlign: TextAlign.left,
              ),
              const Divider(
                color: Color.fromARGB(255, 59, 126, 62),
                height: 5,
                thickness: 3,
                endIndent: 235,
              ),
              const SizedBox(height: 5.0),
              const Text(
                  "Our goal is to promote peace and harmony by fostering understanding, cooperation, and conflict resolution through our app.\nWe strive to create a community that advocates for non-violence and works towards creating a world free from conflicts and wars.\nWith your help, we can make a positive impact and contribute to a more peaceful and sustainable future.",
                  textAlign: TextAlign.left,
                  style: TextStyle(fontSize: 15)),
              const SizedBox(height: 20.0),

              //Your help
              const Text(
                'Your help',
                style: TextStyle(
                    fontSize: 22.0,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 59, 126, 62)),
              ),
              const Divider(
                color: Color.fromARGB(255, 59, 126, 62),
                height: 5,
                thickness: 3,
                endIndent: 235,
              ),
              const SizedBox(height: 5),
              const Text(
                "With your support, we can work towards a more peaceful world. By partecipating to the events promoted by our app, you contribute to the cause of peace as we will donate euros 5 to associations involved in providing food, assistence and medical supplies to the people affected by the war in Ukraine.\nTogether, we can make a difference and create a brighter future for everyone.",
                textAlign: TextAlign.left,
                style: TextStyle(fontSize: 15),
              ),
              const SizedBox(
                height: 20.0,
              ),

              //Attended events
              const Text(
                'Check the available events:',
                style: TextStyle(
                    fontSize: 22.0,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 59, 126, 62)),
              ),
              const Divider(
                color: Color.fromARGB(255, 59, 126, 62),
                height: 5,
                thickness: 3,
                endIndent: 130,
              ),
              const SizedBox(height: 5),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.lightGreen, width: 0.4),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        children: [
                          const Text(
                            "Peace4Ukraine",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(
                            width: 29.0,
                          ),
                          Text(
                            'From $formattedStartDisplay to $formattedEndDisplay',
                            style: const TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                                color: Colors.blueGrey),
                          ),
                        ],
                      ),
                    ),
                    const Divider(
                      color: Colors.lightGreen,
                      height: 0.3,
                      thickness: 0.4,
                      indent: 100,
                      endIndent: 100,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            TextButton(
                              onPressed: () {
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10.0)),
                                        title: const Text(
                                          'Peace4Ukraine',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontSize: 20.0,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        content: SingleChildScrollView(
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              const SizedBox(height: 10.0),
                                              const Text(
                                                  'By deciding to participate in this event, you will indirectly sustain UNFPA organization in their assistence to all the people currently affected by the war in Ukraine.\nEvery 1000 steps you make we will donate 1€ to this association.\nAs a reward for your participation, you will earn points based on how many steps you made.\n\nPlease note that this event is one week long. This means that you have 7 days to walk or run as much as you can to do your part in this donation event.',
                                                  style:
                                                      TextStyle(fontSize: 16)),
                                              const SizedBox(height: 18.0),
                                              const Text(
                                                "For more information: ",
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),
                                              InkWell(
                                                child: Text(
                                                  uri.toString(),
                                                  style: const TextStyle(
                                                      color: Colors.blue),
                                                ),
                                                onTap: () => launchUrl(uri),
                                              ),
                                              const SizedBox(height: 30.0),
                                              const Text(
                                                "Points that will be assigned to you based on your achievement:\n-> 200 points if you make less than 60000 steps\n-> 500 points if you make between 60000 and 90000 steps\n-> 1000 points if you make more than 90000 steps",
                                                style: TextStyle(
                                                  fontSize: 16.0,
                                                ),
                                              ),
                                              const SizedBox(height: 10.0),
                                              FutureBuilder<List<Steps>?>(
                                                future: auth.requestDataPeriod(
                                                    context,
                                                    start_day,
                                                    end_day),
                                                builder: (context, snapshot) {
                                                  if (snapshot.hasData) {
                                                    var result = snapshot.data;
                                                    print(
                                                        '\nSteps List (ukrainepage): $result');
                                                    final totalSteps =
                                                        result?.fold<int>(
                                                                0,
                                                                (sum, step) =>
                                                                    sum +
                                                                    step.value) ??
                                                            0;
                                                    money = totalSteps ~/ 1000;
                                                    print(money);
                                                    //If the result isn't null, totalSteps corresond to the sum of all the values returned by the function requestDataPeriod for all the days
                                                    print(
                                                        '\nTOTAL STEPS: $totalSteps\n');
                                                    return SizedBox(
                                                      width: 800,
                                                      height: 150,
                                                      child: Column(
                                                        children: [
                                                          Text(
                                                            'Steps made from $formattedStartDisplay to $formattedEndDisplay: ', //shows me the day of which the steps are shown
                                                            textAlign:
                                                                TextAlign.start,
                                                            style:
                                                                const TextStyle(
                                                              fontSize: 16.0,
                                                              fontStyle:
                                                                  FontStyle
                                                                      .italic,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color:
                                                                  Colors.black,
                                                            ),
                                                          ),
                                                          const SizedBox(
                                                              height: 20),
                                                          Text(
                                                            totalSteps
                                                                .toString(), //total steps done in the week
                                                            textAlign: TextAlign
                                                                .center,
                                                            style:
                                                                const TextStyle(
                                                              fontSize: 18.0,
                                                              fontWeight:
                                                                  FontWeight.bold,
                                                              color:
                                                                  Colors.black,
                                                            ),
                                                          ),
                                                          const SizedBox(
                                                            height: 20,
                                                          ),
                                                          Text(
                                                              'Thanks to you we will donate $money€!', //total steps done in the week
                                                              textAlign: TextAlign.center,
                                                              style:
                                                                  const TextStyle(
                                                                fontSize: 18.0,
                                                                fontStyle: FontStyle.italic,
                                                                color: Colors.black,
                                                              )),
                                                        ],
                                                      ),
                                                    );
                                                  } else if (snapshot
                                                      .hasError) {
                                                    return Text(
                                                        'There is an error: ${snapshot.error}');
                                                  } else {
                                                    return CircularProgressIndicator();
                                                  }
                                                },
                                              ),
                                              const SizedBox(height: 50),
                                              Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                        "You obtained +$points points",
                                                        style: const TextStyle(
                                                            fontSize: 18,
                                                            fontStyle: FontStyle
                                                                .italic,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color:
                                                                Colors.amber)),
                                                    Image.asset(
                                                      "assets/images/gold_medal.png",
                                                      width: 50.0,
                                                      height: 50.0,
                                                    )
                                                  ]),
                                            ],
                                          ),
                                        ),
                                        actions: [
                                          TextButton(
                                              onPressed: () {
                                                Navigator.pop(context);
                                                //Navigator.push(context, MaterialPageRoute(builder: (context) => RunEvent1()));
                                              },
                                              child: Text('Back'))
                                        ],
                                      );
                                    });
                              },
                              child: Row(
                                children: [
                                  Text(
                                    'Review',
                                    style: TextStyle(
                                        fontSize: 14, color: Colors.black),
                                  ),
                                  SizedBox(width: 4.0),
                                  Icon(Icons.rate_review_outlined,
                                      size: 20, color: Colors.green),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 30),

              //Check available events
              const Text(
                'Your attended events:',
                style: TextStyle(
                    fontSize: 22.0,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 59, 126, 62)),
              ),
              const Divider(
                color: Color.fromARGB(255, 59, 126, 62),
                height: 5,
                thickness: 3,
                endIndent: 80,
              ),
              SizedBox(height: 7),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.lightGreen, width: 0.4),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Row(
                        children: const [
                          Text(
                            "No events available right now.",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          /*SizedBox(
                            width: 50.0,
                          ),*/
                        ],
                      ),
                    ),
                    const Divider(
                      color: Colors.lightGreen,
                      height: 0.3,
                      thickness: 0.4,
                      indent: 100,
                      endIndent: 100,
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
