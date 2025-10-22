import 'package:flutter/material.dart';
import 'package:sqflite_screen/db_helper.dart';
import 'package:sqflite_screen/screen.dart';

class AddData extends StatefulWidget {
  const AddData({super.key});

  @override
  State<AddData> createState() => _AddDataState();
}

class _AddDataState extends State<AddData> {
  List<Map<String, dynamic>> _userData = [];

  Future<void> fetchData() async {
    final userData = await DBHelper.viewData();
    setState(() {
      _userData = userData;
    });
  }

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  void showEditDialog(Map<String, dynamic> data) {
    TextEditingController name = TextEditingController(text: data["name"]);
    TextEditingController contact = TextEditingController(
      text: data["contact"],
    );
    TextEditingController description = TextEditingController(
      text: data["description"],
    );

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("EditData"),
        content: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                controller: name,
                decoration: InputDecoration(labelText: "name",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              TextField(
                controller: contact,
                decoration: InputDecoration(labelText: "contact",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),SizedBox(height: 10,),
              TextField(
                controller: description,
                decoration: InputDecoration(labelText: "description",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(onPressed: () {
            Navigator.pop(context);
          }, child: Text("Cancel",style: TextStyle(color: Colors.black),)),
          TextButton(onPressed: () async{
            await DBHelper.editData(data["id"],name.text.trim(), contact.text.trim(),description.text.trim());
            fetchData();
            Navigator.pop(context);
          }, child:Text("Save",style: TextStyle(color: Colors.greenAccent),))
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white,
        backgroundColor: Colors.blue,
        title: Text("Sqlite CRUD", style: TextStyle(color: Colors.white)),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Screen()),
          );
        },
        child: Icon(Icons.add),
      ),
      body: ListView.builder(
        itemCount: _userData.length,
        itemBuilder: (context, index) {
          final data = _userData[index];
          return Card(
            child: ListTile(
              leading: CircleAvatar(radius: 30, child: Icon(Icons.person)),
              title: Text("Name:-${data['name']}"),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Contact:-${data['contact']}"),
                  Text("Description:-${data['description']}"),
                ],
              ),
              contentPadding: EdgeInsets.symmetric(horizontal: 10),
              trailing: SizedBox(
                width: 96,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      onPressed: () async {
                        await DBHelper.deleteData(data['id']);
                        fetchData();
                      },
                      icon: Icon(Icons.delete, color: Colors.red),
                    ),
                    IconButton(
                      onPressed: () {
                        showEditDialog(data);
                      },
                      icon: Icon(Icons.edit, color: Colors.blue),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
