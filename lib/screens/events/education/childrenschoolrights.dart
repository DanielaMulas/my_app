import 'package:flutter/material.dart';
//import 'package:my_app/screens/events/humanrights/runningevent.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:my_app/models/authorization.dart';
import 'package:my_app/models/steps.dart';
import 'package:intl/intl.dart';

class ChildrenSchoolRights extends StatefulWidget {
  const ChildrenSchoolRights({Key? key}) : super(key: key);

  @override
  State<ChildrenSchoolRights> createState() => _ChildrenSchoolRights();
}

class _ChildrenSchoolRights extends State<ChildrenSchoolRights> {
  var uri = Uri(
    scheme: 'https',
    host: 'unicef.it',
    path: 'programmi/istruzione',
  );

  final Authorization auth = Authorization();
  DateTime start_day = DateTime(2023, 5, 20);
  DateTime end_day = DateTime(2023, 5, 26);
  String formattedStartDisplay =
      DateFormat('dd/MM/yyyy').format(DateTime(2023, 5, 20));
  String formattedEndDisplay =
      DateFormat('dd/MM/yyyy').format(DateTime(2023, 5, 26));

  int points = 0;
  int money = 0;

  @override
  void initState() {
    super.initState();
    auth.requestDataPeriod(context, start_day, end_day).then((data) {
      /*The callback function (data) {...} will be invoked with the result of the Future when it becomes available. 
      The result is passed as an argument to the callback function, and in this case, it is named "data"*/
      if (data != null) {
        final totalSteps = data.fold<int>(0, (sum, step) => sum + step.value);

        setState(() {
          if (totalSteps < 50000) {
            points = 100;
          } else if (totalSteps < 80000 && totalSteps > 50000) {
            points = 250;
          } else {
            points = 500;
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
        title: Text('Children Rights', style: TextStyle(color: Colors.black)),
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
                  "Equal Access to Education for All Children:\nThe goal of this section is to ensure that every child, regardless of their geographical location, socioeconomic background, or social conditions, has the same opportunities to access quality education.",
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
                "With your support, we can make a difference in making the school accessible to every child.\nEvery step you take in our virtual events will contribute to meaningful changes: we will donate a certain amount of money based on how many steps you make to associations which support the construction of new schools or that offer scholarships, grants, or financial aid programs to support children from economically disadvantaged backgrounds. As you participate, you will earn reward points as a token of our appreciation.",
                textAlign: TextAlign.left,
                style: TextStyle(fontSize: 15),
              ),
              const SizedBox(
                height: 20.0,
              ),

              //Attended events
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
                            "School4Everyone",
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
                                          'Unicef walk',
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
                                                  'By deciding to participate in this event, you will indirectly sustain Unicef organization, that works towards increasing access to education for all children, especially those who are marginalized or disadvantaged.\nEvery 1000 steps you make we will donate 1€ to this association.\nAs a reward for your participation, you will earn points based on how many steps you made.\n\nPlease note that this event is one week long. This means that you have 7 days to walk or run as much as you can to do your part in this donation event.',
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
                                                "Points that will be assigned to you based on your achievement:\n-> 100 points if you make less than 50000 steps\n-> 250 points if you make between 50000 and 80000 steps\n-> 500 points if you make more than 80000 steps",
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
                                                        '\nSteps List (childrenPage): $result');
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
                                                                  FontWeight
                                                                      .bold,
                                                              color:
                                                                  Colors.black,
                                                            ),
                                                          ),
                                                          const SizedBox(
                                                            height: 20,
                                                          ),
                                                          Text(
                                                              'Thanks to you we will donate $money€!', //total steps done in the week
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                              style:
                                                                  const TextStyle(
                                                                fontSize: 18.0,
                                                                fontStyle:
                                                                    FontStyle
                                                                        .italic,
                                                                color: Colors
                                                                    .black,
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
