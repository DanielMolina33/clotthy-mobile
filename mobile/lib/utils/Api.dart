// Packages
import 'package:http/http.dart' as http;

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
}