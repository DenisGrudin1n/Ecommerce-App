import 'package:ecommerce_app/core/theme/colors.dart';
import 'package:ecommerce_app/core/theme/gradients.dart';
import 'package:flutter/material.dart';

class HomeBottomNavigationBar extends StatefulWidget {
  const HomeBottomNavigationBar({super.key});

  @override
  _HomeBottomNavigationBarState createState() =>
      _HomeBottomNavigationBarState();
}

class _HomeBottomNavigationBarState extends State<HomeBottomNavigationBar> {
  int _selectedIndex = 0;
  bool _isCartExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        BottomNavigationBar(
          currentIndex: _selectedIndex,
          onTap: (index) {
            setState(() {
              _selectedIndex = index;
              _isCartExpanded = false;
            });
          },
          type: BottomNavigationBarType.fixed,
          selectedItemColor: Colors.transparent,
          unselectedItemColor: AppColors.greyColor,
          items: [
            BottomNavigationBarItem(
              icon: buildIcon(Icons.home, 'Home', _selectedIndex == 0),
              label: '',
            ),
            BottomNavigationBarItem(
              icon:
                  buildIcon(Icons.grid_view, 'Catalogue', _selectedIndex == 1),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: buildIcon(Icons.favorite, 'Favorite', _selectedIndex == 2),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: buildIcon(Icons.person, 'Profile', _selectedIndex == 3),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: buildIcon(Icons.shopping_cart, 'Cart', _selectedIndex == 4),
              label: '',
            ),
          ],
        ),
        if (_isCartExpanded)
          Positioned(
            right: 0,
            child: GestureDetector(
              onTap: () {
                setState(() {
                  _isCartExpanded = !_isCartExpanded;
                });
              },
              child: Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: Container(
                  decoration: BoxDecoration(
                    gradient: AppGradients.purpleGradient,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 19,
                    vertical: 14,
                  ),
                  child: const Row(
                    children: [
                      Icon(Icons.shopping_cart_outlined, color: Colors.white),
                      SizedBox(width: 4),
                      Text(
                        '\$239.98\n2 items',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          )
        else
          Positioned(
            right: 0,
            child: GestureDetector(
              onTap: () {
                setState(() {
                  _isCartExpanded = !_isCartExpanded;
                });
              },
              child: Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: Container(
                  decoration: BoxDecoration(
                    gradient: AppGradients.purpleGradient,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 19,
                    vertical: 14,
                  ),
                  child: const Icon(
                    Icons.shopping_cart_outlined,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          )
      ],
    );
  }

  Widget buildIcon(IconData icon, String label, bool isSelected) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (isSelected)
          ShaderMask(
            shaderCallback: (bounds) {
              return AppGradients.purpleGradient.createShader(bounds);
            },
            child: Icon(icon, color: Colors.white),
          )
        else
          Icon(icon, color: AppColors.greyColor),
        if (isSelected)
          ShaderMask(
            shaderCallback: (bounds) {
              return AppGradients.purpleGradient.createShader(bounds);
            },
            child: Text(
              label,
              style: const TextStyle(color: Colors.white),
            ),
          )
        else
          Text(
            label,
            style: const TextStyle(color: AppColors.greyColor),
          ),
      ],
    );
  }

  Widget buildCartIcon() {
    return ShaderMask(
      shaderCallback: (bounds) {
        return AppGradients.purpleGradient.createShader(bounds);
      },
      child: const Icon(Icons.shopping_cart_outlined, color: Colors.white),
    );
  }
}
