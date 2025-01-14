import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:voumarketinggame/providers/user_provider.dart';
import 'package:voumarketinggame/widgets/item_infor_widget.dart';

class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen({super.key});

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  final ImagePicker _picker = ImagePicker();
  String? _selectedImagePath;
  final Map<String, TextEditingController> _controllers = {};

  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await _fetchUserInfo(); 
      setState(() {}); 
    });
  }

  Future<void> _fetchUserInfo() async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    await userProvider.fetchUserProfile(context);

    final user = userProvider.user;
    if (user != null) {

      setState(() {
        _controllers['name'] = TextEditingController(text: user.name);
        _controllers['email'] = TextEditingController(text: user.email);
        _controllers['phoneNumber'] = TextEditingController(text: user.phoneNumber);
        _controllers['birthday'] = TextEditingController(text: user.birthday);
        _controllers['gender'] = TextEditingController(text: user.gender);
        _isLoading = false; 
      });
    }
  }

  Future<String?> _uploadAvatarToServer(String imagePath) async {
  try {

    final fileName = imagePath.split('/').last;
    final fileBytes = await File(imagePath).readAsBytes();
    final uri = Uri.parse(
        "https://hcmus-vou.s3.ap-southeast-1.amazonaws.com/players/avatars/$fileName");

    final response = await http.put(
      uri,
      headers: {
        "Content-Type": "image/png", 
        "Content-Disposition": "inline; filename=\"$fileName\"",
      },
      body: fileBytes, 
    );

    if (response.statusCode == 200) {
      return uri.toString();
    } else {
      return null;
    }
  } catch (e) {
    print("Error uploading image: $e");
    return null;
  }
}

  Future<void> _pickImage() async {
  try {
    final XFile? pickedFile =
        await _picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      print('Selected image path: ${pickedFile.path}');
      print('File size: ${await File(pickedFile.path).length()} bytes');
      setState(() {
        _selectedImagePath = pickedFile.path;
      });
    }
  } catch (e) {
    print("Error picking image: $e");
  }
}


  Future<void> _updateUserNow() async {
  final userProvider = Provider.of<UserProvider>(context, listen: false);
  String avatarUrl = userProvider.user?.avatarUrl ?? '';
  setState(() {
    _isLoading = true;
  });

  try {
    if (_selectedImagePath != null) {
      final uploadedUrl = await _uploadAvatarToServer(_selectedImagePath!);
      if (uploadedUrl != null) {
        avatarUrl = uploadedUrl; 
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Failed to upload avatar")),
        );
        setState(() {
          _isLoading = false;
        });
        return;
      }
    }

    final updatedInfo = {
      "name": _controllers['name']?.text ?? '',
      "email": _controllers['email']?.text ?? '',
      "phoneNumber": _controllers['phoneNumber']?.text ?? '',
      "birthday": _controllers['birthday']?.text ?? '',
      "gender": _controllers['gender']?.text ?? '',
      "avatarUrl": avatarUrl,
    };

    // Gọi API update thông tin user
    final success = await userProvider.updateUser(
      userInfo: updatedInfo,
      context: context,
    );

    if (success) {
      await _fetchUserInfo();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("User information updated successfully!")),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(userProvider.errorMessage ?? "Update failed")),
      );
    }
  } catch (e) {
    print("Error during update: $e");
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("An error occurred during update")),
    );
  } finally {

    setState(() {
      _isLoading = false;
    });
  }
}

  Future<void> _editBirthday() async {
    final selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (selectedDate != null) {
      _controllers['birthday']?.text = selectedDate.toIso8601String().split('T').first;
    }
  }

  Future<void> _editGender() async {
    final genders = ['Male', 'Female', 'Other'];
    final selectedGender = await showModalBottomSheet<String>(
      context: context,
      builder: (BuildContext context) {
        return ListView(
          children: genders
              .map(
                (gender) => ListTile(
                  title: Text(gender),
                  onTap: () => Navigator.pop(context, gender),
                ),
              )
              .toList(),
        );
      },
    );

    if (selectedGender != null) {
      _controllers['gender']?.text = selectedGender;
    }
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    final user = userProvider.user;
    
    if (_isLoading) {
    return const Scaffold(
      body: Center(child: CircularProgressIndicator()),
    );
  }
    if (user == null) {
      return const Scaffold(
        body: Center(child: Text("No user data available")),
      );
    }

    return Scaffold(
    appBar: AppBar(
      title: const Text(
        'Trang cá nhân',
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      centerTitle: true,
      backgroundColor: Colors.pinkAccent,
      elevation: 0,
      leading: IconButton(
        icon: const Icon(CupertinoIcons.back),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
    ),
    body: SingleChildScrollView(
    padding: const EdgeInsets.all(16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Avatar Section
        Stack(
          alignment: Alignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.pinkAccent, width: 3),
              ),
              child: CircleAvatar(
                radius: 60,
                backgroundImage: _selectedImagePath != null
                    ? FileImage(File(_selectedImagePath!))
                    : (user.avatarUrl.isNotEmpty
                        ? NetworkImage(user.avatarUrl)
                        : const AssetImage('assets/images/logo.png')) as ImageProvider,
                onBackgroundImageError: (_, __) {
                  print('Failed to load image from URL.');
                },
              ),
            ),
            Positioned(
              bottom: 0,
              right: 0,
              child: CircleAvatar(
                radius: 18,
                backgroundColor: Colors.white,
                child: IconButton(
                  onPressed: _pickImage,
                  icon: const Icon(
                    CupertinoIcons.pencil,
                    size: 18,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),

        // Personal Information Section
        Container(
          padding: const EdgeInsets.all(13),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(13),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.7),
                blurRadius: 20,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            children: [
              FieldContainer(
                icon: CupertinoIcons.person_crop_rectangle,
                label: "Name",
                controller: _controllers['name']!,
              ),
              FieldContainer(
                icon: CupertinoIcons.mail,
                label: "E-mail",
                controller: _controllers['email']!,
              ),
              FieldContainer(
                icon: CupertinoIcons.phone_arrow_down_left,
                label: "Phone Number",
                controller: _controllers['phoneNumber']!,
              ),
              FieldContainer(
                icon: CupertinoIcons.calendar_today,
                label: "Birthday",
                controller: _controllers['birthday']!,
                onEdit: _editBirthday,
              ),
              FieldContainer(
                icon: CupertinoIcons.hurricane ,
                label: "Gender",
                controller: _controllers['gender']!,
                onEdit: _editGender,
              ),
            ],
          ),
        ),
        const SizedBox(height: 15),

        // Update Button
        ElevatedButton(
          onPressed: _updateUserNow,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.pinkAccent,
            padding: const EdgeInsets.symmetric(horizontal: 45, vertical: 10),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: const Text(
            "Update",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    ),
  ),
  );
}

}
