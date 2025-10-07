import 'package:flutter/material.dart';

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({super.key});

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  bool _isDarkMode = false;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      elevation: 0,
      child: Container(
        // Add a blue border to the right side
        decoration: const BoxDecoration(
          color: Colors.white,
          border: Border(right: BorderSide(color: Colors.blueAccent, width: 1)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header section of the drawer
            Padding(
              padding: const EdgeInsets.only(
                top: 60.0,
                left: 20.0,
                right: 20.0,
                bottom: 20.0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Top icon
                  const Icon(
                    Icons.bar_chart_rounded,
                    size: 30,
                    color: Colors.black54,
                  ),
                  const SizedBox(height: 30),
                  // User profile section
                  _buildProfileSection(),
                ],
              ),
            ),

            // Divider
            const Divider(color: Colors.black12, height: 1),
            const SizedBox(height: 10),

            // Menu items section
            _buildMenuItem(
              icon: Icons.wb_sunny_outlined,
              title: 'Dark Mode',
              trailing: Switch(
                value: _isDarkMode,
                onChanged: (value) {
                  setState(() {
                    _isDarkMode = value;
                  });
                },
                activeColor: Colors.blueAccent,
              ),
            ),
            _buildMenuItem(
              icon: Icons.info_outline,
              title: 'Account Information',
              onTap: () {},
            ),
            _buildMenuItem(
              icon: Icons.lock_outline,
              title: 'Password',
              onTap: () {},
            ),
            _buildMenuItem(
              icon: Icons.shopping_bag_outlined,
              title: 'Order',
              onTap: () {},
            ),
            _buildMenuItem(
              icon: Icons.credit_card,
              title: 'My Cards',
              onTap: () {},
            ),
            _buildMenuItem(
              icon: Icons.favorite_border,
              title: 'Wishlist',
              onTap: () {},
            ),
            _buildMenuItem(
              icon: Icons.settings_outlined,
              title: 'Settings',
              onTap: () {},
            ),

            // Spacer to push the logout button to the bottom
            const Spacer(),

            // Logout button
            _buildMenuItem(
              icon: Icons.logout,
              title: 'Logout',
              isLogout: true, // Custom flag to apply red color
              onTap: () {},
            ),

            // Bottom padding
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  // Helper widget for the user profile section
  Widget _buildProfileSection() {
    return Row(
      children: [
        const CircleAvatar(
          radius: 30,
          backgroundImage: NetworkImage(
            'https://i.pravatar.cc/150',
          ), // Placeholder image
        ),
        const SizedBox(width: 15),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Mrh Raju',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              const SizedBox(height: 4),
              Row(
                children: const [
                  Text(
                    'Verified Profile',
                    style: TextStyle(color: Colors.grey, fontSize: 14),
                  ),
                  SizedBox(width: 5),
                  Icon(Icons.check_circle, color: Colors.green, size: 16),
                ],
              ),
            ],
          ),
        ),
        // "3 Orders" badge
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(20),
          ),
          child: const Text(
            '3 Orders',
            style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
          ),
        ),
      ],
    );
  }

  // Helper widget to create each menu item, reducing code duplication
  Widget _buildMenuItem({
    required IconData icon,
    required String title,
    Widget? trailing,
    VoidCallback? onTap,
    bool isLogout = false,
  }) {
    // Determine the color based on whether it's the logout button
    final color = isLogout ? Colors.red : Colors.black87;

    return ListTile(
      leading: Icon(icon, color: color),
      title: Text(
        title,
        style: TextStyle(
          color: color,
          fontWeight: FontWeight.w500,
          fontSize: 16,
        ),
      ),
      trailing: trailing,
      onTap: onTap,
      dense: true,
    );
  }
}
