import 'dart:collection';
import 'package:http/http.dart' as http;

void request() async {
  var local_file = HashMap();
  local_file['一起進場人數'] = 9;
  local_file['姓名'] = 'test';
  // This example uses the Google Books API to search for books about http.
  // https://developers.google.com/books/docs/overview
  var list = "https://docs.google.com/forms/d/e/1FAIpQLScw30Eq9oRONqVv_tLolp0BubC8LfIMllCgffOoLbD7MJpuBg/viewform";
  var url = Uri.parse(list);
  // Await the http get response, then decode the json-formatted response.
  var response = await http.get(url);
  var data = response.body;
  var index = data.indexOf('data-params');

  var hash = HashMap();
  while(index != -1){
    print("Input:");
    data = data.substring((index + 11));
    var keyword;
    var entry = data;
    for(int i = 0; i < 3; ++i){
      var start = entry.indexOf('[');
      entry = entry.substring((start+1));
      if(i==0){
        entry = entry.substring(entry.indexOf(';')+1);
        keyword = entry.substring(0, entry.indexOf('&'));
        print(keyword);
      }
    }
    var end = entry.indexOf(',');
    entry = entry.substring(0, end);
    print(entry);
    hash[keyword] = entry;
    index = data.indexOf('data-params');
  }
  var final_url = list+"?";
  hash.forEach((key, value) {
    final_url += "entry.${value}=${local_file[key]}&";
  });
  print(final_url);
  
}
