import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Access extends StatelessWidget {
  Access({Key? key}) : super(key: key);

  static const route = '/accessibility/';
  static const routeName = 'Accessibility';

  var uri = Uri(
    scheme: 'https',
    host: 'sightsavers.org',
    path: '/disability/education/',
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
        title: Text('Physical Accessibility to Education', style: TextStyle(color: Colors.black)),
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
              const SizedBox(
                height: 10.0,
              ),
              Row(
                children: [
                  const Text(
                    "For more information: ",
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                  InkWell(
                    child: const Text(
                      "https://www.sightsavers.org",
                      style: TextStyle(color: Colors.blue),
                    ),
                    onTap: () => launchUrl(uri),
                  )
                ],
              ),
              const SizedBox(height: 30.0),

              //Ongoing Initiatives
              const Text(
                'Here are your attended events:',
                style: TextStyle(
                    fontSize: 22.0,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 59, 126, 62)),
              ),
              const Divider(
                color: Color.fromARGB(255, 59, 126, 62),
                height: 5,
                thickness: 3,
                endIndent: 15,
              ),
              const SizedBox(height: 5),
              const Text("Ops, you have attended to 0 events about accessibility.",
                  style: TextStyle(fontSize: 15)),
              SizedBox(height: 30),

              //Check available events
              const Text(
                'Check the available events here:',
                style: TextStyle(
                    fontSize: 22.0,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 59, 126, 62)),
              ),
              const Divider(
                color: Color.fromARGB(255, 59, 126, 62),
                height: 5,
                thickness: 3,
                endIndent: 15,
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
                        children: [
                          Text(
                            "No events available yet.",
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
                    Divider(
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
