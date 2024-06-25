import 'package:flutter/material.dart';
class RegisterDetails extends StatefulWidget {
  const RegisterDetails({super.key});

  @override
  State<RegisterDetails> createState() => _RegisterDetailsState();
}

class _RegisterDetailsState extends State<RegisterDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("View Students"),
        backgroundColor: Colors.teal,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("Name:",style: TextStyle(fontSize: 23),),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("Department:",style: TextStyle(fontSize: 23),),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("Semester:",style: TextStyle(fontSize: 23),),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("Time:",style: TextStyle(fontSize: 23),),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("Venue:",style: TextStyle(fontSize: 23),),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Text("Contact Number:",style: TextStyle(fontSize: 23),),
                  SizedBox(width: 50,),

                ],
              ),
            ),

          ],
        ),
      ),
    );
  }
}
