import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Peace extends StatefulWidget {
  Peace({Key? key}) : super(key: key);

  static const route = '/peace/';
  static const routename = 'Peace';

  @override
  State<Peace> createState() => _PeaceState();
}

class _PeaceState extends State<Peace> {
  var uri = Uri(
    scheme: 'https',
    host: 'unfpa.org',
    path: 'donate/Ukraine-a?utm_campaign=HO-UA-22-Ukraine&utm_content=evergreen&gclid=CjwKCAiA1JGRBhBSEiwAxXblwULSSi1DDIzP6plSTz6QXYPRCsEeAlCRoHlpGFsQ4qf3-GGDL3iIeRoCJ9IQAvD_BwE',
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
              // Goal
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
                style: TextStyle(fontSize: 15),
              ),
              const SizedBox(height: 25.0),

              // Your help
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
              const SizedBox(height: 10.0,),
              Row(
                children: [
                  const Text(
                    "For more information: ",
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                  InkWell(
                    child: const Text(
                      "https://www.unfpa.org/",
                      style: TextStyle(color: Colors.blue),
                    ),
                    onTap: () => launchUrl(uri),
                  )
                ],
              ),
              const SizedBox(height: 30.0),

              // Attended events
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
              const Text("Oops, you have not attended any peace-related events yet.",
                  style: TextStyle(fontSize: 15)),
              SizedBox(height: 30),

              // Check available events
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
