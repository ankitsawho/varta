import 'package:basics/features/contacts/controller/contacts_controller.dart';
import 'package:basics/features/contacts/repository/contact_repository.dart';
import 'package:basics/screens/loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_contacts/contact.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ContactScreen extends ConsumerWidget {
  static const String routeName = "/contacts-screen";
  const ContactScreen({Key? key}) : super(key: key);

  void selectContact(WidgetRef ref, Contact selectedContact, BuildContext context){
    ref.read(selectContactControllerProvider).selectContact(selectedContact, context);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: const Text("Select Contact"),),
      body: ref.watch(getContactProvider).when(
          data: (contactList) => ListView.builder(itemBuilder: (context, index){
            final contact = contactList[index];
            return InkWell(
              onTap: () => selectContact(ref, contact, context),
              child: Padding(
                padding: const EdgeInsets.only(bottom: 10.0),
                child: contact.phones.isNotEmpty ? ListTile(
                  leading: contact.photo==null ? CircleAvatar(radius: 24, child: Icon(Icons.person_2_outlined),):CircleAvatar(backgroundImage: MemoryImage(contact.photo!), radius: 24,),
                  title: Text(contact.displayName, style: TextStyle(fontWeight: FontWeight.bold),),
                  subtitle: Text(contact.phones[0].number),
                ): null,
              ),
            );
          }, itemCount: contactList.length,),
          error: (err, trace) => Scaffold(body: Center(child: Text(err.toString()),),),
          loading: () => const Loader()),
    );
  }
}
