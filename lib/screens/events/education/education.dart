import 'package:flutter/material.dart';
import 'package:my_app/screens/events/education/childrenschoolrights.dart';
import 'package:my_app/screens/events/education/accessibility.dart';


class Education extends StatelessWidget {
  const Education({Key? key}) : super(key: key);

  static const route = '/humanrights/';
  static const routename = 'HumanRights';

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Education', style: TextStyle(color: Colors.black)),
          elevation: 0,
          backgroundColor: Color.fromARGB(255, 173, 248, 175),
          leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          color: Colors.black,
          onPressed: () => Navigator.pop(context),),
        ),
        body: GridView.count(
          primary: false,
          padding: const EdgeInsets.all(20),
          mainAxisSpacing: 10,
          crossAxisCount: 1,
          children: [
            MaterialButton(
              //padding: const EdgeInsets.all(8),
              onPressed:() {Navigator.push(context, MaterialPageRoute(builder: (context) => ChildrenSchoolRights()));
              },
              color: Color.fromARGB(255, 178, 255, 192),
              splashColor: Colors.greenAccent,
              child: Container(
                  decoration: const BoxDecoration(
                  image: DecorationImage(image: AssetImage('assets/images/children_education.png'),
                  //fit: BoxFit.scaleDown
                  )
                ),
                child: const Align(
                  alignment: Alignment.topCenter,
                  child: Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Text(
                      "Children Education Events",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black,
                        //backgroundColor: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),              
              ),
            ),

            MaterialButton(
              
              //padding: const EdgeInsets.all(8),
              onPressed:() {Navigator.push(context, MaterialPageRoute(builder: (context) => Access()));
              },
              color: Color.fromARGB(255, 178, 255, 192),
              splashColor: Colors.greenAccent,
              child: Container(
                  decoration: const BoxDecoration(
                  image: DecorationImage(image: AssetImage('assets/images/disability_accessibility.jpg'),
                  //fit: BoxFit.scaleDown
                  )
                ),
                child: const Align(
                  alignment: Alignment.topCenter,
                  child: Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Text(
                      "Accessibility to Education",// Disabled Education Events
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black,
                        //backgroundColor: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),              
              ),
            ),
            
                       
          ],
        ));
  }
}
