import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ImagesListScreen extends StatefulWidget {
  const ImagesListScreen({super.key});
  @override
  _ImagesListScreenState createState() => _ImagesListScreenState();
}

class _ImagesListScreenState extends State<ImagesListScreen> {
  final SupabaseClient _supabaseClient = Supabase.instance.client;
  List<String> _imageUrls = [];
  List<String> _imageNames = [];

  @override
  void initState() {
    super.initState();
    _loadImages();
  }

  Future<void> _loadImages() async {
    try {
      final files = await _supabaseClient.storage.from('images').list();
      final List<String> urls = files
          .map((file) =>
              _supabaseClient.storage.from('images').getPublicUrl(file.name))
          .toList();
      final List<String> names = files.map((file) => file.name).toList();
      setState(() {
        _imageUrls = urls;
        _imageNames = names;
      });
    } catch (e) {
      // Handle error
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error loading images: ${e.toString()}')),
      );
    }
  }

  Future<void> _deleteImage(int index) async {
    try {
      await _supabaseClient.storage.from('images').remove([_imageNames[index]]);
      setState(() {
        _imageUrls.removeAt(index);
        _imageNames.removeAt(index);
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Image deleted successfully')),
      );
    } catch (e) {
      // Handle error
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error deleting image: ${e.toString()}')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Images List'),
      ),
      body: _imageUrls.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: _imageUrls.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Image.network(_imageUrls[index]),
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(child: Text(_imageUrls[index])),
                            IconButton(
                              icon: const Icon(Icons.delete),
                              onPressed: () => _deleteImage(index),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
    );
  }
}
