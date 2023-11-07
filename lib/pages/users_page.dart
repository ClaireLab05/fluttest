import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_ui_firestore/firebase_ui_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttest/colors.dart';
import 'package:fluttest/models/user.dart' as my_user;
import 'package:fluttest/pages/list_page.dart';
import 'package:fluttest/pages/messages_page.dart';
import 'package:fluttest/services/conversations_service.dart';
import 'package:fluttest/services/users_service.dart';
import 'package:fluttest/styles.dart';
// ignore: depend_on_referenced_packages

class UsersPage extends ListPage {
  const UsersPage({super.key});

  @override
  Widget getTitle() {
    return const Text(
      "Nouvelle conversation",
      style: appBarTitle,
    );
  }

  
  @override
  Widget getBody() {
    return FirestoreListView<my_user.User>(
      query: UsersServices.getAll().where(
        'email',
        isNotEqualTo: FirebaseAuth.instance.currentUser!.email!,
      ),
      padding: const EdgeInsets.all(8.0),
      errorBuilder: (context, error, stackTrace) {
        debugPrint((error.toString()));
        return Text(error.toString());
      },
      emptyBuilder: (context) {
        return const Text("Aucun autre utilisateur...");
      },
      itemBuilder: (context, snapshot) {
        final user = snapshot.data();
        return Column(
          children: [
            InkWell(
              splashColor: kGrey,
              onTap: () async {
                //Créer une nouvelle conversation avec cet utilisateur
                final conversationId =
                    await ConversationsServices.add(user.email);
                //Récupère la conversation créée
                final conversation =
                    await ConversationsServices.get(conversationId);
                //Affiche la conversation
                if (context.mounted) {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (_) => MessagesPage(
                        conversation: conversation,
                      ),
                    ),
                  );
                }
              },
              child: ListTile(
                leading: const Icon(Icons.person),
                title: Text(user.email),
              ),
            ),
            const Divider(),
          ],
        );
      },
    );
  }
}