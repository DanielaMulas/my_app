import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:intl/intl.dart';

class Access extends StatelessWidget {
  Access({Key? key}) : super(key: key);

  static const route = '/accessibility/';
  static const routeName = 'Accessibility';

  final uri = Uri(
    scheme: 'https',
    host: 'sightsavers.org',
    path: '/disability/education/',
  );

  final DateTime start_day = DateTime(2023, 12, 10);
  final DateTime end_day = DateTime(2023, 12, 14);
  final String formattedStartDisplay =
      DateFormat('dd/MM/yyyy').format(DateTime(2023, 12, 10));
  final String formattedEndDisplay =
      DateFormat('dd/MM/yyyy').format(DateTime(2023, 12, 14));

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
        title: const Text('Physical Accessibility to Education',
            style: TextStyle(color: Colors.black)),
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
                'Our Goal',
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
                  "Our goal is to ensure physical accessibility to education for all individuals, regardless of their abilities or disabilities. We strive to create an inclusive learning environment that accommodates diverse needs and empowers every student to reach their full potential. By removing barriers and providing necessary resources, we aim to promote equal educational opportunities and foster an inclusive society.",
                  textAlign: TextAlign.left,
                  style: TextStyle(fontSize: 15)),
              const SizedBox(height: 25.0),

              //Your Help
              const Text(
                'Your Help',
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
                "With your support, we can make a significant impact in improving physical accessibility to education. By advocating for accessible infrastructure, inclusive classroom designs, assistive technologies, and equal opportunities for all students, we can create an educational system that values and prioritizes physical accessibility. Together, let's ensure that no one is left behind due to physical barriers.",
                textAlign: TextAlign.left,
                style: TextStyle(fontSize: 15),
              ),

              const SizedBox(height: 30.0),

              //Ongoing Initiatives
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
              const Text("Ops, you have attended 0 events about accessibility.",
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
                      padding: const EdgeInsets.all(7.0),
                      child: Row(
                        children: [
                          const Text(
                            "School Inclusivity",
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
                                          'School Inclusivity',
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
                                                  'By deciding to participate in this event, you will indirectly sustain Sightsavers organization, that works with schools, communities, governments and organisations of people with disabilities to ensure children with all types of disability, and particularly girls with disabilities, are able to learn alongside their peers in pre-school, through to primary and secondary school.\nEvery 1000 steps you make we will donate 1€ to this association.\nAs a reward for your participation, you will earn points based on how many steps you made.\n\nPlease note that you can partecipate once you get closer to the beginning of the event. The event lasts 5 days, that means that you have 5 days to walk or run as much as you can to do your part in this donation event.',
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
                                                "Points that will be assigned to you based on your achievement:\n-> 50 points if you make less than 50000 steps\n-> 150 points if you make between 50000 and 75000 steps\n-> 500 points if you make more than 75000 steps",
                                                style: TextStyle(
                                                  fontSize: 16.0,
                                                ),
                                              ),
                                              const SizedBox(height: 10.0),
                                            ],
                                          ),
                                        ),
                                        actions: [
                                          TextButton(
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                              child: const Text('Back'))
                                        ],
                                      );
                                    });
                              },
                              child: Row(
                                children: const [
                                  Text(
                                    'Description',
                                    style: TextStyle(
                                        fontSize: 14, color: Colors.black),
                                  ),
                                  SizedBox(width: 4.0),
                                  Icon(Icons.description_outlined,
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
