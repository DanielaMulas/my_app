import 'package:flutter/material.dart';
import 'package:country_picker/country_picker.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:fl_country_code_picker/fl_country_code_picker.dart';


class Profile extends StatefulWidget {
  Profile({Key? key}) : super(key: key);

  static const route = 'user';
  static const routename = 'UserPage';

  @override
  State<Profile> createState() => _ProfileState();
}



class _ProfileState extends State<Profile>{ 
  final _formKey = GlobalKey<FormState>();

  int? RadioVal;

  final TextEditingController ageController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController countryController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  Country ? chosenCountry;

  CountryCode? countryCode;
  final countryPicker= const FlCountryCodePicker();
  

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
        backgroundColor: Colors.white,
        
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          //iconTheme: const IconThemeData(color: Color(0xFF89453C)),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios), color: Colors.black,
            onPressed: () {
              Navigator.pop(context, MaterialPageRoute(builder: (context) => HomePage()));
            },
          ),
          //centerTitle: true,
          title:
              const Text('Profile Information', style: TextStyle(color: Colors.black)),
        ),

        body: SingleChildScrollView(
          child: Column(
            children: [
              Center(
                  child: CircleAvatar(
                      radius: 70, child: Image.asset('assets/avatar.png'))),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      

                      const SizedBox(height: 20),
                      SizedBox(
                        //width: 400,
                        child: TextFormField(
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your name';
                              } /*else if ( ) {
                                return 'Please enter an integer valid number';
                              }*/
                              return null;
                            },
                            controller: nameController,
                            enabled: true,
                            decoration: const InputDecoration(
                                icon: Icon(Icons.person, color: Color.fromARGB(255, 21, 120, 25)),
                                border: UnderlineInputBorder(),
                                focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 2, color: Color.fromARGB(255, 21, 120, 25))),
                                labelText: 'Name',
                                labelStyle: TextStyle(color: Color.fromARGB(255, 21, 120, 25), fontWeight: FontWeight.bold)
                                )),
                      ),

                      
                      const SizedBox(height: 20),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          const SizedBox(width: 10),
                          ListTile(
                            leading: Icon(MdiIcons.genderMaleFemale, color: Color.fromARGB(255, 21, 120, 25)), 
                            title: Text('GENDER:',
                                style: TextStyle(
                                    color: Color.fromARGB(255, 21, 120, 25), fontSize: 20, fontWeight: FontWeight.bold)),
                          ),
                          ListTile(
                            leading: Radio(
                              fillColor: MaterialStateColor.resolveWith(
                                  (states) =>  Color.fromARGB(255, 21, 120, 25)),
                              value: 1,
                              groupValue: RadioVal,
                              onChanged: (val) {
                                setState(() {RadioVal=val;});
                              },
                            ),
                            title: const Text(
                              'MALE',
                              style: TextStyle(fontSize: 17.0),
                            ),
                          ),
                          ListTile(
                            leading: Radio(
                                fillColor: MaterialStateColor.resolveWith(
                                    (states) =>  Color.fromARGB(255, 21, 120, 25)),
                                value: 2,
                                groupValue: RadioVal,
                                onChanged: (val) {
                                  setState(() {RadioVal=val;});
                                }),
                            title: const Text(
                              'FEMALE',
                              style: TextStyle(
                                fontSize: 17.0,
                              ),
                            ),
                          ),
                        ],
                      ),

                      //Secondo children:
                      const SizedBox(height: 20),
                      SizedBox(
                        width: 400,
                        child: TextFormField(
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your age';
                              } else if (int.tryParse(value) == null) {
                                return 'Please enter an integer valid number';
                              }
                              return null;
                            },
                        controller: ageController,
                        enabled: true,
                        decoration: const InputDecoration(
                                icon: Icon(MdiIcons.counter, color: Color.fromARGB(255, 21, 120, 25)),
                                border: UnderlineInputBorder(),
                                focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 2, color: Color.fromARGB(255, 21, 120, 25))),
                                labelText: 'Age',
                                labelStyle: TextStyle(color: Color.fromARGB(255, 21, 120, 25), fontWeight: FontWeight.bold))),
                      ),

  
                      //children per inserimento country
                      const SizedBox(height: 20),
                      SizedBox(
                        width: 400,
                        child: TextFormField(                            
                            onTap:() {
                               showCountryPicker(
                                context: context,
                                countryListTheme: CountryListThemeData(
                                  flagSize: 25,
                                  backgroundColor: Colors.white,
                                  textStyle: TextStyle(fontSize: 16, color: Colors.blueGrey),
                                  bottomSheetHeight: 500, // Optional. Country list modal height
                                  //Optional. Sets the border radius for the bottomsheet.
                                    borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(20.0),
                                    topRight: Radius.circular(20.0),
                                  ),
                                  //Optional. Styles the search field.
                                  inputDecoration: InputDecoration(
                                    labelText: 'Search',
                                    hintText: 'Start typing to search',
                                    prefixIcon: const Icon(Icons.search),
                                    border: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: const Color(0xFF8C98A8).withOpacity(0.2),
                                      ),
                                    ),                                    
                                  ),
                                ),
                                onSelect: (Country country)  {                                  
                                   setState(() {chosenCountry=country;});                                
                                  //print('Selected country: ${country.displayName}');
                                },                                
                              );
                              
                            }, //fine OnTap
                            
                            
                            //WRONG!!!!!!!!!                        
                            /*validator: (countryChosen) {
                              if (countryChosen == null || countryChosen.isEmpty) {
                                return 'Please select your country';
                              } else
                                return countryChosen;
                            },
                            controller: countryController,*/
                            decoration: const InputDecoration(
                                icon: Icon(MdiIcons.earth, color: Color.fromARGB(255, 21, 120, 25)),
                                border: UnderlineInputBorder(),
                                focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 2, color: Color.fromARGB(255, 21, 120, 25))),
                                labelText: 'Country',
                                labelStyle: TextStyle(color: Color.fromARGB(255, 21, 120, 25), fontWeight: FontWeight.bold)
                                )),
                      ),
                      
                      //children per inserimento città
                      const SizedBox(height: 20),
                      SizedBox(
                        //width: 400,
                        child: TextFormField(
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your city';
                              } /*else if () {
                                return 'Please enter an integer valid number';
                              }*/
                              return null;
                            },
                            controller: cityController,
                            enabled: true,
                            decoration: const InputDecoration(
                                icon: Icon(MdiIcons.cityVariantOutline, color: Color.fromARGB(255, 21, 120, 25)),
                                border: UnderlineInputBorder(),
                                focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 2, color: Color.fromARGB(255, 5, 71, 7))),
                                labelText: 'City',
                                labelStyle: TextStyle(color: Color.fromARGB(255, 5, 71, 7), fontWeight: FontWeight.bold)
                                )),
                      ),


                      //children per inserimento mail
                      const SizedBox(height: 20),
                      SizedBox(
                        //width: 400,
                        child: TextFormField(
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your email';
                              } /*else if ( ) {
                                return 'Please enter an integer valid number';
                              }*/
                              return null;
                            },
                            controller: emailController,
                            enabled: true,
                            keyboardType: TextInputType.emailAddress,
                            decoration: const InputDecoration(
                                icon: Icon(MdiIcons.emailOutline, color: Color.fromARGB(255, 21, 120, 25)),
                                border: UnderlineInputBorder(),
                                focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 2, color: Color.fromARGB(255, 5, 71, 7))),
                                labelText: 'Email address',
                                labelStyle: TextStyle(color: Color.fromARGB(255, 5, 71, 7), fontWeight: FontWeight.bold)
                                )),
                      ),

                      //children per numero di telefono
                      const SizedBox(height: 20),
                      SizedBox(
                        //width: 400,
                        child: TextFormField(
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your email';
                              } else if (int.tryParse(value) == null) {
                                return 'Please enter an integer valid number';
                              }
                              return null;
                            },
                            controller: phoneController,
                            enabled: true,
                            keyboardType: TextInputType.number,
                            textInputAction: TextInputAction.done,
                            maxLines: 1,

                            decoration: InputDecoration(
                                icon: Icon(MdiIcons.phoneDial, color: Color.fromARGB(255, 21, 120, 25)),
                                border: UnderlineInputBorder(),
                                focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 2, color: Color.fromARGB(255, 5, 71, 7))),
                                labelText: 'Phone number',
                                labelStyle: TextStyle(color: Color.fromARGB(255, 5, 71, 7), fontWeight: FontWeight.bold),
                                prefixIcon: Container(
                                  padding:  const EdgeInsets.symmetric(horizontal: 15, vertical: 6),
                                  margin: const EdgeInsets.symmetric(horizontal: 8),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      GestureDetector(
                                        onTap: () async {
                                          final code= await countryPicker.showPicker(context:context);
                                          setState(() {
                                            countryCode=code;
                                          });
                                        },
                                        child: Row(
                                          children: [
                                            Container(                                     
                                            
                                              child: countryCode != null ? countryCode!.flagImage : null,                                            
                                            ),
                                            const SizedBox(width: 10),
                                            Container(
                                              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                                              decoration: BoxDecoration(
                                                color: Colors.black,
                                                borderRadius: BorderRadius.circular(5),
                                                //border: Border.all(color: Colors.black)
                                              ),
                                              child: Text(
                                                countryCode?.dialCode ?? "Choose prefix", 
                                                style: const TextStyle(color: Colors.white)
                                              ),   
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                            ),
                        )
                      ),
                      




                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          ElevatedButton(
                              onPressed: () async {
                                if (_formKey.currentState!.validate()) {}
                              },
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFF83AA99),
                                  shape: const CircleBorder()),
                              child: const Icon(Icons.check)),
                        ],
                     ),
                   ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
        
  } //build
} //Page