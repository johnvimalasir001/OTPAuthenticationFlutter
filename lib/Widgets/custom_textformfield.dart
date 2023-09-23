import 'package:flutter/material.dart';
import 'package:country_picker/country_picker.dart';

class CustomTextFormField extends StatefulWidget {
  final void Function(String) onPhoneNumberChanged;

  const CustomTextFormField({
    super.key,
    required this.onPhoneNumberChanged,
  });

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
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
  void initState() {
    super.initState();

    textController.addListener(() {
      widget.onPhoneNumberChanged(
          textController.text); // Notify parent of changes
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
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
                      setState(
                        () {
                          selectedCountry = value;
                        },
                      );
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
    );
  }
}
