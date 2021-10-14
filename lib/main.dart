import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'models/restaurant.model.dart';
import 'models/user.model.dart';

void main() {
  runApp(ProviderScope(
      child: MyApp()
  ));
}

final myProvider = StateProvider<int>((ref) {
  return 10;
});

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: Home(),
    );
  }
}

class Home extends ConsumerWidget {
  final jsonData = '{ "name": "Pizza da Mario", "cuisine": "Italian", "yearOpened": 1967,'
      '"reviews": [{"score": 33.0, "review": "terrible"}, {"score": 45, "review": "reasonable"}],'
      '"staff": [{"name": "Dave", "phoneNumber": "555-555"}, {"name": "Jim", "phoneNumber": "222-2222"}],'
      '"menuItems": [{"title": "Baked Spuds", "description": "Freaking awesome!!!", "price": 2.24}, {"title": "Vegan Pie", "description": "Freaking delicious!!!", "price": 5.55}]'
      '}';
  final jsonDataNoName = '{"cuisine": "Italian" }';
  final jsonArrayData = '[{ "name": "Pizza da Mario", "cuisine": "Italian" }, { "name": "El Rancho", "cuisine": "Mexican" }]';

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final users = watch(userProvider);
    final parsedJson = jsonDecode(jsonData);
    final res = Restaurant.fromJson(parsedJson);
    print('Menu items: ${res.menuItems}');
    // print('Name: ${res.name}');
    // print('Cuisine: ${res.cuisine}');
    // print('Year Opened: ${res.yearOpened}');
    // print('Has indoor seating?: ${res.hasIndoorSeating}');
    // print('Reviews: ${res.reviews}');
    // print('Staff: ${res.staff}');
    // print('${parsedJson.runtimeType} : $parsedJson');
    return Material(
      color: Colors.blueGrey.shade200,
      child: users.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text(err.toString())),
        data: (data) {
          return ListView.builder(
            itemCount: data.length,
            itemBuilder: (_, index) {
              return Card(
                elevation: 3,
                child: ListTile(
                  title: Text('${data[index].id}: ${data[index].name}'),
                  leading: const Icon(Icons.person_outline, color: Colors.blue,),
                ),
              );
            },
          );
        },
      ),
    );
  }
}