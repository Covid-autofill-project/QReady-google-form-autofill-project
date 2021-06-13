import 'package:flutter/material.dart';
import 'saveJson.dart';
import '../util/const.dart';

class ScreenInput extends StatefulWidget {
  final PageController pc;
  const ScreenInput({Key? key, required this.pc }): super(key:key);

  @override
  _ScreenInput createState() => _ScreenInput();
}

class _ScreenInput extends State<ScreenInput> {
  final TextEditingController nameController  = new TextEditingController();
  final TextEditingController phoneController = new TextEditingController();
  final TextEditingController emailController = new TextEditingController();
  final TextEditingController idController    = new TextEditingController();
  final content = new ContentStorage();
  var info = new Content("姓名", "電話", "電子郵件", "身分證字號");
  
  // @override
  // void didUpdateWidget(ScreenInput old) {
  //   super.didUpdateWidget(old);
  //   // print(this.info);
  // }
  @override
  void initState() {
    super.initState();
    content.readContent().then((val) => setState(() {
          this.info = val;
    }));
  }

  @override
  Widget build(BuildContext context) {
    var info = this.info;
    // move the readContent to init state to avoid re-opening (and re-reading) the localstorage. improve performance.
    
    return new Scaffold(
        backgroundColor: Constants.ratingBG,
        resizeToAvoidBottomInset: false,
        body: new Container(
            padding: const EdgeInsets.fromLTRB(50.0, 70, 50.0, 150),
            child: CustomScrollView(
              slivers: [
                SliverFillRemaining(
                // hasScrollBody: false,
                hasScrollBody: true,
                child: Column(children: <Widget>[
                  Expanded(
                    child: 
                      Text("個人資料", style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700, fontSize: 30))
                  ),
                  Expanded(
                      child: TextField(
                          decoration: InputDecoration(
                            border: new OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: const BorderRadius.all(
                              const Radius.circular(30.0),
                              ),
                            ),
                            filled: true,
                            fillColor: Color(0xFF8C9EFF).withOpacity(0.8),
                            labelText: info.name,
                            hintText: '姓名',
                            labelStyle: TextStyle(fontSize: 20.0, color: Colors.black),
                            hintStyle: TextStyle(fontSize: 20.0, color: Colors.black)
                          ),
                          controller: nameController)),
                  Expanded(
                      child: TextField(
                          decoration: InputDecoration(
                            border: new OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: const BorderRadius.all(
                              const Radius.circular(30.0),
                              ),
                            ),
                            filled: true,
                            fillColor: Color(0xFF8C9EFF).withOpacity(0.8),
                            labelText: info.phone,
                            hintText: '電話號碼',
                            labelStyle: TextStyle(fontSize: 20.0, color: Colors.black),
                            hintStyle: TextStyle(fontSize: 20.0, color: Colors.black)
                          ),
                          controller: phoneController)),
                  Expanded(
                      child: TextField(
                          decoration: InputDecoration(
                            border: new OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: const BorderRadius.all(
                              const Radius.circular(30.0),
                              ),
                            ),
                            filled: true,
                            fillColor: Color(0xFF8C9EFF).withOpacity(0.8),
                            labelText: info.email,
                            hintText: '電子郵件',
                            labelStyle: TextStyle(fontSize: 20.0, color: Colors.black),
                            hintStyle: TextStyle(fontSize: 20.0, color: Colors.black)
                          ),
                          controller: emailController)),
                  Expanded(
                      child: TextField(
                          decoration: InputDecoration(
                            border: new OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: const BorderRadius.all(
                              const Radius.circular(30.0),
                              ),
                            ),
                            filled: true,
                            fillColor: Color(0xFF8C9EFF).withOpacity(0.8),
                            labelText: info.id,
                            labelStyle: TextStyle(fontSize: 20.0, color: Colors.black),
                            hintText: "身分證字號",
                            hintStyle: TextStyle(fontSize: 20.0, color: Colors.black)
                          ),

                          controller: idController)),
                  ElevatedButton(
                    child: Text('確認'), 
                    style: ElevatedButton.styleFrom(
                      primary: Constants.darkAccent,
                      padding: EdgeInsets.symmetric(horizontal: 80, vertical: 10),
                      shape: (
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        )
                      ),
                      textStyle: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold)),
                    onPressed: btnEvent,
                  ),
                  // ElevatedButton(
                  //   child: Text('印出儲存內容'),
                  //   onPressed: btnEventJSONoutput,
                  // )
                ]
              )
            )
            ]
          )
        )
    );
  }

  void btnEvent() async{
    final infoOld = await content.readContent(); // Read File
    var nameText = infoOld.name;
    var phoneText = infoOld.phone;
    var emailText = infoOld.email;
    var idText = infoOld.id;

    if(nameController.text =="") nameText = infoOld.name;
    else nameText = nameController.text;
    if(phoneController.text =="") phoneText = infoOld.phone;
    else phoneText = phoneController.text;
    if(emailController.text =="") emailText = infoOld.email;
    else emailText = emailController.text;
    if(idController.text =="") idText = infoOld.id;
    else idText = idController.text;

    Content info = new Content(nameText, phoneText,
        emailText, idText); // new storage object

    content.writeContent(info); // Write FIle
    print("saved");
    widget.pc.animateToPage(0, duration: Duration(microseconds: 500), curve: Curves.easeOut); // go back to home page
    // animation is nor working QQ
  }

  void btnEventJSONoutput() async {
    final info = await content.readContent(); // Read File
    print("name: ${info.name}");
    print("phone: ${info.phone}");
    print("email: ${info.email}");
    print("id: ${info.id}");
  }
}
