import 'package:flutter/material.dart';
import 'package:my_app/widgets/bottomnavbar.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:country_picker/country_picker.dart';
import 'package:fl_country_code_picker/fl_country_code_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Profile extends StatefulWidget {
  Profile({Key? key}) : super(key: key);

  static const route = '/profilepage/';
  static const routename = 'ProfilePage';

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final _formKey = GlobalKey<FormState>();

  int? RadioVal;

  final TextEditingController ageController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController countryController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  Country? chosenCountry;
  CountryCode? countryCode;
  String? chosenCode;
  final countryPicker = const FlCountryCodePicker();

  @override
  void initState() {
    super.initState();
    _retrieveVar();
  }

  void _retrieveVar() async { 
    final profileData = await SharedPreferences.getInstance();
    
    nameController.text = profileData.getString('name') ?? ''; //defaulting to an empty map when the method return null
    ageController.text = profileData.getString('age') ?? '';
    countryController.text = profileData.getString('country') ?? '';
    cityController.text = profileData.getString('city') ?? '';
    emailController.text = profileData.getString('email') ?? '';
    phoneController.text = profileData.getString('phone') ?? '';
    RadioVal = profileData.getInt('gender');
    chosenCode = profileData.getString('prefix');
    
   setState((){});
    
    
    
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color.fromARGB(255, 78, 189, 81),
        //iconTheme: const IconThemeData(color: Color(0xFF89453C)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          color: Colors.black,
          onPressed: () {
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => BottomNavBar()));
          },
        ),
        
        title: const Text('Profile Information',
            style: TextStyle(color: Colors.black)),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height:20),
            //avatar picture:
            Center(
              child: ClipOval(
                child: CircleAvatar(
                  radius: 60,
                  child: Image.asset('assets/images/avatar_green_pic.png')),
            )),
            
            Padding(
              padding: const EdgeInsets.all(8.0),
              //Initialization of the form with all the fields that define the profile informations
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    
                    //Name field
                    const SizedBox(height: 20),
                    SizedBox(
                      width: 400,
                      child: TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your name';
                            }
                            return null;
                          },
                          controller: nameController,
                          enabled: true,
                          keyboardType: TextInputType.name,
                          decoration: const InputDecoration(
                              icon: Icon(Icons.person,
                                  color: Color.fromARGB(255, 21, 120, 25)),
                              border: UnderlineInputBorder(),
                              focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      width: 2,
                                      color: Color.fromARGB(255, 21, 120, 25))),
                              labelText: 'Name',
                              labelStyle: TextStyle(
                                  color: Color.fromARGB(255, 21, 120, 25),
                                  fontWeight: FontWeight.bold))),
                    ),

                    //gender field
                    const SizedBox(height: 20),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        const SizedBox(width: 10),
                        ListTile(
                          leading: Icon(MdiIcons.genderMaleFemale,
                              color: const Color.fromARGB(255, 21, 120, 25)),
                          title: const Text('GENDER:',
                              style: TextStyle(
                                  color: Color.fromARGB(255, 21, 120, 25),
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold)),
                        ),
                        ListTile(
                          leading: Radio(
                            fillColor: MaterialStateColor.resolveWith(
                                (states) => const Color.fromARGB(255, 21, 120, 25)),
                            toggleable: true,
                            value: 1,
                            groupValue: RadioVal,
                            onChanged: (val)  {
                              setState(()  {
                                RadioVal = val;
                              });
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
                                  (states) => const Color.fromARGB(255, 21, 120, 25)),
                              toggleable: true,
                              value: 2,
                              groupValue: RadioVal,
                              onChanged: (val)  {
                                setState(() {
                                  RadioVal = val;
                                });
                              }
                          ),
                          title: const Text(
                            'FEMALE',
                            style: TextStyle(
                              fontSize: 17.0,
                            ),
                          ),
                        ),
                      ],
                    ),

                    //age field
                    const SizedBox(height: 20),
                    SizedBox(
                      width: 400,
                      child: TextFormField(
                        controller: ageController,
                        enabled: true,
                        keyboardType: TextInputType.number,
                        decoration:  InputDecoration(
                            icon: Icon(MdiIcons.counter,
                              color: const Color.fromARGB(255, 21, 120, 25)),
                            border: const UnderlineInputBorder(),
                            focusedBorder: const UnderlineInputBorder(
                              borderSide: BorderSide(
                                width: 2,
                                color: Color.fromARGB(255, 21, 120, 25))),
                            labelText: 'Age',
                            labelStyle: const TextStyle(
                              color: Color.fromARGB(255, 21, 120, 25),
                              fontWeight: FontWeight.bold))),
                    ),

                    //country scroll field
                    const SizedBox(height: 20),
                    SizedBox(
                      width: 400,
                      child: TextFormField(
                        controller: countryController,
                        keyboardType: TextInputType.none,
                        onTap: () {
                          showCountryPicker(
                            context: context,
                            onSelect: (Country country) {
                              setState(() {
                                chosenCountry = country;
                                countryController.text =
                                    chosenCountry!.displayNameNoCountryCode;
                              });
                            },
                            countryListTheme: CountryListThemeData(
                              flagSize: 25,
                              backgroundColor: Colors.white,
                              textStyle: const TextStyle(
                                  fontSize: 16, color: Colors.blueGrey),
                              bottomSheetHeight:
                                  500, //Country list modal height
                              //Sets the border radius for the bottomsheet.
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(20.0),
                                topRight: Radius.circular(20.0),
                              ),
                              //Styles the search field.
                              inputDecoration: InputDecoration(
                                labelText: 'Search',
                                hintText: 'Start typing to search',
                                prefixIcon: const Icon(Icons.search),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: const Color(0xFF8C98A8)
                                        .withOpacity(0.2),
                                  ),
                                ),
                              ),
                            ),
                          );
                        }, //fine OnTap

                        decoration:  InputDecoration(
                            icon: Icon(MdiIcons.earth,
                                color: Color.fromARGB(255, 21, 120, 25)),
                            border: UnderlineInputBorder(),
                            focusedBorder: const UnderlineInputBorder(
                                borderSide:  BorderSide(
                                    width: 2,
                                    color: Color.fromARGB(255, 21, 120, 25))),
                            labelText: 'Country',
                            labelStyle: const TextStyle(
                                color: Color.fromARGB(255, 21, 120, 25),
                                fontWeight: FontWeight.bold)),
                      ),
                    ),

                    //city field:
                    const SizedBox(height: 20),
                    SizedBox(
                      child: TextFormField(
                          controller: cityController,
                          enabled: true,
                          decoration: InputDecoration(
                              icon: Icon(MdiIcons.cityVariantOutline,
                                  color: Color.fromARGB(255, 21, 120, 25)),
                              border: UnderlineInputBorder(),
                              focusedBorder: const UnderlineInputBorder(
                                  borderSide:  BorderSide(
                                      width: 2,
                                      color: Color.fromARGB(255, 5, 71, 7))),
                              labelText: 'City',
                              labelStyle: const TextStyle(
                                  color: Color.fromARGB(255, 5, 71, 7),
                                  fontWeight: FontWeight.bold))),
                    ),

                    //email field
                    const SizedBox(height: 20),
                    SizedBox(
                      child: TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your email';
                            } else if (!value.contains('@') || !value.contains('.')) {
                              return 'Please enter a valid email address';
                            }
                            return null;
                          },
                          controller: emailController,
                          enabled: true,
                          keyboardType: TextInputType.emailAddress,
                          decoration:  InputDecoration(
                              icon: Icon(MdiIcons.emailOutline,
                                  color: Color.fromARGB(255, 21, 120, 25)),
                              border: const UnderlineInputBorder(),
                              focusedBorder: const UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      width: 2,
                                      color: Color.fromARGB(255, 5, 71, 7))),
                              labelText: 'Email address',
                              labelStyle: const TextStyle(
                                  color: Color.fromARGB(255, 5, 71, 7),
                                  fontWeight: FontWeight.bold))),
                    ),

                    //phone number field
                    const SizedBox(height: 20),
                    SizedBox(
                      child: TextFormField(
                        controller: phoneController,
                        enabled: true,
                        keyboardType: TextInputType.number,
                        textInputAction: TextInputAction.done,
                        decoration: InputDecoration(
                          icon: Icon(MdiIcons.phoneDial,
                            color: Color.fromARGB(255, 21, 120, 25)),
                          border: const UnderlineInputBorder(),
                          focusedBorder: const UnderlineInputBorder(
                              borderSide: BorderSide(
                                  width: 2,
                                  color: Color.fromARGB(255, 5, 71, 7))),
                          labelText: 'Phone number',
                          labelStyle: const TextStyle(
                              color: Color.fromARGB(255, 5, 71, 7),
                              fontWeight: FontWeight.bold),
                          prefixIcon: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 2, vertical: 2
                                ),
                            margin: const EdgeInsets.symmetric(horizontal: 8),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                GestureDetector(
                                  onTap: () async {
                                    final code = await countryPicker.showPicker(context: context);
                                    setState(() {
                                      countryCode = code;
                                      if(countryCode!=null){
                                      chosenCode=countryCode!.dialCode;
                                      }
                                    });
                                  },
                                  child: Row(
                                    children: [
                                      //container for the country flag
                                      /*Container(
                                        child: countryCode != null
                                            ? countryCode!.flagImage
                                            : null,
                                      ),*/
                                      //container for the phone prefix
                                      //const SizedBox(width: 10),
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 16, vertical: 6),
                                        decoration: BoxDecoration(
                                          color: Color.fromARGB(255, 5, 71, 7),
                                          borderRadius: BorderRadius.circular(5),
                                          //border: Border.all(color: Colors.black)
                                        ),
                                        child: Text(
                                            chosenCode ?? "Choose prefix",
                                            //countryCode?.dialCode ?? "Choose prefix",
                                            style: const TextStyle(
                                                color: Colors.white)),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                    )),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        ElevatedButton(
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                final profileData = await SharedPreferences.getInstance();
                                await profileData.setString('name', nameController.text);
                                await profileData.setString('age', ageController.text);
                                await profileData.setString('country', countryController.text);
                                await profileData.setString('city', cityController.text);
                                await profileData.setString('email', emailController.text);
                                await profileData.setString('phone', phoneController.text);
                                if (RadioVal!=null){
                                  await profileData.setInt('gender', RadioVal!);
                                }
                                if(countryCode != null){
                                  await profileData.setString('prefix', chosenCode!);
                                }
                                

                                //print('\nCode:$chosenCode\n');
                                setState((){});

                                ScaffoldMessenger.of(context)
                                  ..removeCurrentSnackBar()
                                  ..showSnackBar(
                                      const SnackBar(content: Text('Data saved!'), duration: Duration(seconds: 2),));

                                //Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => BottomNavBar()));
                              } //fine OnPressed
                            },
                            style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    Color.fromARGB(255, 33, 163, 57),
                                shape: const CircleBorder()),
                            child: const Icon(Icons.check)
                        ),
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
