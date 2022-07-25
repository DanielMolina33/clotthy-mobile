// Packages
import 'package:http/http.dart' as http;
import 'dart:io';

class Api {
	static const String baseUrl = 'https://api.clotthy.com/api';

	static Future<http.Response> httpGet(String path, token) async {
		final url = baseUrl + path;
		try {
			return http.get(Uri.parse(url),
		    	headers: <String, String> {
					'Content-Type': 'application/x-www-form-urlencoded charset=UTF-8',
					'Authorization': 'Bearer ' + token,
				},
			);
		} catch(e){
			throw('Error en el GET');
		}
	}

	static Future<http.Response> httpPost(String path, data) async {
		final url = baseUrl + path;
		try {
			return http.post(Uri.parse(url),
				headers: <String, String> {
					'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8'
				},
				body: data
			);
		} catch(e){
			throw('Error en el POST');
		}
	}
  
	static Future<http.Response> httpMultipart(String path, data, image, token) async {
		final url = baseUrl + path;

		try {
      final req = http.MultipartRequest('POST', Uri.parse(url));
      final file = await http.MultipartFile.fromPath("image", image);

      req.headers.addAll({
        'Content-Type': 'multipart/form-data',
        'Authorization': 'Bearer ' + token,
      });

      req.fields.addAll(data);
      req.files.add(file);
      final streamedResponse = await req.send();
      final res = await http.Response.fromStream(streamedResponse);

      return res;

		} catch(e){
			throw('Error en el MULTIPART POST');
		}
	}

	static Future<http.Response> httpPutMultipart(String path, data, image, token) async {
		final url = baseUrl + path;
    // dynamic file = "";

		try {
      final req = http.MultipartRequest('POST', Uri.parse(url));
      if(image != ""){
        final file = await http.MultipartFile.fromPath("image", image);
        req.files.add(file);
      }

      req.headers.addAll({
        'Content-Type': 'multipart/form-data',
        'Authorization': 'Bearer ' + token,
      });

      req.fields.addAll(data);
      final streamedResponse = await req.send();
      final res = await http.Response.fromStream(streamedResponse);

      return res;

		} catch(e){
      print(e);
			throw('Error en el MULTIPART PUT');
		}
	}
}