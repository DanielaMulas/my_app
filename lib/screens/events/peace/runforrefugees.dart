import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Run4Refugee extends StatelessWidget {
  Run4Refugee({Key? key}) : super(key: key);

  static const route = '/run4Refugees/';
  static const routename = 'Run4Refugees';

  final uri = Uri(
    scheme: 'https',
    host: 'dona.unhcr.it',
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
        title: Text('Run4Refugees', style: TextStyle(color: Colors.black)),
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
                  "Our goal is to support and empower refugees by promoting inclusivity, compassion, and equality through our app. We aim to foster awareness, understanding, and respect for individuals who have been forced to flee their homes due to conflict, persecution, or other life-threatening circumstances.",
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
                "With your help, we can work towards creating a society that embraces and welcomes refugees, providing them with the support they need to rebuild their lives and integrate into their new communities. Together, we can stand against discrimination, promote human rights, and advocate for fair and just treatment of refugees worldwide.",
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
                      "https://dona.unhcr.it/",
                      style: TextStyle(color: Colors.blue),
                    ),
                    onTap: () => launchUrl(uri),
                  )
                ],
              ),
              const SizedBox(height: 30.0),

              //Attended events
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
              const Text("Ops, you have attended 0 events for helping refugees.",
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
