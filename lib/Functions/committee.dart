import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:my_app/UI/models/commitee.dart';

const baseUri = 'https://ancient-falls-28306.herokuapp.com/';

Future getAllCommittees(List<Commitee> committees) async {
  var response = await http.get(Uri.parse(baseUri + 'v1/committees/'));
  var decodedData = jsonDecode(response.body);

  decodedData['committees']
      .forEach((x) => committees.add(Commitee.fromJson(x)));
  print('working');
  return committees;
}
