import 'package:flutter/material.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io'; // For File handling
import 'package:video_player/video_player.dart';

class DropImagePage extends StatefulWidget {
  const DropImagePage({super.key});

  
  @override
  State<DropImagePage> createState() => _DropImagePageState();
}

class _DropImagePageState extends State<DropImagePage> {
  int _currentIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text("Drop an Image"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Main Container Section
            Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black),
                borderRadius: BorderRadius.circular(16.0),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'How you can\nEarn reward for\nRecycling',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'With you we will help ecology',
                    style: TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      side: const BorderSide(color: Colors.black),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    onPressed: () {
                      // Add functionality here for My Waste Pickup
                    },
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'My Waste pick up',
                          style: TextStyle(color: Colors.black),
                        ),
                        Icon(Icons.recycling, color: Colors.black),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            // More Services Section
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'More services',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    // Add functionality for "see more"
                  },
                  child: const Text(
                    'see more',
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            // Services Icons Row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ServiceIcon(
                  icon: Icons.local_shipping,
                  label: 'Pick waste',
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const UploadWastePage()),
                    );
                  },
                ),
                ServiceIcon(
                  icon: Icons.attach_money,
                  label: 'Get money',
                  onPressed: () {
                    // Add functionality for "Get money"
                  },
                ),
                ServiceIcon(
                  icon: Icons.recycling,
                  label: 'Recycling',
                  onPressed: () {
                    // Add functionality for "Recycling"
                  },
                ),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        selectedItemColor: Colors.deepPurple,
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.explore),
            label: 'Explore',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bookmark),
            label: 'Saved',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}

// Custom Widget for Service Icons
class ServiceIcon extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onPressed;

  const ServiceIcon({
    required this.icon,
    required this.label,
    required this.onPressed,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Column(
        children: [
          CircleAvatar(
            radius: 30,
            backgroundColor: Colors.black,
            child: Icon(
              icon,
              color: Colors.white,
              size: 24,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: const TextStyle(fontSize: 14),
          ),
        ],
      ),
    );
  }
}

// Upload Waste Page
class UploadWastePage extends StatefulWidget {
  const UploadWastePage({super.key});

  @override
  State<UploadWastePage> createState() => _UploadWastePageState();
}

class _UploadWastePageState extends State<UploadWastePage> {
  File? _selectedFile; // Holds the selected file (image or video)
  bool _isVideo = false;
  VideoPlayerController? _videoController;
  final ImagePicker _picker = ImagePicker(); // ImagePicker instance

  Future<void> _pickMedia(ImageSource source, bool isVideo) async {
    final XFile? pickedFile = await (isVideo
        ? _picker.pickVideo(source: source)
        : _picker.pickImage(source: source));

    if (pickedFile != null) {
      setState(() {
        _selectedFile = File(pickedFile.path);
        _isVideo = isVideo;
        if (_isVideo) {
          _videoController?.dispose();
          _videoController = VideoPlayerController.file(_selectedFile!)
            ..initialize().then((_) {
              setState(() {});
              _videoController!.play();
            });
        }
      });
    }
  }

  void _showMediaPickerOptions() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Wrap(
          children: [
            ListTile(
              leading: const Icon(Icons.photo_library),
              title: const Text('Choose Image from Gallery'),
              onTap: () {
                Navigator.pop(context);
                _pickMedia(ImageSource.gallery, false);
              },
            ),
            ListTile(
              leading: const Icon(Icons.camera_alt),
              title: const Text('Capture Image'),
              onTap: () {
                Navigator.pop(context);
                _pickMedia(ImageSource.camera, false);
              },
            ),
            ListTile(
              leading: const Icon(Icons.video_library),
              title: const Text('Choose Video from Gallery'),
              onTap: () {
                Navigator.pop(context);
                _pickMedia(ImageSource.gallery, true);
              },
            ),
            ListTile(
              leading: const Icon(Icons.videocam),
              title: const Text('Capture Video'),
              onTap: () {
                Navigator.pop(context);
                _pickMedia(ImageSource.camera, true);
              },
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    _videoController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          'Upload Waste',
          style: TextStyle(color: Colors.black),
        ),
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            GestureDetector(
              onTap: _showMediaPickerOptions,
              child: DottedBorder(
                color: Colors.grey,
                strokeWidth: 1,
                dashPattern: const [6, 3],
                borderType: BorderType.RRect,
                radius: const Radius.circular(8.0),
                child: Container(
                  height: 200, // Fixed height for the dotted border
                  width: double.infinity,
                  alignment: Alignment.center, // Ensures content is centered
                  child: _selectedFile == null
                      ? const Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.cloud_upload,
                                  size: 40, color: Colors.grey),
                              SizedBox(height: 8),
                              Text('Click to upload a picture or video'),
                            ],
                          ),
                        )
                      : _isVideo
                          ? _videoController != null &&
                                  _videoController!.value.isInitialized
                              ? ClipRRect(
                                  borderRadius: BorderRadius.circular(8.0),
                                  child: FittedBox(
                                    fit: BoxFit
                                        .contain, // Ensures the video scales within bounds
                                    child: SizedBox(
                                      width: _videoController!.value.size.width,
                                      height:
                                          _videoController!.value.size.height,
                                      child: VideoPlayer(_videoController!),
                                    ),
                                  ),
                                )
                              : const Center(
                                  child: CircularProgressIndicator(),
                                )
                          : ClipRRect(
                              borderRadius: BorderRadius.circular(8.0),
                              child: FittedBox(
                                fit: BoxFit
                                    .contain, // Ensures the image fits within bounds
                                child: Image.file(
                                  _selectedFile!,
                                ),
                              ),
                            ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            const TextField(
              decoration: InputDecoration(
                labelText: 'Enter your location...',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            const TextField(
              decoration: InputDecoration(
                labelText: 'Type of e-waste (metal or plastic)',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            const TextField(
              decoration: InputDecoration(
                labelText: 'Quantity',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                // Add functionality for sending the data
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(
                    vertical: 12.0, horizontal: 32.0),
              ),
              child: const Text('Send'),
            ),
          ],
        ),
      ),
    );
  }
}
