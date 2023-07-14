import 'package:flutter/material.dart';
import 'package:my_app/screens/events/humanrights/runningevent.dart';
import 'package:url_launcher/url_launcher.dart';

class WomanRights extends StatelessWidget {
  WomanRights({Key? key}) : super(key: key);

  static const route = '/womenrights/';
  static const routename = 'WomenRights';

  final uri = Uri(
    scheme: 'https',
    host: 'associazionefrida.it',
  );

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
        title: const Text('Women Rights', style: TextStyle(color: Colors.black)),
        elevation: 0,
        backgroundColor: const Color.fromARGB(255, 173, 248, 175),
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
                  "Our goal is to empower women and promote gender equality by fostering awareness, participation, and action through our app. We aim to create a community that advocates for women's rights and works towards creating a more inclusive society.",
                  textAlign: TextAlign.left,
                  style: TextStyle(fontSize: 15)),
              const SizedBox(height: 25.0),

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
                "With your support, we can make a difference in the fight for women's rights and gender equality.\nEvery step you take in our virtual marches will contribute to meaningful change: we will donate an amount of money that depends on the number of steps you take to associations dedicated to advocating for equality and supporting women who are victims of domestic violence. As you participate, you will earn reward points based on the amount of steps you take as a token of our appreciation.",
                textAlign: TextAlign.left,
                style: TextStyle(fontSize: 15),
              ),
              const SizedBox(height: 30),
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
              const Text(
                  "Ops, you have attended 0 events about women's rights.",
                  style: TextStyle(fontSize: 15)),
              const SizedBox(height: 30),

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
              const SizedBox(height: 7),

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
                            "Gender Equality",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                            width: 50.0,
                          ),
                          Text(
                            'Date: 18/07/2023',
                            style: TextStyle(
                                fontSize: 12,
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
                                          'Gender Equality March',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontSize: 20.0,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        content: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const SizedBox(height: 10.0),
                                            const Text(
                                                'By deciding to participate in this event, you will help us in the fight against gender stereotypes and contribute to create a more inclusive society.\n\nAs a reward for your participation, you will earn a certain amount of points based on the steps you have made, just like the money we will donate to associations that work to protect women and fight for their rights.  .\n\nPlease note that this event is a single-day event. This means that you have the entire day to complete this task.\nThe number of steps you must take to succeed is 9000.',
                                                style: TextStyle(fontSize: 16)),
                                            
                                            const SizedBox(
                                              height: 18.0,
                                            ),
                                            const Text(
                                              "For more information: ",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w600),
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
                                              "Your prize in case you take 9000 steps:",
                                              style: TextStyle(
                                                  fontSize: 16.0,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            const SizedBox(height: 10.0),
                                            Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  const Text("+100 points",
                                                      style: TextStyle(
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors.amber)),
                                                  Image.asset(
                                                    "assets/images/bronze_medal.png",
                                                    width: 50.0,
                                                    height: 50.0,
                                                  )
                                                ]),
                                          ],
                                        ),
                                        actions: [
                                          TextButton(
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                              child: const Text('Cancel')),
                                          TextButton(
                                              onPressed: () {
                                                Navigator.pop(context);
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            RunEvent1()));
                                              },
                                              child: const  Text('Confirm'))
                                        ],
                                      );
                                    });
                              },
                              child: Row(
                                children: [
                                  Text(
                                    'Participate',
                                    style: TextStyle(
                                        fontSize: 12, color: Colors.black),
                                  ),
                                  SizedBox(width: 4.0),
                                  Icon(Icons.arrow_forward_sharp,
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
            ],
          ),
        ),
      ),
    );
  }
}
