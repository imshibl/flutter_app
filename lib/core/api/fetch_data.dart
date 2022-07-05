import 'package:http/http.dart' as http;

class FetchData {
  final client = http.Client();

  final String _access_token =
      "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjYyMGNkYjE5ZjAwNjkwZTMxOTcxYTZhNCIsImlhdCI6MTY1NzAwMjQxOCwiZXhwIjoxNjU5NTk0NDE4fQ.cMsfWbIs5plUxeLumZN2dspK12DVfW1br6KaLHHoamE";

  Future getCategories() async {
    final Uri uri = Uri.parse("http://139.59.71.156:8000/user/get_categories");

    final http.Response response = await client.post(uri, headers: {
      'accept': 'application/json',
      'Content-Type': 'application/json',
      'Authorization': _access_token
    });

    return response;
  }

  Future getSubCategories() async {
    final Uri uri =
        Uri.parse("http://139.59.71.156:8000/user/get_subcategories");

    final http.Response response = await client.post(uri, headers: {
      'accept': 'application/json',
      'Content-Type': 'application/json',
      'Authorization': _access_token
    });

    return response;
  }
}
