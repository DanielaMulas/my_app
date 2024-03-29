import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Pride extends StatelessWidget {
  Pride({Key? key}) : super(key: key);

  static const route = '/pride/';
  static const routename = 'Pride';

  final uri = Uri(
    scheme: 'https',
    host: 'associazionearc.eu',
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
        title: const Text('Pride', style: TextStyle(color: Colors.black)),
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
                  "Our goal is to celebrate and support the LGBTQ+ community by promoting inclusivity, acceptance, and equality through our app.\nWe aim to foster awareness, understanding, and respect for all sexual orientations and gender identities.\nWith your help, we can work towards creating a society that embraces diversity and stands against discrimination.",
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
                "With your support, we can make a difference in the fight for LGBTQ+ rights and equality. Every step you take in our virtual marches will contribute to meaningful change: we will donate a certain amount of money based on how many steps you've made to LGBTQ+ organizations dedicated to advocating for equality and supporting individuals who face discrimination and prejudice. As you participate, you will earn reward points as a token of our appreciation.",
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
                    child: Text(
                      uri.toString(),
                      style: const TextStyle(color: Colors.blue),
                    ),
                    onTap: () => launchUrl(uri),
                  )
                ],
              ),
              const SizedBox(height: 30.0),

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
              const Text("Ops, you have attended 0 events about pride.",
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
                            "No events available yet.",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
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
