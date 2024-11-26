import 'package:contacts/data_class_contact.dart';
import 'package:contacts/widget/contact_card.dart';
import 'package:contacts/widget/custom_text_form_field.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = '/';

  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Contact> contactsList = [Contact(), Contact(), Contact()];

  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  int counter = 0;
  final  key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          title: const Text(
            'Contacts Card',
            style: TextStyle(
                color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
        ),
        body: Form(
          key: key,
          autovalidateMode: AutovalidateMode.always,
          child: ListView(
            children: [
              CustomTextFormField(
                validator: (p0) {
                  if (p0 == null) {
                    return 'Envaild Name';
                  } else if (p0.trim().length < 5) {
                    return 'Needs to be more than 5 letters';
                  } else if (!p0.contains('r')) {
                    return 'must contains a  r';
                  }
                  return null;
                },
                controller: nameController,
                hintText: 'Enter your Name ',
                suffixIcon: const Icon(
                  Icons.edit,
                  color: Colors.blue,
                ),
              ),
              CustomTextFormField(
                validator: (p0) {
                  if (p0 == null || p0.trim().length < 11) {
                    return 'Envaild Phone number';
                  }
                  return null;
                },
                controller: phoneController,
                hintText: 'Enter your Phone number ',
                suffixIcon: const Icon(
                  Icons.call,
                  color: Colors.blue,
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          bool validator = key.currentState!.validate();
                          if (validator) {
                            if (counter < 3 &&
                                contactsList[counter].visibility == false) {
                              contactsList[counter] = Contact(
                                  visibility: true,
                                  name: nameController.text,
                                  phone: phoneController.text);
                              counter++;
                              setState(() {});
                              nameController.clear();
                              phoneController.clear();
                            } else if (contactsList[counter].visibility ==
                                true) {
                              counter++;
                            }
                          }
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue),
                        child: const Text(
                          'Add',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w400,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                    // const SizedBox(
                    //   width: 10,
                    // ),
                  ],
                ),
              ),
              ContactCard(contact: contactsList[0], onDelete: delete, index: 0),
              ContactCard(contact: contactsList[1], onDelete: delete, index: 1),
              ContactCard(
                contact: contactsList[2],
                onDelete: delete,
                index: 2,
              ),
            ],
          ),
        ),
      ),
    );
  }

  delete(int index) {
    contactsList[index] = Contact();
    counter = index;
    setState(() {});
  }
}
