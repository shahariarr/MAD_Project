import 'package:flutter/material.dart';
import 'widgets.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: BottomNavBar(currentIndex: 3), // Assuming profile is 4th item (index 3)
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Profile Header with gradient background
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xFF1A8D7C), Color(0xFF5EEAD4)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 10,
                      spreadRadius: 0,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.fromLTRB(20, 20, 20, 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                            icon: Icon(Icons.arrow_back_ios, color: Colors.white),
                            onPressed: () => Navigator.pop(context),
                          ),
                          Text(
                            "Profile",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          PopupMenuButton(
                            icon: Icon(Icons.more_vert, color: Colors.white),
                            itemBuilder: (context) => [
                              PopupMenuItem(
                                child: Text("Edit Profile"),
                                value: "edit",
                              ),
                              PopupMenuItem(
                                child: Text("Share Profile"),
                                value: "share",
                              ),
                            ],
                            onSelected: (value) {
                              // Handle menu selections
                            },
                          ),
                        ],
                      ),
                    ),
                    
                    SizedBox(height: 15),
                    
                    // Profile Picture with edit button
                    Stack(
                      alignment: Alignment.center,
                      clipBehavior: Clip.none,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white, width: 4),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.2),
                                blurRadius: 10,
                                spreadRadius: 0,
                              ),
                            ],
                          ),
                          child: CircleAvatar(
                            radius: 50,
                            backgroundImage: NetworkImage("https://randomuser.me/api/portraits/women/44.jpg"),
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          right: -5,
                          child: Container(
                            padding: EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.1),
                                  blurRadius: 5,
                                  spreadRadius: 0,
                                ),
                              ],
                            ),
                            child: Icon(
                              Icons.edit,
                              color: Color(0xFF1A8D7C),
                              size: 18,
                            ),
                          ),
                        ),
                      ],
                    ),
                    
                    SizedBox(height: 15),
                    
                    // Name and status
                    Text(
                      "Jane Doe",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      "Healthcare Professional",
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.white.withOpacity(0.9),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    
                    SizedBox(height: 25),
                    
                    // Health Stats Container
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 20),
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.08),
                            blurRadius: 10,
                            spreadRadius: 0,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          _buildHealthStat(
                            icon: Icons.favorite,
                            iconColor: Colors.red.shade400,
                            value: "72",
                            unit: "bpm",
                            label: "Heart Rate",
                          ),
                          _buildDivider(),
                          _buildHealthStat(
                            icon: Icons.local_fire_department,
                            iconColor: Colors.orange.shade600,
                            value: "756",
                            unit: "cal",
                            label: "Calories",
                          ),
                          _buildDivider(),
                          _buildHealthStat(
                            icon: Icons.monitor_weight_outlined,
                            iconColor: Colors.blue.shade600,
                            value: "65",
                            unit: "kg",
                            label: "Weight",
                          ),
                        ],
                      ),
                    ),
                    
                    SizedBox(height: 25),
                  ],
                ),
              ),
              
              SizedBox(height: 20),
              
              // Personal Information Section
              _buildSectionTitle("Personal Information"),
              
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Card(
                  elevation: 1,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(16),
                    child: Column(
                      children: [
                        _buildInfoRow(
                          icon: Icons.email_outlined,
                          title: "Email",
                          content: "taposi.rabeya@example.com",
                        ),
                        Divider(height: 20),
                        _buildInfoRow(
                          icon: Icons.phone_outlined,
                          title: "Phone",
                          content: "+880 1712 345678",
                        ),
                        Divider(height: 20),
                        _buildInfoRow(
                          icon: Icons.calendar_today_outlined,
                          title: "Date of Birth",
                          content: "15 Sep 1988",
                        ),
                        Divider(height: 20),
                        _buildInfoRow(
                          icon: Icons.bloodtype_outlined,
                          title: "Blood Group",
                          content: "O+",
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              
              SizedBox(height: 20),
              
              // Medical Profile Section
              _buildSectionTitle("Medical Profile"),
              
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    _buildProfileTile(
                      icon: Icons.medication_outlined,
                      title: "My Medications",
                      subtitle: "Current and past medications",
                      onTap: () {
                        Navigator.pushNamed(context, '/medications');
                      },
                    ),
                    _buildProfileTile(
                      icon: Icons.check_circle_outline,
                      title: "Health Progress",
                      subtitle: "View your health trends",
                      onTap: () {},
                    ),
                    _buildProfileTile(
                      icon: Icons.note_alt_outlined,
                      title: "Medical Records",
                      subtitle: "View and manage your medical history",
                      onTap: () {},
                    ),
                    _buildProfileTile(
                      icon: Icons.medical_services_outlined,
                      title: "Doctor Appointments",
                      subtitle: "Scheduled and past appointments",
                      onTap: () {},
                    ),
                  ],
                ),
              ),
              
              SizedBox(height: 20),
              
              // App Settings Section
              _buildSectionTitle("App Settings"),
              
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    _buildProfileTile(
                      icon: Icons.notifications_active_outlined,
                      title: "Notifications",
                      subtitle: "Manage your reminders and alerts",
                      onTap: () {
                        Navigator.pushNamed(context, '/notifications');
                      },
                    ),
                    _buildProfileTile(
                      icon: Icons.privacy_tip_outlined,
                      title: "Privacy & Security",
                      subtitle: "Manage your data and privacy settings",
                      onTap: () {
                        Navigator.pushNamed(context, '/privacy');
                      },
                    ),
                    _buildProfileTile(
                      icon: Icons.help_outline,
                      title: "Help & Support",
                      subtitle: "FAQs and contact information",
                      onTap: () {},
                    ),
                    _buildProfileTile(
                      icon: Icons.info_outline,
                      title: "About MediMind",
                      subtitle: "App information and version",
                      isLast: true,
                      onTap: () {
                        Navigator.pushNamed(context, '/about');
                      },
                    ),
                  ],
                ),
              ),
              
              SizedBox(height: 20),
              
              // Logout Button
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                child: ElevatedButton(
                  onPressed: () {
                    // Show logout confirmation
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text("Logout"),
                          content: Text("Are you sure you want to logout?"),
                          actions: [
                            TextButton(
                              child: Text("Cancel"),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Color(0xFF1A8D7C),
                              ),
                              child: Text("Logout"),
                              onPressed: () {
                                Navigator.of(context).pop();
                                Navigator.pushReplacementNamed(context, '/login');
                              },
                            ),
                          ],
                        );
                      },
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red.shade100,
                    foregroundColor: Colors.red.shade700,
                    padding: EdgeInsets.symmetric(vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    elevation: 0,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.logout),
                      SizedBox(width: 8),
                      Text(
                        "Logout",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
  
  Widget _buildDivider() {
    return Container(
      height: 40,
      width: 1,
      color: Colors.grey.shade300,
    );
  }
  
  Widget _buildHealthStat({
    required IconData icon,
    required Color iconColor,
    required String value,
    required String unit,
    required String label,
  }) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: iconColor.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: iconColor),
        ),
        SizedBox(height: 8),
        RichText(
          text: TextSpan(
            style: TextStyle(color: Colors.black87),
            children: [
              TextSpan(
                text: value,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextSpan(
                text: " $unit",
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey.shade600,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey.shade600,
          ),
        ),
      ],
    );
  }
  
  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: EdgeInsets.fromLTRB(20, 0, 20, 10),
      child: Row(
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1A8D7C),
            ),
          ),
          SizedBox(width: 10),
          Expanded(
            child: Divider(
              color: Colors.grey.shade300,
              thickness: 1,
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildInfoRow({
    required IconData icon,
    required String title,
    required String content,
  }) {
    return Row(
      children: [
        Container(
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Color(0xFF1A8D7C).withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(
            icon,
            color: Color(0xFF1A8D7C),
            size: 20,
          ),
        ),
        SizedBox(width: 15),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey.shade600,
                ),
              ),
              SizedBox(height: 2),
              Text(
                content,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
  
  Widget _buildProfileTile({
    required IconData icon,
    required String title,
    required String subtitle,
    bool isLast = false,
    required VoidCallback onTap,
  }) {
    return Card(
      elevation: 1,
      margin: EdgeInsets.only(bottom: isLast ? 0 : 12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        leading: Container(
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Color(0xFF1A8D7C).withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(
            icon,
            color: Color(0xFF1A8D7C),
          ),
        ),
        title: Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 16,
          ),
        ),
        subtitle: Padding(
          padding: EdgeInsets.only(top: 4),
          child: Text(
            subtitle,
            style: TextStyle(
              fontSize: 13,
              color: Colors.grey.shade600,
            ),
          ),
        ),
        trailing: Icon(
          Icons.arrow_forward_ios,
          size: 16,
          color: Colors.grey.shade400,
        ),
        onTap: onTap,
      ),
    );
  }
}
