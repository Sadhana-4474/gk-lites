import 'package:flutter/material.dart';
import '../services/gemini_service.dart';
import '../models/mcq_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _controller = TextEditingController();
  bool isLoading = false;
  String result = '';
  String error = '';

  void generate() async {
    if (_controller.text.trim().isEmpty) {
      setState(() => error = "Please enter notes");
      return;
    }

    setState(() {
      isLoading = true;
      error = '';
      result = '';
    });

    try {
      result = await GeminiService.generateMCQs(_controller.text);
    } catch (e) {
      error = e.toString();
    }


    setState(() => isLoading = false);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("GK Lite"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              maxLines: 5,
              decoration: const InputDecoration(
                hintText: "Paste your notes here",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: isLoading ? null : generate,
              child: isLoading
                  ? const CircularProgressIndicator()
                  : const Text("Generate MCQs"),
            ),
            if (error.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Text(
                  error,
                  style: const TextStyle(color: Colors.red),
                ),
              ),
            const SizedBox(height: 10),
            Expanded(
              child: SingleChildScrollView(
                child: Text(
                  result,
                  style: const TextStyle(fontSize: 16),
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }
}
