import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hotel_paradise/common/theme/theme.dart';
import '../../ui/bottom_navbar/bottom_navbar.dart';
import '../../common/bottom_navitem/bottom_navitem_list.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  int _currentIndex = 3;
  
  // User data (replace with actual data from your backend/storage)
  String userName = "John Doe";
  String userEmail = "john.doe@example.com";
  String userPhone = "+1 234 567 8900";

  void _onNavTap(int index) {
    if (index != _currentIndex) {
      setState(() => _currentIndex = index);
      Get.toNamed(navItems[index].route);
    }
  }

  void _showEditProfileDialog() {
    final nameController = TextEditingController(text: userName);
    final emailController = TextEditingController(text: userEmail);
    final phoneController = TextEditingController(text: userPhone);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppColor.cardBackground,
        title: const Text('Edit Profile', style: TextStyle(color: AppColor.primary, fontWeight: FontWeight.bold)),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                style: const TextStyle(color: AppColor.primary, fontWeight: FontWeight.w600),
                cursorColor: AppColor.primary,
                decoration: InputDecoration(
                  labelText: 'Name',
                  labelStyle: const TextStyle(color: AppColor.textLight),
                  floatingLabelStyle: const TextStyle(color: AppColor.primary, fontWeight: FontWeight.w600),
                  prefixIcon: const Icon(Icons.person, color: AppColor.primary),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: AppColor.primary, width: 2),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  filled: true,
                  fillColor: AppColor.primary.withOpacity(0.05),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: emailController,
                style: const TextStyle(color: AppColor.primary, fontWeight: FontWeight.w600),
                cursorColor: AppColor.primary,
                decoration: InputDecoration(
                  labelText: 'Email',
                  labelStyle: const TextStyle(color: AppColor.textLight),
                  floatingLabelStyle: const TextStyle(color: AppColor.primary, fontWeight: FontWeight.w600),
                  prefixIcon: const Icon(Icons.email, color: AppColor.primary),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: AppColor.primary, width: 2),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  filled: true,
                  fillColor: AppColor.primary.withOpacity(0.05),
                ),
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 16),
              TextField(
                controller: phoneController,
                style: const TextStyle(color: AppColor.primary, fontWeight: FontWeight.w600),
                cursorColor: AppColor.primary,
                decoration: InputDecoration(
                  labelText: 'Phone',
                  labelStyle: const TextStyle(color: AppColor.textLight),
                  floatingLabelStyle: const TextStyle(color: AppColor.primary, fontWeight: FontWeight.w600),
                  prefixIcon: const Icon(Icons.phone, color: AppColor.primary),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: AppColor.primary, width: 2),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  filled: true,
                  fillColor: AppColor.primary.withOpacity(0.05),
                ),
                keyboardType: TextInputType.phone,
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel', style: TextStyle(color: AppColor.textLight)),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                userName = nameController.text;
                userEmail = emailController.text;
                userPhone = phoneController.text;
              });
              Navigator.pop(context);
              Get.snackbar(
                'Success',
                'Profile updated successfully',
                snackPosition: SnackPosition.BOTTOM,
                backgroundColor: AppColor.primary.withOpacity(0.9),
                colorText: Colors.white,
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColor.primary,
              foregroundColor: Colors.white,
            ),
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  void _showDeleteAccountDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Account', style: TextStyle(color: Colors.red)),
        content: const Text(
          'Are you sure you want to delete your account? This action cannot be undone.',
          style: TextStyle(color: AppColor.text),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel', style: TextStyle(color: AppColor.textLight)),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              // Add your delete account logic here
              Get.snackbar(
                'Account Deleted',
                'Your account has been deleted',
                snackPosition: SnackPosition.BOTTOM,
                backgroundColor: Colors.red.withOpacity(0.9),
                colorText: Colors.white,
              );
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: const Text('Delete', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  void _handleLogout() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Logout', style: TextStyle(color: AppColor.primary)),
        content: const Text('Are you sure you want to logout?', 
            style: TextStyle(color: AppColor.text)),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel', style: TextStyle(color: AppColor.textLight)),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              // Add your logout logic here
              Get.snackbar(
                'Logged Out',
                'You have been logged out successfully',
                snackPosition: SnackPosition.BOTTOM,
                backgroundColor: AppColor.primary.withOpacity(0.9),
                colorText: Colors.white,
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColor.primary,
              foregroundColor: Colors.white,
            ),
            child: const Text('Logout'),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileHeader() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColor.primary.withOpacity(0.9),
            AppColor.primary.withOpacity(0.7),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Column(
        children: [
          const SizedBox(height: 40),
          CircleAvatar(
            radius: 50,
            backgroundColor: Colors.white,
            child: Icon(Icons.person, size: 50, color: AppColor.primary),
          ),
          const SizedBox(height: 16),
          Text(
            userName,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            userEmail,
            style: const TextStyle(fontSize: 16, color: Colors.white70),
          ),
          const SizedBox(height: 4),
          Text(
            userPhone,
            style: const TextStyle(fontSize: 14, color: Colors.white70),
          ),
          const SizedBox(height: 20),
          ElevatedButton.icon(
            onPressed: _showEditProfileDialog,
            icon: const Icon(Icons.edit),
            label: const Text('Edit Profile'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: AppColor.primary,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildMenuItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    Color? iconColor,
    bool showDivider = true,
  }) {
    return Column(
      children: [
        ListTile(
          leading: Icon(icon, color: iconColor ?? AppColor.primary),
          title: Text(title, style: const TextStyle(color: AppColor.text)),
          trailing: const Icon(Icons.arrow_forward_ios, size: 16, color: AppColor.textLight),
          onTap: onTap,
        ),
        if (showDivider) Divider(height: 1, color: AppColor.cardBorder),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        setState(() => _currentIndex = 0);
        Get.toNamed(navItems[0].route);
        return false;
      },
      child: Scaffold(
        backgroundColor: AppColor.background,
        body: SingleChildScrollView(
          child: Column(
            children: [
              _buildProfileHeader(),
              const SizedBox(height: 20),
              Container(
                
                decoration: BoxDecoration(
                  color: AppColor.cardBackground,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.shade300,
                      blurRadius: 10,
                      offset: const Offset(0, 2),
                    ),
                  ],
                  border: Border.all(color: AppColor.cardBorder, width: 1),
                ),
                child: Column(
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(16),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'General',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: AppColor.textLight,
                          ),
                        ),
                      ),
                    ),
                    _buildMenuItem(
                      icon: Icons.help_outline,
                      title: 'Help & Support',
                      onTap: () {
                        
                      },
                    ),
                    _buildMenuItem(
                      icon: Icons.language,
                      title: 'Language',
                      onTap: () {
                        
                      },
                    ),
                    _buildMenuItem(
                      icon: Icons.question_answer,
                      title: 'FAQ',
                      onTap: () {
                        
                      },
                    ),
                    _buildMenuItem(
                      icon: Icons.privacy_tip_outlined,
                      title: 'Privacy Policy',
                      onTap: () {
                        
                      },
                    ),
                    _buildMenuItem(
                      icon: Icons.description_outlined,
                      title: 'Terms & Conditions',
                      onTap: () {
                        
                      },
                      showDivider: false,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: AppColor.cardBackground,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.shade300,
                      blurRadius: 10,
                      offset: const Offset(0, 2),
                    ),
                  ],
                  border: Border.all(color: AppColor.cardBorder, width: 1),
                ),
                child: Column(
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(16),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Account',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: AppColor.textLight,
                          ),
                        ),
                      ),
                    ),
                    _buildMenuItem(
                      icon: Icons.logout,
                      title: 'Logout',
                      iconColor: Colors.orange,
                      onTap: _handleLogout,
                    ),
                    _buildMenuItem(
                      icon: Icons.delete_forever,
                      title: 'Delete Account',
                      iconColor: Colors.red,
                      onTap: _showDeleteAccountDialog,
                      showDivider: false,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 40),
              Text(
                'Version 1.0.0',
                style: TextStyle(color: AppColor.textLight.withOpacity(0.7), fontSize: 12),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
        bottomNavigationBar: BottomNavbar(
          currentIndex: _currentIndex,
          onTap: _onNavTap,
          items: navItems,
        ),
      ),
    );
  }
}