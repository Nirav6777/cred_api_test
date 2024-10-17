import 'package:http/http.dart' as http;
import 'package:http_certificate_pinning/http_certificate_pinning.dart';

class HttpHelper {
  final String baseUrl;
  final String apiKey;
  final List<String> allowedSHA1Certificates;

  HttpHelper(this.baseUrl, this.apiKey, this.allowedSHA1Certificates);

  Future<http.Response> _performRequest(
      String method, String endpoint, {Map<String, dynamic>? body}) async {
    final url = Uri.parse('$baseUrl$endpoint');

    // Perform certificate pinning
    final secure = await HttpCertificatePinning.check(
      serverURL: url.toString(),
      sha: SHA.SHA256,
      allowedSHAFingerprints: allowedSHA1Certificates,
      timeout: 5,
    );

    if (!secure.contains("CONNECTION_SECURE")) {
      throw Exception("Certificate pinning failed");
    }

    // Create common headers
    final headers = {
      'Authorization': 'Bearer $apiKey',
      'Content-Type': 'application/json',
    };

    // Perform the HTTP request based on the method
    switch (method) {
      case 'GET':
        return await http.get(url, headers: headers);
      case 'POST':
        return await http.post(url, headers: headers, body: body);
      case 'DELETE':
        return await http.delete(url, headers: headers);
      default:
        throw Exception("Invalid HTTP method");
    }
  }

  Future<http.Response> get(String endpoint) async {
    return await _performRequest('GET', endpoint);
  }

  Future<http.Response> post(String endpoint, Map<String, dynamic> body) async {
    return await _performRequest('POST', endpoint, body: body);
  }

  Future<http.Response> delete(String endpoint) async {
    return await _performRequest('DELETE', endpoint);
  }
}
