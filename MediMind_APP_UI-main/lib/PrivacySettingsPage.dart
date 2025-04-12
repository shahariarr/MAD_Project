import 'package:flutter/material.dart';

class PrivacySettingsPage extends StatefulWidget {
  const PrivacySettingsPage({super.key});

  @override
  State<PrivacySettingsPage> createState() => _PrivacySettingsPageState();
}

class _PrivacySettingsPageState extends State<PrivacySettingsPage> {
  // Privacy settings
  bool makeProfilePrivate = false;
  bool enableDataCollection = true;
  bool allowLocationAccess = true;
  bool shareAnalyticsData = true;
  bool acceptCookies = true;
  bool showMedicineList = true;
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Text(
          "Privacy Settings",
          style: TextStyle(
            color: Colors.green.shade700,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new, color: Colors.green.shade700),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Privacy banner
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.blue.shade300, Colors.blue.shade700],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.blue.withOpacity(0.3),
                      blurRadius: 10,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          backgroundColor: Colors.white,
                          radius: 20,
                          child: Icon(
                            Icons.shield_outlined,
                            color: Colors.blue.shade700,
                          ),
                        ),
                        SizedBox(width: 12),
                        Text(
                          "Your Privacy Matters",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 12),
                    Text(
                      "Control how your personal information is collected, used, and shared.",
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.9),
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
              
              SizedBox(height: 24),
              Text(
                "PROFILE PRIVACY",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.green.shade700,
                  letterSpacing: 1.0,
                ),
              ),
              SizedBox(height: 12),
              
              // Make profile private
              _buildPrivacyCard(
                title: "Make Profile Private",
                subtitle: "Only approved connections can see your profile",
                icon: Icons.person_outlined,
                value: makeProfilePrivate,
                onChanged: (value) {
                  setState(() {
                    makeProfilePrivate = value;
                  });
                },
              ),
              
              // Show medicine list
              _buildPrivacyCard(
                title: "Show Medicine List",
                subtitle: "Allow others to see your medicine list",
                icon: Icons.medication_outlined,
                value: showMedicineList,
                onChanged: (value) {
                  setState(() {
                    showMedicineList = value;
                  });
                },
              ),
              
              SizedBox(height: 24),
              Text(
                "DATA COLLECTION & USAGE",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.green.shade700,
                  letterSpacing: 1.0,
                ),
              ),
              SizedBox(height: 12),
              
              // Enable data collection
              _buildPrivacyCard(
                title: "Data Collection",
                subtitle: "Allow app to collect usage data to improve services",
                icon: Icons.data_usage_outlined,
                value: enableDataCollection,
                onChanged: (value) {
                  setState(() {
                    enableDataCollection = value;
                  });
                },
              ),
              
              // Allow location access
              _buildPrivacyCard(
                title: "Location Access",
                subtitle: "Allow the app to access your location",
                icon: Icons.location_on_outlined,
                value: allowLocationAccess,
                onChanged: (value) {
                  setState(() {
                    allowLocationAccess = value;
                  });
                },
              ),
              
              // Share analytics
              _buildPrivacyCard(
                title: "Share Analytics",
                subtitle: "Share anonymous usage data to improve the app",
                icon: Icons.analytics_outlined,
                value: shareAnalyticsData,
                onChanged: (value) {
                  setState(() {
                    shareAnalyticsData = value;
                  });
                },
              ),
              
              // Accept cookies
              _buildPrivacyCard(
                title: "Accept Cookies",
                subtitle: "Allow the app to use cookies for a better experience",
                icon: Icons.cookie_outlined,
                value: acceptCookies,
                onChanged: (value) {
                  setState(() {
                    acceptCookies = value;
                  });
                },
              ),
              
              SizedBox(height: 24),
              Text(
                "LEGAL DOCUMENTS",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.green.shade700,
                  letterSpacing: 1.0,
                ),
              ),
              SizedBox(height: 12),
              
              // Privacy policy
              _buildLegalDocumentCard(
                title: "Privacy Policy",
                subtitle: "Read our privacy policy and data usage terms",
                icon: Icons.policy_outlined,
                onTap: () {
                  // Open privacy policy
                },
              ),
              
              // Terms of service
              _buildLegalDocumentCard(
                title: "Terms of Service",
                subtitle: "Read our terms of service agreement",
                icon: Icons.description_outlined,
                onTap: () {
                  // Open terms of service
                },
              ),
              
              // GDPR compliance
              _buildLegalDocumentCard(
                title: "Data Request",
                subtitle: "Request a copy of your personal data (GDPR)",
                icon: Icons.file_download_outlined,
                onTap: () {
                  // Show data request dialog
                  _showDataRequestDialog(context);
                },
              ),
              
              SizedBox(height: 20),
              
              // Data deletion section
              Container(
                margin: EdgeInsets.only(bottom: 16),
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.red.shade50,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.red.shade200),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.delete_forever_outlined, color: Colors.red.shade800),
                        SizedBox(width: 10),
                        Text(
                          "Data Deletion",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.red.shade800,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 8),
                    Text(
                      "Request permanent deletion of all your personal data stored in our systems.",
                      style: TextStyle(
                        color: Colors.grey.shade700,
                        fontSize: 14,
                      ),
                    ),
                    SizedBox(height: 12),
                    OutlinedButton(
                      onPressed: () {
                        // Show delete confirmation
                        _showDeleteDataDialog(context);
                      },
                      style: OutlinedButton.styleFrom(
                        foregroundColor: Colors.red.shade800,
                        side: BorderSide(color: Colors.red.shade300),
                      ),
                      child: Text("Request Data Deletion"),
                    ),
                  ],
                ),
              ),
              
              SizedBox(height: 30),
              Center(
                child: TextButton(
                  onPressed: () {
                    // Open privacy FAQ
                  },
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.green.shade700,
                  ),
                  child: Text(
                    "Privacy FAQ",
                    style: TextStyle(
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  
  Widget _buildPrivacyCard({
    required String title,
    required String subtitle,
    required IconData icon,
    required bool value,
    required void Function(bool) onChanged,
  }) {
    return Container(
      margin: EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 5,
            spreadRadius: 0,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        leading: Container(
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: value ? Colors.blue.shade50 : Colors.grey.shade50,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(
            icon,
            color: value ? Colors.blue.shade700 : Colors.grey.shade500,
            size: 22,
          ),
        ),
        title: Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 16,
          ),
        ),
        subtitle: Text(
          subtitle,
          style: TextStyle(
            color: Colors.grey.shade600,
            fontSize: 12,
          ),
        ),
        trailing: Switch(
          value: value,
          onChanged: onChanged,
          activeColor: Colors.blue.shade700,
          activeTrackColor: Colors.blue.shade100,
        ),
      ),
    );
  }
  
  Widget _buildLegalDocumentCard({
    required String title,
    required String subtitle,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return Container(
      margin: EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 5,
            spreadRadius: 0,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        leading: Container(
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.indigo.shade50,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(
            icon,
            color: Colors.indigo.shade700,
            size: 22,
          ),
        ),
        title: Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 16,
          ),
        ),
        subtitle: Text(
          subtitle,
          style: TextStyle(
            color: Colors.grey.shade600,
            fontSize: 12,
          ),
        ),
        trailing: Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey.shade400),
        onTap: onTap,
      ),
    );
  }
  
  void _showDataRequestDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          title: Row(
            children: [
              Icon(Icons.file_download_outlined, color: Colors.indigo.shade700),
              SizedBox(width: 10),
              Text(
                "Request Your Data",
                style: TextStyle(color: Colors.indigo.shade800),
              ),
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "You can request a copy of all personal data we have stored about you. This process may take up to 48 hours to complete.",
                style: TextStyle(height: 1.5),
              ),
              SizedBox(height: 16),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Confirm Email',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.indigo.shade700, width: 2),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                keyboardType: TextInputType.emailAddress,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text("Cancel", style: TextStyle(color: Colors.grey.shade700)),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.indigo.shade700,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onPressed: () {
                Navigator.pop(context);
                // Show confirmation
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Data request submitted. Check your email within 48 hours.'),
                    backgroundColor: Colors.indigo.shade700,
                    behavior: SnackBarBehavior.floating,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    margin: EdgeInsets.all(16),
                  ),
                );
              },
              child: Text("Submit Request", style: TextStyle(color: Colors.white)),
            ),
          ],
        );
      },
    );
  }
  
  void _showDeleteDataDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          title: Row(
            children: [
              Icon(Icons.warning_amber_rounded, color: Colors.red.shade700),
              SizedBox(width: 10),
              Text(
                "Delete Your Data",
                style: TextStyle(color: Colors.red.shade800),
              ),
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Warning: This action cannot be undone. All your personal data will be permanently deleted from our servers.",
                style: TextStyle(height: 1.5),
              ),
              SizedBox(height: 16),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Type "DELETE" to confirm',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.red.shade700, width: 2),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text("Cancel", style: TextStyle(color: Colors.grey.shade700)),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red.shade700,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onPressed: () {
                Navigator.pop(context);
                // Show confirmation
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Data deletion request submitted. You will receive confirmation via email.'),
                    backgroundColor: Colors.red.shade700,
                    behavior: SnackBarBehavior.floating,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    margin: EdgeInsets.all(16),
                  ),
                );
              },
              child: Text("Delete My Data", style: TextStyle(color: Colors.white)),
            ),
          ],
        );
      },
    );
  }
}
