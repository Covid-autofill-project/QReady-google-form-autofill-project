import 'package:flutter/material.dart';
import 'saveJson.dart';

class ScreenInput extends StatelessWidget {
  final TextEditingController nameController = new TextEditingController();
  final TextEditingController phoneController = new TextEditingController();
  final TextEditingController emailController = new TextEditingController();
  final TextEditingController idController = new TextEditingController();
  final content = new ContentStorage();

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
            title: new Text("Second Page"), backgroundColor: Colors.deepOrange),
        body: new Container(
            child: Center(
                child: Column(children: <Widget>[
          Expanded(
              child: TextField(
                  decoration: InputDecoration(
                    labelText: 'Name',
                    hintText: '本名',
                  ),
                  controller: nameController)),
          Expanded(
              child: TextField(
                  decoration: InputDecoration(
                    labelText: 'Phone',
                    hintText: '電話號碼',
                  ),
                  controller: phoneController)),
          Expanded(
              child: TextField(
                  decoration: InputDecoration(
                    labelText: 'Email',
                    hintText: '電子郵件',
                  ),
                  controller: emailController)),
          Expanded(
              child: TextField(
                  decoration: InputDecoration(
                    labelText: 'ID Number',
                    hintText: '身分證字號',
                  ),
                  controller: idController)),
          TextButton(
            child: Text('存入Json File'),
            onPressed: btnEvent,
          ),
          TextButton(
            child: Text('印出儲存內容'),
            onPressed: btnEvent2,
          )
        ]))));
  }

  void btnEvent() {
    Content info = new Content(nameController.text, phoneController.text,
        emailController.text, idController.text); // new storage object

    content.writeContent(info); // Write FIle
  }

  void btnEvent2() async {
    final info = await content.readContent(); // Read File
    print(info.name);
    print(info.phone);
    print(info.email);
    print(info.id);
  }
}
