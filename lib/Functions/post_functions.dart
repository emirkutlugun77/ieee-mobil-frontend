import 'package:http/http.dart' as http;

const baseUri = 'https://ancient-falls-28306.herokuapp.com/';

Future getAllPosts() async {
  var response = await http.get(Uri.parse(baseUri + 'v1/post/'));
  print(response.body);
}
