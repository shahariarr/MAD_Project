import 'package:flutter/material.dart';

class NotificationsPage extends StatefulWidget {
  const NotificationsPage({super.key});

  @override
  State<NotificationsPage> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  // Notification preferences
  bool enableAllNotifications = true;
  bool enableMedicineReminders = true;
  bool enableRefillAlerts = true;
  bool enableAppointmentReminders = true;
  bool enableHealthTips = false;
  bool receiveEmailUpdates = false;
  bool receiveSmsAlerts = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Text(
          "Notification Settings",
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
              // Notifications banner
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.green.shade300, Colors.green.shade700],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.green.withOpacity(0.3),
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
                            Icons.notifications_active,
                            color: Colors.green.shade700,
                          ),
                        ),
                        SizedBox(width: 12),
                        Text(
                          "Notification Center",
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
                      "Stay updated with timely alerts about your medications and health.",
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
                "GENERAL NOTIFICATIONS",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.green.shade700,
                  letterSpacing: 1.0,
                ),
              ),
              SizedBox(height: 12),
              
              // Master switch for all notifications
              _buildNotificationCard(
                title: "Enable All Notifications",
                subtitle: "Control all notifications with a single toggle",
                icon: Icons.notifications_active,
                value: enableAllNotifications,
                onChanged: (value) {
                  setState(() {
                    enableAllNotifications = value;
                    // Update all other notification settings
                    if (!value) {
                      enableMedicineReminders = false;
                      enableRefillAlerts = false;
                      enableAppointmentReminders = false;
                      enableHealthTips = false;
                    }
                  });
                },
              ),
              
              SizedBox(height: 24),
              Text(
                "MEDICATION NOTIFICATIONS",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.green.shade700,
                  letterSpacing: 1.0,
                ),
              ),
              SizedBox(height: 12),
              
              // Medicine reminders switch
              _buildNotificationCard(
                title: "Medicine Reminders",
                subtitle: "Get notified when it's time to take your medication",
                icon: Icons.medication_outlined,
                value: enableMedicineReminders,
                onChanged: enableAllNotifications 
                  ? (value) {
                      setState(() {
                        enableMedicineReminders = value;
                      });
                    }
                  : null,
              ),
              
              // Refill alerts switch
              _buildNotificationCard(
                title: "Refill Alerts",
                subtitle: "Receive alerts when your medications are running low",
                icon: Icons.shopping_bag_outlined,
                value: enableRefillAlerts,
                onChanged: enableAllNotifications 
                  ? (value) {
                      setState(() {
                        enableRefillAlerts = value;
                      });
                    }
                  : null,
              ),
              
              // Appointment reminders switch
              _buildNotificationCard(
                title: "Appointment Reminders",
                subtitle: "Get notified about upcoming doctor appointments",
                icon: Icons.calendar_today_outlined,
                value: enableAppointmentReminders,
                onChanged: enableAllNotifications 
                  ? (value) {
                      setState(() {
                        enableAppointmentReminders = value;
                      });
                    }
                  : null,
              ),
              
              // Health tips switch
              _buildNotificationCard(
                title: "Health Tips & Articles",
                subtitle: "Receive helpful health tips and articles",
                icon: Icons.tips_and_updates_outlined,
                value: enableHealthTips,
                onChanged: enableAllNotifications 
                  ? (value) {
                      setState(() {
                        enableHealthTips = value;
                      });
                    }
                  : null,
              ),
              
              SizedBox(height: 24),
              Text(
                "NOTIFICATION CHANNELS",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.green.shade700,
                  letterSpacing: 1.0,
                ),
              ),
              SizedBox(height: 12),
              
              // Email updates switch
              _buildNotificationCard(
                title: "Email Updates",
                subtitle: "Receive weekly reports and notifications via email",
                icon: Icons.email_outlined,
                value: receiveEmailUpdates,
                onChanged: (value) {
                  setState(() {
                    receiveEmailUpdates = value;
                  });
                },
              ),
              
              // SMS alerts switch
              _buildNotificationCard(
                title: "SMS Alerts",
                subtitle: "Get critical alerts via text message",
                icon: Icons.sms_outlined,
                value: receiveSmsAlerts,
                onChanged: (value) {
                  setState(() {
                    receiveSmsAlerts = value;
                  });
                },
              ),
              
              SizedBox(height: 16),
              
              // Do Not Disturb settings
              Container(
                margin: EdgeInsets.only(bottom: 16),
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.amber.shade50,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.amber.shade200),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.do_not_disturb_on, color: Colors.amber.shade800),
                        SizedBox(width: 10),
                        Text(
                          "Quiet Hours",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.amber.shade800,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 8),
                    Text(
                      "Set times when you don't want to receive notifications",
                      style: TextStyle(
                        color: Colors.grey.shade700,
                        fontSize: 14,
                      ),
                    ),
                    SizedBox(height: 12),
                    OutlinedButton(
                      onPressed: () {
                        // Navigate to Do Not Disturb settings
                      },
                      style: OutlinedButton.styleFrom(
                        foregroundColor: Colors.amber.shade800,
                        side: BorderSide(color: Colors.amber.shade300),
                      ),
                      child: Text("Configure Quiet Hours"),
                    ),
                  ],
                ),
              ),
              
              SizedBox(height: 30),
              Center(
                child: TextButton.icon(
                  onPressed: () {
                    // Reset to default notification settings
                    setState(() {
                      enableAllNotifications = true;
                      enableMedicineReminders = true;
                      enableRefillAlerts = true;
                      enableAppointmentReminders = true;
                      enableHealthTips = false;
                      receiveEmailUpdates = false;
                      receiveSmsAlerts = false;
                    });
                    
                    // Show confirmation
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Reset to default notification settings'),
                        backgroundColor: Colors.green.shade700,
                        behavior: SnackBarBehavior.floating,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        margin: EdgeInsets.all(16),
                      ),
                    );
                  },
                  icon: Icon(Icons.restore, color: Colors.green.shade700),
                  label: Text(
                    "Reset to Default Settings",
                    style: TextStyle(color: Colors.green.shade700),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  
  Widget _buildNotificationCard({
    required String title,
    required String subtitle,
    required IconData icon,
    required bool value,
    required void Function(bool)? onChanged,
  }) {
    // If onChanged is null, the switch is disabled
    bool isEnabled = onChanged != null;
    
    return Container(
      margin: EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: isEnabled ? Colors.white : Colors.grey.shade100,
        borderRadius: BorderRadius.circular(12),
        boxShadow: isEnabled ? [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 5,
            spreadRadius: 0,
            offset: Offset(0, 2),
          ),
        ] : null,
      ),
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        leading: Container(
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: isEnabled 
              ? (value ? Colors.green.shade50 : Colors.grey.shade50)
              : Colors.grey.shade100,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(
            icon,
            color: isEnabled 
              ? (value ? Colors.green.shade700 : Colors.grey.shade500)
              : Colors.grey.shade400,
            size: 22,
          ),
        ),
        title: Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 16,
            color: isEnabled ? Colors.black87 : Colors.grey.shade600,
          ),
        ),
        subtitle: Text(
          subtitle,
          style: TextStyle(
            color: isEnabled ? Colors.grey.shade600 : Colors.grey.shade500,
            fontSize: 12,
          ),
        ),
        trailing: Switch(
          value: value,
          onChanged: onChanged,
          activeColor: Colors.green.shade700,
          activeTrackColor: Colors.green.shade100,
        ),
      ),
    );
  }
}
