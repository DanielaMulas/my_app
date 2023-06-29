import 'package:flutter/material.dart';
import 'package:my_app/screens/runningevent.dart';

class WomanRights extends StatefulWidget {
  WomanRights({Key? key}) : super(key: key);

  static const route = '/womanrights/';
  static const routename = 'WomanRights';

  @override
  State<WomanRights> createState() => _WomanRights();
}

class _WomanRights extends State<WomanRights> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          child: const Icon(Icons.arrow_back_ios),
          onTap: () => Navigator.pop(context),
        ),
        title: Text('Woman Rights', style: TextStyle(color: Colors.black)),
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
                'With your help, we can reach our purpose: every little step in this fight is important, yours especially!\nEverytime you decide to partecipate in one of our virtual marches, we will donate *random number of euros* to an association whose purpose is to boh, advocate for equality? Protect women victim of domestic violence? JOIN US E GRZ PER CAGARCI, ah and by the way we will gift you tot points, keep going and you will get our special prize for you (nulla).',
                textAlign: TextAlign.left,
                style: TextStyle(fontSize: 15),
              ),
              const SizedBox(height: 20.0),

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
                            'Date: 2023/06/28',
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: Colors.blueGrey),
                          ),
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
                                  builder: (BuildContext context){  
                                    return AlertDialog(
                                      title: Text('Gender Equality March', textAlign: TextAlign.center, style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),),
                                      content: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text('By deciding to partecipate to this event, you will help us in the fight against gender stereotypes and blablabla')
                                        ],
                                      ),
                                      actions: [
                                        TextButton(onPressed: () {
                                          Navigator.pop(context);
                                        }, 
                                        child: Text('Cancel')),
                                        TextButton(onPressed: (){
                                          Navigator.pop(context);
                                          Navigator.push(context, MaterialPageRoute(builder: (context) => RunEvent()));
                                        }, 
                                        child: Text('Confirm'))
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
