import 'package:flutter/material.dart';

class LanguageSettingsPage extends StatefulWidget {
  const LanguageSettingsPage({super.key});

  @override
  State<LanguageSettingsPage> createState() => _LanguageSettingsPageState();
}

class _LanguageSettingsPageState extends State<LanguageSettingsPage> {
  // Currently selected language
  String currentLanguage = "English";
  
  // List of available languages with their details
  final List<Map<String, dynamic>> languages = [
    {
      "name": "English",
      "nativeName": "English",
      "flag": "🇺🇸",
      "code": "en"
    },
    {
      "name": "Spanish",
      "nativeName": "Español",
      "flag": "🇪🇸",
      "code": "es"
    },
    {
      "name": "French",
      "nativeName": "Français",
      "flag": "🇫🇷",
      "code": "fr"
    },
    {
      "name": "German",
      "nativeName": "Deutsch",
      "flag": "🇩🇪",
      "code": "de"
    },
    {
      "name": "Chinese",
      "nativeName": "中文",
      "flag": "🇨🇳",
      "code": "zh"
    },
    {
      "name": "Japanese",
      "nativeName": "日本語",
      "flag": "🇯🇵",
      "code": "ja"
    },
    {
      "name": "Arabic",
      "nativeName": "العربية",
      "flag": "🇸🇦",
      "code": "ar"
    },
    {
      "name": "Bengali",
      "nativeName": "বাংলা",
      "flag": "🇧🇩",
      "code": "bn"
    },
    {
      "name": "Hindi",
      "nativeName": "हिन्दी",
      "flag": "🇮🇳",
      "code": "hi"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Text(
          "Language Settings",
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
      body: Column(
        children: [
          // Language banner
          Container(
            width: double.infinity,
            margin: EdgeInsets.all(16),
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.purple.shade300, Colors.purple.shade700],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.purple.withOpacity(0.3),
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
                        Icons.language,
                        color: Colors.purple.shade700,
                      ),
                    ),
                    SizedBox(width: 12),
                    Text(
                      "App Language",
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
                  "Select your preferred language for the app interface",
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.9),
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Text(
              "CURRENT LANGUAGE",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.green.shade700,
                letterSpacing: 1.0,
              ),
            ),
          ),
          
          // Current language card
          Container(
            margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
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
                width: 48,
                height: 48,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.purple.shade50,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  languages.firstWhere((lang) => lang["name"] == currentLanguage)["flag"],
                  style: TextStyle(fontSize: 24),
                ),
              ),
              title: Text(
                currentLanguage,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              subtitle: Text(
                "Currently selected",
                style: TextStyle(
                  color: Colors.grey.shade600,
                  fontSize: 14,
                ),
              ),
              trailing: Icon(
                Icons.check_circle,
                color: Colors.green.shade700,
              ),
            ),
          ),
          
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child: Text(
              "AVAILABLE LANGUAGES",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.green.shade700,
                letterSpacing: 1.0,
              ),
            ),
          ),
          
          // List of available languages
          Expanded(
            child: ListView.builder(
              itemCount: languages.length,
              padding: EdgeInsets.symmetric(horizontal: 16),
              itemBuilder: (context, index) {
                final language = languages[index];
                final bool isSelected = language["name"] == currentLanguage;
                
                return Container(
                  margin: EdgeInsets.only(bottom: 12),
                  decoration: BoxDecoration(
                    color: isSelected ? Colors.purple.shade50 : Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 5,
                        spreadRadius: 0,
                        offset: Offset(0, 2),
                      ),
                    ],
                    border: isSelected 
                      ? Border.all(color: Colors.purple.shade300, width: 2)
                      : null,
                  ),
                  child: ListTile(
                    contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                    leading: Container(
                      width: 40,
                      height: 40,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        language["flag"],
                        style: TextStyle(fontSize: 24),
                      ),
                    ),
                    title: Text(
                      language["name"],
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                    ),
                    subtitle: Text(
                      language["nativeName"],
                      style: TextStyle(
                        color: Colors.grey.shade600,
                        fontSize: 13,
                      ),
                    ),
                    trailing: isSelected 
                      ? Icon(Icons.check_circle, color: Colors.purple.shade700)
                      : null,
                    onTap: () {
                      setState(() {
                        currentLanguage = language["name"];
                      });
                      
                      // Show confirmation
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Language changed to ${language["name"]}'),
                          backgroundColor: Colors.green.shade700,
                          behavior: SnackBarBehavior.floating,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          margin: EdgeInsets.all(16),
                          action: SnackBarAction(
                            label: 'OK',
                            textColor: Colors.white,
                            onPressed: () {},
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ),
          
          // Auto-detect section
          Container(
            margin: EdgeInsets.all(16),
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.sensors,
                  color: Colors.purple.shade700,
                ),
                SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Auto-detect Language",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        "Use your device's language settings",
                        style: TextStyle(
                          color: Colors.grey.shade600,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
                Switch(
                  value: false,
                  onChanged: (value) {},
                  activeColor: Colors.purple.shade700,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
