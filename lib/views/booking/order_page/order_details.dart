import 'package:csc_picker/csc_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_woocommerce/utils/core/constants.dart';
import 'dart:developer';

import 'package:flutter_woocommerce/views/booking/order_page/widgets/order_appbar.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({super.key});

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  final _formKey = GlobalKey<FormState>();
  String countryValue = "";
  String stateValue = "";
  String cityValue = "";
  String address = "";
  String name = '';
  String email = '';
  String phone = '';
  String textAddress = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: OrderAppbar(title: 'Order Details'),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              const Text('Enter your Shipment Details'),
              kHeight,
              Container(
                width: MediaQuery.sizeOf(context).width,
                child: Padding(
                  padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                  child: Container(
                    height: 50,
                    decoration: BoxDecoration(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10)),
                        border:
                            Border.all(color: Colors.grey.shade300, width: 1)),
                    child: TextFormField(
                      onChanged: (value) {
                        name = value;
                      },
                      decoration: InputDecoration(
                        labelText: "Name",
                        fillColor: Colors.white,
                        border: const OutlineInputBorder(
                            borderSide: BorderSide(width: 0),
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.grey
                                  .shade300), // Change the border color when enabled
                          borderRadius: const BorderRadius.all(
                            Radius.circular(10),
                          ),
                        ),
                      ),
                      keyboardType: TextInputType.name,
                      style: subFontStyle,
                    ),
                  ),
                ),
              ),
              kHeight,
              Container(
                width: MediaQuery.sizeOf(context).width,
                child: Padding(
                  padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                  child: Container(
                    height: 55,
                    decoration: BoxDecoration(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10)),
                        border:
                            Border.all(color: Colors.grey.shade300, width: 1)),
                    child: TextFormField(
                      decoration: InputDecoration(
                        labelText: "Enter Email",
                        fillColor: Colors.white,
                        border: const OutlineInputBorder(
                          borderSide: BorderSide(),
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.grey
                                  .shade300), // Change the border color when enabled
                          borderRadius: const BorderRadius.all(
                            Radius.circular(10),
                          ),
                        ),
                      ),
                      keyboardType: TextInputType.emailAddress,
                      style: subFontStyle,
                    ),
                  ),
                ),
              ),
              kHeight,
              Container(
                width: MediaQuery.of(context).size.width,
                child: Padding(
                  padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                  child: Container(
                    height: 55,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                      border: Border.all(color: Colors.grey.shade300, width: 1),
                    ),
                    child: TextFormField(
                      decoration: InputDecoration(
                        labelText: "Phone No",
                        fillColor: Colors.white,
                        focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors
                                  .blue), // Change the border color when focused
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.grey
                                  .shade300), // Change the border color when enabled
                          borderRadius: const BorderRadius.all(
                            Radius.circular(10),
                          ),
                        ),
                      ),
                      keyboardType: TextInputType.phone,
                      style: subFontStyle,
                    ),
                  ),
                ),
              ),
              kHeight,
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                height: 100,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CSCPicker(
                      showStates: true,
                      showCities: true,
                      flagState: CountryFlag.DISABLE,
                      dropdownDecoration: BoxDecoration(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10)),
                          color: Colors.white,
                          border: Border.all(
                              color: Colors.grey.shade300, width: 1)),
                      disabledDropdownDecoration: BoxDecoration(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10)),
                          color: Colors.grey.shade300,
                          border: Border.all(
                              color: Colors.grey.shade300, width: 1)),
                      countrySearchPlaceholder: "Country",
                      stateSearchPlaceholder: "State",
                      citySearchPlaceholder: "City",
                      countryDropdownLabel: "Country",
                      stateDropdownLabel: "State",
                      cityDropdownLabel: "City",
                      countryFilter: const [
                        CscCountry.India,
                        CscCountry.United_States,
                        CscCountry.Canada,
                      ],
                      selectedItemStyle: const TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                      ),
                      dropdownHeadingStyle: const TextStyle(
                          color: Colors.black,
                          fontSize: 17,
                          fontWeight: FontWeight.bold),
                      dropdownItemStyle: const TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                      ),
                      dropdownDialogRadius: 10.0,
                      searchBarRadius: 10.0,
                      onCountryChanged: (value) {
                        setState(() {
                          countryValue = value;
                        });
                      },
                      onStateChanged: (value) {
                        setState(() {
                          stateValue = value.toString();
                        });
                      },
                      onCityChanged: (value) {
                        setState(() {
                          cityValue = value.toString();
                        });
                      },
                    ),
                  ],
                ),
              ),
              kHeight,
              Container(
                width: MediaQuery.of(context).size.width,
                child: Padding(
                  padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                  child: Container(
                    // height: 55,
                    child: TextFormField(
                      minLines: 1,
                      maxLines: 10,
                      decoration: InputDecoration(
                        labelText: "Address",
                        fillColor: Colors.white,
                        focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors
                                  .blue), // Change the border color when focused
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.grey
                                  .shade300), // Change the border color when enabled
                          borderRadius: const BorderRadius.all(
                            Radius.circular(10),
                          ),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 20, horizontal: 12),
                      ),
                      keyboardType: TextInputType.streetAddress,
                      style: subFontStyle,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Processing Data')),
                      );
                    }
                    setState(() {
                      address = "$cityValue, $stateValue, $countryValue";
                    });
                    log(address);
                  },
                  child: const Text('Submit'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
