import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class AboutPage extends StatefulWidget{
  const AboutPage({Key? key}) : super(key: key);

  static const route = '/aboutpage/';
  static const routeDisplayName = 'AboutPage';
  
  @override
  State<AboutPage> createState() => _AboutPage();
}

class _AboutPage extends State<AboutPage> {
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: GestureDetector(
            child: const Icon(Icons.arrow_back_ios),
            onTap: () => Navigator.pop(context)//Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => BottomNavBar())),
          ),
          //centerTitle: true,
          title: const Text("About Us"),
        ),
        body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 20),
            child: SingleChildScrollView(
              child: Column(
                //mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  
                  //App name
                  const Text(
                    'Step4Rights',
                    style: TextStyle(fontSize: 28.0, fontWeight: FontWeight.bold, color: Color.fromARGB(255, 59, 126, 62),),
                    textAlign: TextAlign.left,
                  ),
                  const Divider(height: 10, thickness:5, color: Color.fromARGB(255, 59, 126, 62), endIndent: 0),
                  const SizedBox(height: 10.0),
                  
                  // App Logo
                  Center(
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.green,),
                        borderRadius: const BorderRadius.all(Radius.circular(60)),
                        ),
                      child: ClipOval(
                        child: CircleAvatar(
                          backgroundColor: Colors.white,
                          radius: 60,
                          child: Image.asset('assets/images/logo_app.jpg'),
                                      )),
                    )),
                  const SizedBox(height: 20.0),

                  
                  /*const Text(
                    'Our Slogan', 
                    style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold, color: Color.fromARGB(255, 59, 126, 62)),
                  ),
                  const Divider(
                    color: Color.fromARGB(255, 59, 126, 62), 
                    height: 5,
                    thickness: 3,
                    endIndent: 235,
                  ),*/
                  const SizedBox(height: 5),
                  const Center(
                    child: Text(
                      'TRAIN FOR WHAT YOU BELIEVE IN!',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(height: 20.0),

                  //Slogan section
                  const Text(
                    'Our Slogan', 
                    style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold, color: Color.fromARGB(255, 59, 126, 62)),
                  ),
                  const Divider(
                    color: Color.fromARGB(255, 59, 126, 62), 
                    height: 5,
                    thickness: 3,
                    endIndent: 235,
                  ),
                  const SizedBox(height: 5),
                  const Text(
                    ' "Train for what you believe in" encapsulates the core message of the app.\nIt encourages individuals to align their physical training and fitness goals with their personal beliefs and values.',
                    textAlign: TextAlign.left,
                    style: TextStyle(fontSize: 15),
                  ),
                  const SizedBox(height: 20.0),

                  // How it works section
                  const Text(
                    'Our Mission', 
                    style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold, color: Color.fromARGB(255, 59, 126, 62)),
                  ),
                  const Divider(
                    color: Color.fromARGB(255, 59, 126, 62), 
                    height: 5,
                    thickness: 3,
                    endIndent: 220,
                  ),
                  const SizedBox(height: 5),
                  const Text(
                    'The aim of this app is to promote education about social causes thorugh physical training.\nIn particular, it aims to raise awareness about important issues while encouraging people to take action and make a positive impact in their daily lives.',// you can support different causes only by walking or running!\nIn this way we want to promote both a healthy lifestyle and more awareness about social rights.',
                    textAlign: TextAlign.left,
                    style: TextStyle(fontSize: 15),
                  ),
                  const SizedBox(height: 20.0),

                  

                  //EXPLANATION SECTION
                  const Text(
                    'How it works', 
                    style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold, color: Color.fromARGB(255, 59, 126, 62)),
                  ),
                  const Divider(
                    color: Color.fromARGB(255, 59, 126, 62), 
                    height: 5,
                    thickness: 3,
                    endIndent: 220,
                  ),
                  const SizedBox(height: 5),
                  const Text(
                    'This app promotes physical training by counting the steps you make and donating to the causes you choose based on how many steps you do.\nFor every step counted we commit to donate a certain amount of money to the association you have chosen.\nIn this way, you can contribute to a worthy cause simply by engaging with the app while mantain a healthy lifestyle.',// you can support different causes only by walking or running!\nIn this way we want to promote both a healthy lifestyle and more awareness about social rights.',
                    textAlign: TextAlign.left,
                    style: TextStyle(fontSize: 15),
                  ),
                  const SizedBox(height: 20.0),

                  // DEVELOPERS SECTION
                  //Title
                  const Text(
                    'Developers', 
                    style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold, color: Color.fromARGB(255, 59, 126, 62),),
                  ),
                  const Divider(
                    color: Color.fromARGB(255, 59, 126, 62), 
                    height: 5,
                    thickness: 3,
                    endIndent: 230,
                  ),
                  
                  //Names
                  ListTile(
                    title: const Text('Paola Righetto'),
                    leading: Icon(
                      MdiIcons.accountTieWoman,
                      color: const Color.fromARGB(255, 59, 126, 62),
                    ),
                  ),
                  ListTile(
                    title: const Text('Daniela Mulas'),
                    leading: Icon(
                      MdiIcons.accountTieWoman,
                      color: const Color.fromARGB(255, 59, 126, 62),
                    ),
                  ),
                  const SizedBox(height:20),

                  //Contacts section
                  //Title
                  const Text(
                    'Contacts', 
                    style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold, color: Color.fromARGB(255, 59, 126, 62),),
                  ),
                  const Divider(
                    color: Color.fromARGB(255, 59, 126, 62), 
                    height: 5,
                    thickness: 3,
                    endIndent: 255,
                  ),
                  //Information
                  ListTile(
                    title: Text('paola.righetto.1@studenti.unipd.it'),
                    leading: Icon(
                      MdiIcons.email,
                      color: Color.fromARGB(255, 59, 126, 62)
                    ),
                  ),
                  ListTile(
                    title: Text('daniela.mulas@studenti.unipd.it'),
                    leading: Icon(
                      MdiIcons.email,
                      color: Color.fromARGB(255, 59, 126, 62)
                    ),
                  )
                ],
              ),
            ),
          ),
        
      );// WillPopScope give us control over the back button action
  }
}



   
  




