import 'package:flutter/material.dart';
import 'dart:io';
import '../models/incidence.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:flutter_sound/public/flutter_sound_player.dart';

class IncidenceDetail extends StatefulWidget {
  final Incidence incidence;
  const IncidenceDetail({super.key, required this.incidence});

  @override
  _IncidenceDetailState createState() => _IncidenceDetailState();
}

class _IncidenceDetailState extends State<IncidenceDetail> {
  FlutterSoundPlayer? _player;

  @override
  void initState() {
    super.initState();
    _player = FlutterSoundPlayer();
    _player!.openAudioSession();
  }

  @override
  void dispose() {
    _player!.closeAudioSession();
    _player = null;
    super.dispose();
  }

  void _startPlayer() async {
    if (_player!.isStopped) {
      await _player!.startPlayer(
        fromURI: widget.incidence.audioPath,
        codec: Codec.mp3, // Puedes cambiar el codec si es necesario
      );
    } else {
      await _player!.stopPlayer();
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.incidence.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Fecha: ${widget.incidence.date}'),
            const SizedBox(height: 8.0),
            Text('Descripción: ${widget.incidence.description}'),
            const SizedBox(height: 8.0),
            widget.incidence.photoPath.isNotEmpty
                ? Image.file(File(widget.incidence.photoPath))
                : const SizedBox(),
            const SizedBox(height: 8.0),
            widget.incidence.audioPath.isNotEmpty
                ? ElevatedButton(
              onPressed: _startPlayer,
              child: Text(_player!.isStopped ? 'Reproducir Audio' : 'Detener Audio'),
            )
                : const SizedBox(),
          ],
        ),
      ),
    );
  }
}