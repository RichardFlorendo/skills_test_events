import 'dart:convert';

import 'package:skills_test_events/event.dart';
import 'package:flutter/material.dart';
import 'package:skills_test_events/function.dart';

TextEditingController nameController = TextEditingController();
TextEditingController detailsController = TextEditingController();
List<Event> event = List.empty(growable: true);
String url = 'http://127.0.0.1:8080/api';

var data;
var counter = 0;
var edit = 0;

int selectedIndex = -1;

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Events List'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            const SizedBox(height: 10),
            //event.isEmpty ?
                 ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => CreateEvent()),
                    );
                    },
                    child: const Text('Create Event')),
                //: 
                Expanded(
                    child: ListView.builder(
                      itemCount: event.length,
                      itemBuilder: (context, index) => getRow(0),
                    ),
                  )
          ],
        ),
      ),
    );
  }

  Widget getRow(int index) {
    String ename = "Event Name";
    String edetails = "Event Details";

    

    setState(() {
      data = jsonDecode(fetchdata(url));
      edetails = data['details'];
      ename = data['name'];
    });

    return Card(
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor:
              index % 2 == 0 ? Colors.deepPurpleAccent : Colors.purple,
          foregroundColor: Colors.white,
          child: Text(
            ename, //
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              ename, //
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(edetails), //
          ],
        ),
        trailing: SizedBox(
          width: 70,
          child: Row(
            children: [
              InkWell(
                  onTap: () {
                    //
                    setState(() {
                      edit = 1;
                      selectedIndex = index;
                      //data = jsonDecode(postdata(url, selectedIndex, nameController.text, detailsController.text));
                    });
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => CreateEvent()),
                    );
                    //
                  },
                  child: const Icon(Icons.edit)),
              InkWell(
                  onTap: (() {
                    //
                    setState(() {
                      event.removeAt(index);
                    });
                    //
                  }),
                  child: const Icon(Icons.delete)),
            ],
          ),
        ),
      ),
    );
  }
}

class CreateEvent extends StatelessWidget {
 CreateEvent({super.key});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Event'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            const SizedBox(height: 10), //
            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                  hintText: 'Event Name',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ))),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: detailsController,
              decoration: const InputDecoration(
                  hintText: 'Event Description',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ))),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                edit == 0 
                ? ElevatedButton(
                    onPressed: () {
                      //
                      String name = nameController.text.trim();
                      String details = detailsController.text.trim();
                      int id = counter += 1;

                      if (name.isNotEmpty && details.isNotEmpty) {
                        event.add(Event(id: id, name: name, details: details));
                        //data = jsonDecode(postdata(url, id, nameController.text, detailsController.text));
                        
                        Navigator.pop(context);
                      }
                      //
                    },
                    child: const Text('Create'))
                  : ElevatedButton(
                    onPressed: () {
                      //
                      String name = nameController.text.trim();
                      String details = detailsController.text.trim();

                      if (name.isNotEmpty && details.isNotEmpty) {
                        event.add(Event(id: selectedIndex, name: name, details: details));
                        //data = jsonDecode(postdata(url, selectedIndex, nameController.text, detailsController.text));

                        Navigator.pop(context);
                      }
                      //
                    },
                    child: const Text('Save Changes'))
              ],
            )
          ]
        )
      )
    );
  }
}