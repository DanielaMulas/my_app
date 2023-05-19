import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false, // the screen does not close automatically when the back button is pressed
      child: Scaffold(
        appBar: AppBar(
          leading: GestureDetector(
            child: Icon(Icons.arrow_back_ios), // the default arrow icon button has been changed to one having more style
            onTap: () => Navigator.pop(context),
          ), // manually handling the back button
          centerTitle: true,
          title: Text("About us"),
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // App Name
                  Text('App Name', style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold,),),
                  SizedBox(height: 20.0),

                  // App Logo
                  Image.asset('assets/images/icon_app.png', width: 120.0, height: 120.0,),
                  SizedBox(height: 20.0),

                  // Mission Section
                  Text('Our Mission', style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold,),),
                  Text('Write your mission statement here', textAlign: TextAlign.center,),
                  SizedBox(height: 20.0),

                  // Values Section
                  Text('Our Values', style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold,),),
                  Text('Write your values statement here', textAlign: TextAlign.center,),
                  SizedBox(height: 20.0),

                  // Developers Section
                  Text('Developers', style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold,),),
                  SizedBox(height: 10.0),

                  // Developer 1
                  DeveloperCard(
                    name: 'Christian Dragonetti',
                    bio: 'Write a short bio of the developer',
                    linkedinUrl: Uri.parse('https://www.linkedin.com/in/christian-dragonetti-942bb7211/'),
                  ),
                  SizedBox(height: 10.0),

                  // Developer 2
                  DeveloperCard(
                    name: 'Paola Righetto',
                    bio: 'Write a short bio of the developer',
                    linkedinUrl: Uri.parse('https://www.linkedin.com/developer2'),
                  ),
                  SizedBox(height: 10.0),

                  // Developer 3
                  DeveloperCard(
                    name: 'Daniela',
                    bio: 'Write a short bio of the developer',
                    linkedinUrl: Uri.parse('https://www.linkedin.com/developer3'),
                  ),
                  SizedBox(height: 20.0),
                ],
              ),
            ),
          ),
        ),
      ),
    ); // WillPopScope give us control over the back button action
  }
}


class DeveloperCard extends StatelessWidget {
  final String name;
  final String bio;
  final Uri linkedinUrl;

  const DeveloperCard({
    required this.name,
    required this.bio,
    required this.linkedinUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(10.0),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10.0), color: Colors.grey[200],),
      child: Column(
        children: [
          Text(name, style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold,),),
          SizedBox(height: 10.0),
          Text(bio, textAlign: TextAlign.center,),
          SizedBox(height: 10.0),
          ElevatedButton(
              onPressed: () async {
              if(await canLaunchUrl(linkedinUrl)){
                await launchUrl(linkedinUrl, mode: LaunchMode.inAppWebView);
              }
              else{
                throw "Couldn't launch ${linkedinUrl}";
              }
            },
            child: Text('LinkedIn'),
          ),
        ],
      ),
    );
  }
}





