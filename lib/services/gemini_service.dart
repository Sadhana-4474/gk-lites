import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class GeminiService {
  // Change this to true if billing is enabled later
  static const bool useRealAPI = false;

  static Future<String> generateMCQs(String notes) async {
    if (useRealAPI) {
      return _generateFromGemini(notes);
    } else {
      return _generateMockMCQs(notes);
    }
  }

  // Mock data
  static Future<String> _generateMockMCQs(String notes) async {
    await Future.delayed(const Duration(seconds: 1));

    return '''
1. Where is the Taj Mahal located?
A) Delhi
B) Agra
C) Jaipur
D) Mumbai

Answer: B

2. Who built the Taj Mahal?
A) Akbar
B) Jahangir
C) Shah Jahan
D) Aurangzeb

Answer: C

3. The Taj Mahal is situated on the bank of which river?
A) Yamuna
B) Ganga
C) Godavari
D) Krishna

Answer: A

4. The Taj Mahal was built in memory of whom?
A) Mumtaz Mahal
B) Noor Jahan
C) Jodha Bai
D) Razia Sultana

Answer: A

5. The Taj Mahal is located in which Indian state?
A) Rajasthan
B) Madhya Pradesh
C) Uttar Pradesh
D) Bihar

Answer: C
''';
  }

  // Real gemini App
  static Future<String> _generateFromGemini(String notes) async {
    final apiKey = dotenv.env['GEMINI_API_KEY'];

    if (apiKey == null || apiKey.isEmpty) {
      throw Exception("API key missing");
    }

    final url = Uri.parse(
      'https://generativelanguage.googleapis.com/v1/models/gemini-1.0-pro:generateContent?key=$apiKey',
    );

    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        "contents": [
          {
            "parts": [
              {
                "text":
                "Generate 5 multiple choice questions with options from the following text:\n$notes"
              }
            ]
          }
        ]
      }),
    );

    if (response.statusCode != 200) {
      throw Exception("API Error: ${response.body}");
    }

    final data = jsonDecode(response.body);
    return data['candidates'][0]['content']['parts'][0]['text'];
  }
}
