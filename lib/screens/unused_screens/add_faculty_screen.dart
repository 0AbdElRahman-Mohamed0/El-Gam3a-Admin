import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elgam3a_admin/models/hall_model.dart';
import 'package:elgam3a_admin/utilities/loading.dart';
import 'package:elgam3a_admin/widgets/text_data_field.dart';
import 'package:flutter/material.dart';

class AddFacultyScreen extends StatefulWidget {
  @override
  _AddFacultyScreenState createState() => _AddFacultyScreenState();
}

class _AddFacultyScreenState extends State<AddFacultyScreen> {
  String _name;
  List<HallModel> _halls = [];
  int _id;
  int _capacity;

  _addFaculty() async {
    LoadingScreen.show(context);
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    final DocumentReference data =
        await firestore.collection('faculties_data').add({
      'id': '',
      'name': _name,
      'halls': _halls.map((hall) => hall.toMap()).toList(),
    });

    await firestore
        .collection('faculties_data')
        .doc(data.id)
        .update({'id': data.id});
    Navigator.pop(context);
    _halls = [];
    setState(() {});
  }

  _addHall() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          'Add hall',
          style: Theme.of(context).textTheme.headline6,
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            TextFormField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Hall id',
                hintText: 'Enter hall id',
              ),
              onChanged: (id) {
                _id = num.parse(id);
              },
            ),
            TextFormField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Hall capacity',
                hintText: 'Enter hall capacity',
              ),
              onChanged: (capacity) {
                _capacity = num.parse(capacity);
                setState(() {});
              },
            ),
            RaisedButton(
              onPressed: () {
                _halls.add(HallModel(id: _id, capacity: _capacity));
                setState(() {});
                Navigator.pop(context);
              },
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4.0),
              ),
              color: Theme.of(context).buttonColor,
              textColor: Colors.white,
              child: Text('Add'),
            ),
            SizedBox(height: 8.0),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            TextFormField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'name',
                hintText: 'Enter name',
              ),
              onChanged: (name) {
                _name = name;
                setState(() {});
              },
            ),
            SizedBox(
              height: 10,
            ),
            ..._halls
                .map(
                  (e) => Column(
                    children: [
                      Text('Hall ${e.id}'),
                      SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                )
                .toList(),
            RaisedButton(
              onPressed: _addHall,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4.0),
              ),
              color: Theme.of(context).buttonColor,
              textColor: Colors.white,
              child: Text('Add hall'),
            ),
            SizedBox(
              height: 10,
            ),
            RaisedButton(
              onPressed: _addFaculty,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4.0),
              ),
              color: Theme.of(context).buttonColor,
              textColor: Colors.white,
              child: Text('Add faculty'),
            ),
          ],
        ),
      ),
    );
  }
}
