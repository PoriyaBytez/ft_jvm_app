import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';

class MediaListScreen extends StatefulWidget {
  @override
  _MediaListScreenState createState() => _MediaListScreenState();
}

class _MediaListScreenState extends State<MediaListScreen> {
  List<File> mediaFiles = [];

  Future<void> _pickImageOrVideo() async {
    final pickedFile =
    await ImagePicker().pickVideo(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        mediaFiles.add(File(pickedFile.path));
      });
    }
  }

  void _removeMedia(int index) {
    setState(() {
      mediaFiles.removeAt(index);
    });
  }

  Widget _buildMediaItem(BuildContext context, int index) {
    final mediaFile = mediaFiles[index];
    final isImage = mediaFile.path.endsWith('.jpg') ||
        mediaFile.path.endsWith('.jpeg') ||
        mediaFile.path.endsWith('.png');
    return ListTile(
      leading: VideoPlayer(_createVideoPlayerController(mediaFile)),
      title: Text(mediaFile.path.split('/').last),
      trailing: IconButton(
        icon: Icon(Icons.delete),
        onPressed: () => _removeMedia(index),
      ),
    );
  }

  VideoPlayerController _createVideoPlayerController(File file) {
    return VideoPlayerController.file(file)..initialize();
  }

  @override
  void dispose() {
    mediaFiles.forEach((file) => file.delete());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Media List Demo')),
      body: ListView.builder(
        itemCount: mediaFiles.length,
        itemBuilder: _buildMediaItem,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _pickImageOrVideo,
        tooltip: 'Pick Image or Video',
        child: Icon(Icons.add),
      ),
    );
  }
}



