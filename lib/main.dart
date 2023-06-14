import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PT. Sarana Pactindo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromARGB(255, 27, 167, 217)),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _recipientController = TextEditingController();
  final TextEditingController _subjectController = TextEditingController();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _jobTitleController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();

  void _sendEmail() async {
    final String recipient = _recipientController.text;
    final String subject = _subjectController.text;
    final String body = '''Nama: ${_nameController.text}
Job Title: ${_jobTitleController.text}
Alamat: ${_addressController.text}''';

    final Email emailMessage = Email(
      recipients: [recipient],
      subject: subject,
      body: body,
    );

    String platformResponse;

    try {
      await FlutterEmailSender.send(emailMessage);
      platformResponse = 'Email terkirim';
    } catch (error) {
      platformResponse = error.toString();
    }

    Future.delayed(Duration.zero, () {
      _showDialog(platformResponse);
    });
  }

  void _showDialog(String platformResponse) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Status Pengiriman Email'),
          content: Text(platformResponse),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Form Kirim Email',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: const Color(0xFF1BA7D9),
      ),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(16.0),
          child: ListView(
            children: [
              Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(height: 5.0),
                    TextFormField(
                      controller: _recipientController,
                      decoration: const InputDecoration(
                        labelText: 'Penerima Email',
                        labelStyle: TextStyle(
                          color: Colors.black,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0xFF1BA7D9)),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0xFF1BA7D9)),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Color.fromARGB(255, 255, 0, 0)),
                        ),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Harap masukkan alamat email penerima.';
                        }
                        if (!value.contains('@')) {
                          return 'Alamat email tidak valid.';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16.0),
                    TextFormField(
                      controller: _subjectController,
                      decoration: const InputDecoration(
                        labelText: 'Subjek Email',
                        labelStyle: TextStyle(
                          color: Colors.black,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0xFF1BA7D9)),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0xFF1BA7D9)),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Color.fromARGB(255, 255, 0, 0)),
                        ),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Harap masukkan subjek email.';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 30.0),
                    const Text(
                      'Body Email',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0,
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    TextFormField(
                      controller: _nameController,
                      decoration: const InputDecoration(
                        labelText: 'Nama',
                        labelStyle: TextStyle(
                          color: Colors.black,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0xFF1BA7D9)),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0xFF1BA7D9)),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Color.fromARGB(255, 255, 0, 0)),
                        ),
                        hintText: 'Masukkan Nama',
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Harap masukkan nama.';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16.0),
                    TextFormField(
                      controller: _jobTitleController,
                      decoration: const InputDecoration(
                        labelText: 'Job Title',
                        labelStyle: TextStyle(
                          color: Colors.black,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0xFF1BA7D9)),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0xFF1BA7D9)),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Color.fromARGB(255, 255, 0, 0)),
                        ),
                        hintText: 'Masukkan Job Title',
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Harap masukkan job title.';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16.0),
                    TextFormField(
                      controller: _addressController,
                      decoration: const InputDecoration(
                        labelText: 'Alamat',
                        labelStyle: TextStyle(
                          color: Colors.black,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0xFF1BA7D9)),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0xFF1BA7D9)),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Color.fromARGB(255, 255, 0, 0)),
                        ),
                        hintText: 'Masukkan Alamat',
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Harap masukkan alamat.';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20.0),
                    ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            _sendEmail();
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: const Color(0xFF1BA7D9),
                        ),
                        child: const Text(
                          'Kirim Email',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        )),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
