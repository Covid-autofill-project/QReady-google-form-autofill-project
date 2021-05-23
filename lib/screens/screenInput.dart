import 'package:flutter/material.dart';
import 'saveJson.dart';

class ScreenInput extends StatefulWidget {
  @override
  _ScreenInput createState() => _ScreenInput();
}

class _ScreenInput extends State<ScreenInput> {
  final TextEditingController nameController = new TextEditingController();
  final TextEditingController phoneController = new TextEditingController();
  final TextEditingController emailController = new TextEditingController();
  final TextEditingController idController = new TextEditingController();
  final content = new ContentStorage();
  var info = new Content("姓名", "電話", "電子郵件", "身分證字號");
  
  @override
  void didUpdateWidget(ScreenInput old) {
    super.didUpdateWidget(old);
    // print(this.info);
  }

  @override
  Widget build(BuildContext context) {
    var info = this.info;
    content.readContent().then((val) => setState(() {
          info = val;
    }));
    return new Scaffold(
        appBar: new AppBar(
            title: new Text("個人資料", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w300)), backgroundColor: Colors.indigo),
        body: new Container(
            padding: const EdgeInsets.fromLTRB(50.0, 20, 50.0, 0),
            child: Center(
                child: Column(children: <Widget>[
                  Expanded(
                      child: TextField(
                          decoration: InputDecoration(
                            labelText: info.name,
                            hintText: '姓名',
                          ),
                          controller: nameController)),
                  Expanded(
                      child: TextField(
                          decoration: InputDecoration(
                            labelText: info.phone,
                            hintText: '電話號碼',
                          ),
                          controller: phoneController)),
                  Expanded(
                      child: TextField(
                          decoration: InputDecoration(
                            labelText: info.email,
                            hintText: '電子郵件',
                          ),
                          controller: emailController)),
                  Expanded(
                      child: TextField(
                          decoration: InputDecoration(
                            labelText: info.id,
                            hintText: '身分證字號',
                          ),
                          controller: idController)),
                  TextButton(
                    child: Text('確認'),
                    onPressed: btnEvent,
                  ),
                  TextButton(
                    child: Text('印出儲存內容'),
                    onPressed: btnEvent_JSON_output,
                  )
                ]
              )
            )
        )
    );
  }

  void btnEvent() {
    Content info = new Content(nameController.text, phoneController.text,
        emailController.text, idController.text); // new storage object

    content.writeContent(info); // Write FIle
  }

  void btnEvent_JSON_output() async {
    final info = await content.readContent(); // Read File
    print(info.name);
    print(info.phone);
    print(info.email);
    print(info.id);
  }
}
