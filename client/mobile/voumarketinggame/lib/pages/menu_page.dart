import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:voumarketinggame/pages/inventory_screen.dart';
import 'package:voumarketinggame/pages/profile_user_page.dart';
import 'package:voumarketinggame/pages/welcome_page.dart';
import 'package:voumarketinggame/providers/auth_provider.dart';
import 'package:voumarketinggame/providers/bottom_navigation_provider.dart';
import 'package:voumarketinggame/providers/user_provider.dart';
import 'package:voumarketinggame/widgets/item_menu_widget.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({super.key});

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {

  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      setState(() {
        _isLoading = true;
      });
      await _fetchUserInfo();
      setState(() {
        _isLoading = false;
      });
    });
  }


  Future<void> _fetchUserInfo() async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    userProvider.fetchUserProfile(context);
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    final authProvider = Provider.of<AuthProvider>(context);
    final user = userProvider.user;

    if (_isLoading) {
      return const Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    if (userProvider.errorMessage != null) {
      return Scaffold(
        backgroundColor: Colors.yellow.shade200,
        body: Center(
          child: Text(
            userProvider.errorMessage!,
            style: const TextStyle(color: Colors.red, fontSize: 16),
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: Column(
        children: [
          Consumer<UserProvider>(
            builder: (context, userProvider, child) {

              if (userProvider.isLoading) {
                return Container(
                  color: Colors.yellow.shade200,
                  padding: const EdgeInsets.all(16),
                  child: const Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              }

              if (userProvider.errorMessage != null) {
                return Container(
                  color: Colors.yellow.shade200,
                  padding: const EdgeInsets.all(16),
                  child: Center(
                    child: Text(
                      userProvider.errorMessage!,
                      style: const TextStyle(color: Colors.red),
                    ),
                  ),
                );
              }

              return Container(
                color: Colors.yellow.shade200,
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    CircleAvatar(
                    radius: 30,
                    backgroundImage: user?.avatarUrl != null && user!.avatarUrl.isNotEmpty
                        ? NetworkImage(user.avatarUrl)
                        : const AssetImage('assets/images/logo.png') as ImageProvider,
                    onBackgroundImageError: (_, __) {
                      print('Failed to load image from URL.');
                    },
                  ),


                    const SizedBox(width: 16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          user?.name ?? 'Loading...',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 4),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: Colors.green,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            user?.phoneNumber ?? 'Loading...',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(12),
                bottomRight: Radius.circular(12),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.3),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              const UserProfileScreen(), // Tab trang cá nhân
                        ),
                      );
                    },
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(CupertinoIcons.qrcode, color: Colors.pink),
                        SizedBox(width: 8),
                        Text(
                          'Trang cá nhân',
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  height: 30,
                  width: 1,
                  color: Colors.grey.shade400,
                ),
                const Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.card_giftcard, color: Colors.orange),
                      SizedBox(width: 8),
                      Text(
                        'Giới thiệu App',
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Expanded(
                    child: ListView(
                      children: [
                        MenuItem(
                          icon: CupertinoIcons.gift,
                          title: 'Kho đồ',
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => InventoryPage()),
                            );
                          },
                        ),
                        const MenuItem(
                          icon: CupertinoIcons.question_circle,
                          title: 'Trung tâm trợ giúp',
                          isNew: true,
                        ),
                        const MenuItem(
                          icon: CupertinoIcons.gear_big,
                          title: 'Quản lý tài khoản',
                        ),
                        const MenuItem(
                          icon: CupertinoIcons.exclamationmark_circle,
                          title: 'Thông tin chung',
                        ),
                        const MenuItem(
                          icon: CupertinoIcons.globe,
                          title: 'Ngôn ngữ',
                        ),
                      ],
                    ),
                  ),
                  const Divider(),
                  Row(
                    children: [
                      Expanded(
                        child: TextButton(
                          onPressed: () async {
                            await authProvider.logout();
                            Provider.of<BottomNavigationProvider>(context, listen: false).updateIndex(0);
                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(builder: (context) => WelcomeScreen()),
                              (route) => false,
                            );
                          },


                          style: TextButton.styleFrom(
                            backgroundColor: Colors.red[100],
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 8),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: const Text(
                            'Đăng xuất',
                            style: TextStyle(color: Colors.black, fontSize: 16),
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 10),
                        height: 30,
                        width: 1,
                        color: Colors.grey.shade400,
                      ),
                      Expanded(
                        child: TextButton(
                          onPressed: () {
                            SystemNavigator.pop(); 
                          },
                          style: TextButton.styleFrom(
                            backgroundColor: Colors.blue[100],
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 8),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: const Text(
                            'Thoát',
                            style: TextStyle(color: Colors.black, fontSize: 16),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 50),
        ],
      ),
    );
  }
}

