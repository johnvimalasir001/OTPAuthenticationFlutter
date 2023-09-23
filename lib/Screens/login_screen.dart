import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:otp_auth/Provider/auth_provider.dart';

import 'package:otp_auth/Widgets/widgets.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController textController = TextEditingController();

  Country selectedCountry = Country(
      phoneCode: "91",
      countryCode: "IN",
      e164Sc: 0,
      geographic: true,
      level: 1,
      name: "India",
      example: "India",
      displayName: "India",
      displayNameNoCountryCode: "IN",
      e164Key: "");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 35,
                vertical: 25,
              ),
              child: Column(
                children: [
                  const Text(
                    "Log in",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 40),
                  Image.asset(
                    "assets/images/login_image.png",
                    height: 250,
                    fit: BoxFit.cover,
                  ),
                  const SizedBox(height: 100),
                  TextFormField(
                    keyboardType: const TextInputType.numberWithOptions(),
                    cursorColor: Colors.black,
                    controller: textController,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                    decoration: InputDecoration(
                      hintText: "Phone Number",
                      hintStyle: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey.shade600,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: const BorderSide(color: Colors.grey),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: const BorderSide(color: Colors.grey),
                      ),
                      prefixIcon: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                "+ ${selectedCountry.phoneCode}",
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: Colors.grey,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                showCountryPicker(
                                  context: context,
                                  countryListTheme: const CountryListThemeData(
                                    bottomSheetHeight: 500,
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(20),
                                      topRight: Radius.circular(20),
                                    ),
                                  ),
                                  onSelect: (value) {
                                    setState(() {
                                      selectedCountry = value;
                                    });
                                  },
                                );
                              },
                              child: const Icon(
                                Icons.arrow_drop_down,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 40),
                  SizedBox(
                    height: 50,
                    width: double.infinity,
                    child: CustomButton(
                      onPressed: () => sendPhoneNumber(context),
                      text: "Get OTP",
                    ),
                  ),
                  const SizedBox(height: 40),
                  const Text(
                    "By signing up, you agree with our Terms\nand Conditions",
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                      color: Colors.grey,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void sendPhoneNumber(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    String phoneNumber = textController.text.trim();
    String fullPhoneNumber =
        "+${selectedCountry.phoneCode}$phoneNumber"; // Create the full phone number with country code
    authProvider.signInWithPhone(context,
        fullPhoneNumber); // Use signInWithPhone to initiate verification
  }
}
