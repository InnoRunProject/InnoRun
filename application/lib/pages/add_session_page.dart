import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:innorun/data/provider.dart';

class AddSessionPage extends StatefulWidget {
  const AddSessionPage({super.key});

  @override
  State<AddSessionPage> createState() => AddSessionPageState();
}

class AddSessionPageState extends State<AddSessionPage> {
  final nameController = TextEditingController();
  final timeController = TextEditingController();
  final placeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Title'),
      ),
      body: Center(
        child: Form(
          child: Column(
            children: <Widget> [
              const Text('InnoRun'),
              const Text('Add points'),
              const SizedBox(height: 20.0,),
              TextField(
                controller: nameController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Name of creator',
                ),
              ),
              const SizedBox(height: 20.0,),
              TextField(
                controller: timeController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Time',
                ),
              ),
              const SizedBox(height: 20.0,),
              TextField(
                controller: placeController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Place...',
                ),
              ),
              const SizedBox(height: 50.0,),
              ElevatedButton(
                onPressed: () {
                  String name = nameController.text;
                  String time = timeController.text;
                  String place = placeController.text;
                  Provider.of<CreatedSessions>(context, listen: false).addSession(name, time, place);
                  Navigator.pop(context);
                },
                child: const Text('Create')
              ),
            ],
          )
        ),
      ),
    );
  }
}