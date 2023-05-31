import 'package:basics/features/contacts/repository/contact_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_contacts/contact.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final getContactProvider = FutureProvider((ref){
  final contactRepository = ref.watch(contactsRepositoryProvider);
  return contactRepository.getContacts();
});

final selectContactControllerProvider = Provider((ref){
  final contactRepository = ref.watch(contactsRepositoryProvider);
  return SelectContactController(ref: ref, contactRepository: contactRepository);
});

class SelectContactController{
 final ProviderRef ref;
 final ContactRepository contactRepository;
 
 SelectContactController({
   required this.ref,
   required this.contactRepository
});

 void selectContact(Contact selectedContact, BuildContext context) {
   contactRepository.contactHasVarta(selectedContact, context);
 }
}
