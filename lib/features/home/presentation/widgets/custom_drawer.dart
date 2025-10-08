import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:laza_ecommerce/core/utiles/color_utiles.dart';

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
        decoration: const BoxDecoration(
          color: Colors.white,
          border: Border(right: BorderSide(color: Colors.blueAccent, width: 1)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
                  IconButton(
                    icon: SvgPicture.asset('assets/svg/menu1.svg'),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  const SizedBox(height: 30),
                  _buildProfileSection(),
                ],
              ),
            ),

            // Divider
            const Divider(color: Colors.black12, height: 1),
            const SizedBox(height: 10),

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

            const Spacer(),

            _buildMenuItem(
              icon: Icons.logout,
              title: 'Logout',
              isLogout: true,
              onTap: () {},
            ),

            // Bottom padding
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileSection() {
    return Row(
      children: [
        const CircleAvatar(
          radius: 27,
          backgroundImage: NetworkImage('https://i.pravatar.cc/150'),
        ),
        const SizedBox(width: 15),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Mrh Raju',
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 17),
              ),
              const SizedBox(height: 4),
              Row(
                children: [
                  Flexible(
                    child: Text(
                      'Verified Profile',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: ColorUtility.colorGray,
                        fontSize: 13,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const SizedBox(width: 5),
                  const Icon(Icons.check_circle, color: Colors.green, size: 16),
                ],
              ),
            ],
          ),
        ),
        // "3 Orders" badge
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          decoration: BoxDecoration(
            color: ColorUtility.lightGray,
            borderRadius: BorderRadius.circular(5),
          ),
          child: const Text(
            '3 Orders',
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w500,
              color: ColorUtility.colorGray,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildMenuItem({
    required IconData icon,
    required String title,
    Widget? trailing,
    VoidCallback? onTap,
    bool isLogout = false,
  }) {
    final color = isLogout ? Colors.red : ColorUtility.textColor1;

    return ListTile(
      leading: Icon(icon, color: color),
      title: Text(
        title,
        style: TextStyle(
          color: color,
          fontWeight: FontWeight.w400,
          fontSize: 15,
        ),
      ),
      trailing: trailing,
      onTap: onTap,
      dense: true,
    );
  }
}
