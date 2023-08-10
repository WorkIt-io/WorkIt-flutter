

import 'package:flutter/material.dart';

import '../constant/firebase_instance.dart';

class DrawerHomePage extends StatelessWidget {
  const DrawerHomePage({
    super.key,    
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Drawer(
      child: Column(
        children: [
          DrawerHeader(
            child: Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                gradient: LinearGradient(colors: [
                  Colors.orangeAccent.shade400,
                  Colors.orangeAccent.shade100
                ], begin: Alignment.topLeft, end: Alignment.bottomLeft),
              ),
              child: ListTile(
                title: Text(
                  'WorkIt',
                  style: theme.textTheme.headlineLarge,
                ),
                subtitle: Text(
                  'Start Today',
                  style: theme.textTheme.headlineSmall,
                ),
                trailing: const Icon(
                  Icons.sports_basketball,
                  size: 60,
                  color: Colors.deepOrange,
                ),
              ),
            ),
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: ListTile(
              title: Text(
                firebaseInstance.currentUser!.email!,
                style: theme.textTheme.labelLarge!.copyWith(fontSize: 20),
              ),
              trailing: IconButton(
                onPressed: () async => await firebaseInstance.signOut(),
                icon: const Icon(Icons.logout),
              ),
            ),
          )
        ],
      ),
    );
  }
}
