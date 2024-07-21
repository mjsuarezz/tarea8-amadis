import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:path_provider/path_provider.dart';
import '../models/incidence.dart';
import 'package:provider/provider.dart';
import '../providers/incidence_provider.dart';

class IncidenceForm extends StatefulWidget {
  const IncidenceForm({super.key});

  @override
  _IncidenceFormState createState() => _IncidenceFormState();
}

class _IncidenceFormState extends State<IncidenceForm> {
  final _formKey = GlobalKey<FormState>();
  late String _title;
  late String _description;
  File? _photo;
  String? _audioPath;
  FlutterSoundRecorder? _audioRecorder;

  @override
  void initState() {
    super.initState();
    _audioRecorder = FlutterSoundRecorder();
    _initializeRecorder();
  }

  Future<void> _initializeRecorder() async {
    await _audioRecorder!.openAudioSession();
    if (await Permission.microphone.request().isGranted) {
      print("Microphone permission granted");
    } else {
      print("Microphone permission denied");
    }
  }

  @override
  void dispose() {
    _audioRecorder!.closeAudioSession();
    _audioRecorder = null;
    super.dispose();
  }

  Future<void> _startRecording() async {
    final directory = await getApplicationDocumentsDirectory();
    _audioPath = '${directory.path}/audio_${DateTime.now().millisecondsSinceEpoch}.aac';
    await _audioRecorder!.startRecorder(
      toFile: _audioPath,
      codec: Codec.aacADTS,
    );
    setState(() {});
  }

  Future<void> _stopRecording() async {
    await _audioRecorder!.stopRecorder();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nueva Incidencia'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: const InputDecoration(labelText: 'Título'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese un título';
                  }
                  return null;
                },
                onSaved: (value) {
                  _title = value!;
                },
                style: const TextStyle(color: Colors.white),
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Descripción'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese una descripción';
                  }
                  return null;
                },
                onSaved: (value) {
                  _description = value!;
                },
                style: const TextStyle(color: Colors.white),
              ),
              ElevatedButton(
                onPressed: () async {
                  final picker = ImagePicker();
                  final pickedFile = await picker.pickImage(source: ImageSource.camera);
                  if (pickedFile != null) {
                    setState(() {
                      _photo = File(pickedFile.path);
                    });
                  }
                },
                child: const Text('Tomar Foto'),
              ),
              ElevatedButton(
                onPressed: _audioRecorder!.isRecording ? _stopRecording : _startRecording,
                child: Text(_audioRecorder!.isRecording ? 'Detener Grabación' : 'Grabar Audio'),
              ),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    final newIncidence = Incidence()
                      ..title = _title
                      ..date = DateTime.now()
                      ..description = _description
                      ..photoPath = _photo?.path ?? ''
                      ..audioPath = _audioPath ?? '';
                    Provider.of<IncidenceProvider>(context, listen: false).addIncidence(newIncidence);
                    Navigator.pop(context);
                  }
                },
                child: const Text('Guardar Incidencia'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}