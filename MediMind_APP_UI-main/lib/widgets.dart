import 'package:flutter/material.dart';
import 'medications_page.dart'; // Add this import

class BottomNavBar extends StatefulWidget {
  final int currentIndex;

  const BottomNavBar({super.key, required this.currentIndex});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  
  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 300),
    )..forward();
  }
  
  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 75,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: Offset(0, -2),
          ),
        ],
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            // Home button
            _buildNavButton(
              icon: Icons.home_rounded, 
              label: 'Home',
              isSelected: widget.currentIndex == 0,
              onTap: () => _navigateTo(0, '/home'),
            ),
            
            // Medications button
            _buildNavButton(
              icon: Icons.assignment_rounded, 
              label: 'Medications',
              isSelected: widget.currentIndex == 1,
              onTap: () => _navigateTo(1, '/medications'),
            ),
            
            // Empty space for FAB
            Container(
              width: 50,
            ),
            
            // Settings button (replacing Calendar button)
            _buildNavButton(
              icon: Icons.settings_rounded, 
              label: 'Settings',
              isSelected: widget.currentIndex == 2,
              onTap: () => _navigateTo(2, '/settings'),
            ),
            
            // Profile button
            _buildNavButton(
              icon: Icons.person_rounded, 
              label: 'Profile',
              isSelected: widget.currentIndex == 3,
              onTap: () => _navigateTo(3, '/profile'),
            ),
          ],
        ),
      ),
    );
  }
  
  void _navigateTo(int index, String route) {
    // Reset animation when tapped
    _animationController.reset();
    _animationController.forward();
    
    // Use named routes for consistent navigation
    Navigator.pushReplacementNamed(context, route);
  }
  
  Widget _buildNavButton({
    required IconData icon,
    required String label,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Icon with animation
            isSelected 
              ? TweenAnimationBuilder(
                  tween: Tween<double>(begin: 0.8, end: 1.0),
                  duration: Duration(milliseconds: 300),
                  curve: Curves.elasticOut,
                  builder: (context, scale, child) {
                    return Transform.scale(
                      scale: scale,
                      child: child,
                    );
                  },
                  child: Icon(
                    icon, 
                    color: Colors.green.shade700,
                    size: 28,
                  ),
                )
              : Icon(
                  icon,
                  color: Colors.grey.shade500,
                  size: 26, 
                ),
            
            SizedBox(height: 4),
            
            // Label
            Text(
              label,
              style: TextStyle(
                color: isSelected ? Colors.green.shade700 : Colors.grey.shade500,
                fontSize: isSelected ? 12 : 10,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
            ),
            
            // Indicator dot for selected item
            SizedBox(height: 4),
            if (isSelected)
              SlideTransition(
                position: Tween<Offset>(
                  begin: Offset(0, -0.5),
                  end: Offset.zero,
                ).animate(CurvedAnimation(
                  parent: _animationController,
                  curve: Curves.easeOutCubic,
                )),
                child: FadeTransition(
                  opacity: _animationController,
                  child: Container(
                    height: 4,
                    width: 12,
                    decoration: BoxDecoration(
                      color: Colors.green.shade700,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
              )
            else
              SizedBox(height: 4),
          ],
        ),
      ),
    );
  }
}

class MedicineBox extends StatelessWidget {
  final String name;

  const MedicineBox({super.key, required this.name});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.teal.shade50,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        name,
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
    );
  }
}
