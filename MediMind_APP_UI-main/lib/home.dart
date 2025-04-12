import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'widgets.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Create a state variable for the medicines list
  List<MedicineItem> medicines = [
    MedicineItem(
      name: "Omeprazole",
      dosage: "1 pill, morning",
      time: "8:00 AM",
      isCompleted: false,
      color: Colors.blue,
      category: "Stomach",
    ),
    MedicineItem(
      name: "Paracetamol",
      dosage: "1 pill, as needed",
      time: "Every 6 hours",
      isCompleted: true,
      color: Colors.orange,
      category: "Pain Relief",
    ),
    MedicineItem(
      name: "Lisinopril",
      dosage: "1 pill, daily",
      time: "9:00 PM",
      isCompleted: false,
      color: Colors.purple,
      category: "Blood Pressure",
    ),
  ];

  // Current selected day index
  int _selectedDayIndex = 2;
  
  // Get current date
  DateTime _currentDate = DateTime.now();
  
  // Generate date list
  List<DateTime> _getDates() {
    final List<DateTime> dates = [];
    final DateTime now = DateTime.now();
    
    // Include dates from 3 days ago to 3 days ahead
    for (int i = -3; i <= 3; i++) {
      dates.add(now.add(Duration(days: i)));
    }
    
    return dates;
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final List<DateTime> datesToShow = _getDates();
    
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            // App Bar
            SliverAppBar(
              expandedHeight: 120.0,
              floating: false,
              pinned: true,
              backgroundColor: Colors.white,
              elevation: 0,
              flexibleSpace: FlexibleSpaceBar(
                background: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [Colors.green.shade400, Colors.green.shade700],
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 40, 20, 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              "Hello, John",
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              "Stay healthy with your medications",
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.white.withOpacity(0.9),
                              ),
                            ),
                          ],
                        ),
                        CircleAvatar(
                          radius: 24,
                          backgroundColor: Colors.white.withOpacity(0.2),
                          child: Icon(
                            Icons.person,
                            size: 30,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                titlePadding: EdgeInsets.zero,
                title: Container(
                  height: 56,
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "MediMind",
                          style: TextStyle(
                            color: Colors.green.shade700,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Row(
                          children: [
                            IconButton(
                              icon: Icon(Icons.search, color: Colors.green.shade700),
                              onPressed: () {
                                // Show search
                              },
                            ),
                            IconButton(
                              icon: Icon(Icons.add_circle_outline, 
                                color: Colors.green.shade700, 
                                size: 28
                              ),
                              onPressed: () {
                                _showAddMedicineDialog(context);
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            
            // Main Content
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Today's date
                    RichText(
                      text: TextSpan(
                        style: TextStyle(fontSize: 20, color: Colors.black87),
                        children: [
                          TextSpan(
                            text: "Today, ",
                            style: TextStyle(fontWeight: FontWeight.normal),
                          ),
                          TextSpan(
                            text: DateFormat('d MMMM, yyyy').format(_currentDate),
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    
                    SizedBox(height: 24),
                    
                    // Date selector
                    SizedBox(
                      height: 90,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: datesToShow.length,
                        itemBuilder: (context, index) {
                          final date = datesToShow[index];
                          final dayName = DateFormat('E').format(date).toUpperCase();
                          final dayNum = date.day.toString();
                          final isSelected = index == _selectedDayIndex;
                          final isToday = DateUtils.isSameDay(date, DateTime.now());
                          
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                _selectedDayIndex = index;
                              });
                            },
                            child: Container(
                              margin: EdgeInsets.only(right: 12),
                              width: 60,
                              decoration: BoxDecoration(
                                color: isSelected ? Colors.green.shade600 : Colors.white,
                                borderRadius: BorderRadius.circular(16),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.05),
                                    blurRadius: 8,
                                    offset: Offset(0, 2),
                                  ),
                                ],
                                border: isToday && !isSelected
                                    ? Border.all(color: Colors.green.shade300, width: 2)
                                    : null,
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    dayName,
                                    style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w600,
                                      color: isSelected ? Colors.white : Colors.grey.shade600,
                                    ),
                                  ),
                                  SizedBox(height: 8),
                                  Text(
                                    dayNum,
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: isSelected ? Colors.white : Colors.black87,
                                    ),
                                  ),
                                  SizedBox(height: 4),
                                  if (isToday)
                                    Container(
                                      width: 6,
                                      height: 6,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: isSelected ? Colors.white : Colors.green.shade600,
                                      ),
                                    ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    
                    SizedBox(height: 32),
                    
                    // Stats section
                    Row(
                      children: [
                        _buildStatCard(
                          "Medications",
                          medicines.length.toString(),
                          Icons.medication_outlined,
                          Colors.green,
                        ),
                        SizedBox(width: 16),
                        _buildStatCard(
                          "Completed",
                          "1/${medicines.length}",
                          Icons.check_circle_outline,
                          Colors.blue,
                        ),
                      ],
                    ),
                    
                    SizedBox(height: 32),
                    
                    // Medicine list header
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "TODAY'S MEDICATIONS",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 0.5,
                            color: Colors.green.shade800,
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            // Navigate to full medicine list
                          },
                          style: TextButton.styleFrom(
                            minimumSize: Size.zero,
                            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          ),
                          child: Text(
                            "View All",
                            style: TextStyle(
                              color: Colors.green.shade700,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                    
                    SizedBox(height: 16),
                  ],
                ),
              ),
            ),
            
            // Medicine List
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final medicine = medicines[index];
                  return _buildMedicineCard(medicine);
                },
                childCount: medicines.length,
              ),
            ),
            
            // Spacing
            SliverToBoxAdapter(
              child: SizedBox(height: 32),
            ),
            
            // Top Medicine Header
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "TOP MEDICINES",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.5,
                        color: Colors.green.shade800,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        // Handle see all action
                      },
                      style: TextButton.styleFrom(
                        minimumSize: Size.zero,
                        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                      child: Text(
                        "See All",
                        style: TextStyle(
                          color: Colors.green.shade700,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            
            // Horizontal scrolling top medicines
            SliverToBoxAdapter(
              child: SizedBox(
                height: 180, // Fixed height for the row
                child: Padding(
                  padding: EdgeInsets.only(left: 20), // left padding only
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      _buildTopMedicineCard(
                        "Omeprazole", 
                        "For acid reflux", 
                        Icons.heart_broken_outlined,
                        Colors.blue,
                      ),
                      SizedBox(width: 16),
                      _buildTopMedicineCard(
                        "Paracetamol", 
                        "For fever & pain", 
                        Icons.healing_outlined,
                        Colors.orange,
                      ),
                      SizedBox(width: 16),
                      _buildTopMedicineCard(
                        "Losartan", 
                        "For blood pressure", 
                        Icons.monitor_heart_outlined,
                        Colors.purple,
                      ),
                      SizedBox(width: 16),
                      _buildTopMedicineCard(
                        "Amoxicillin", 
                        "Antibiotic", 
                        Icons.coronavirus_outlined,
                        Colors.red,
                      ),
                      SizedBox(width: 20), // Add padding at the end
                    ],
                  ),
                ),
              ),
            ),
            
            // Extra padding at the bottom to avoid FAB overlap
            SliverToBoxAdapter(
              child: SizedBox(height: 100),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavBar(currentIndex: 0),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green.shade700,
        elevation: 4,
        onPressed: () {
          _showAddMedicineDialog(context);
        },
        child: Icon(Icons.add, color: Colors.white),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
  
  Widget _buildStatCard(String title, String value, IconData icon, MaterialColor color) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              spreadRadius: 0,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: color.shade700, size: 24),
            ),
            SizedBox(width: 14),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: Colors.grey.shade600,
                    fontSize: 14,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  value,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMedicineCard(MedicineItem medicine) {
    final Color baseColor = getColorFromMaterialColor(medicine.color);
    final Color lightColor = medicine.color.shade100;
    final Color darkColor = medicine.color.shade700;

    return Container(
      margin: EdgeInsets.fromLTRB(20, 0, 20, 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            spreadRadius: 0,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            // Checkbox or completion indicator
            InkWell(
              onTap: () {
                setState(() {
                  medicine.isCompleted = !medicine.isCompleted;
                });
              },
              child: Container(
                width: 28,
                height: 28,
                decoration: BoxDecoration(
                  color: medicine.isCompleted ? lightColor : Colors.white,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: medicine.isCompleted ? darkColor : Colors.grey.shade300,
                    width: 2,
                  ),
                ),
                child: medicine.isCompleted
                    ? Icon(
                        Icons.check,
                        color: darkColor,
                        size: 16,
                      )
                    : null,
              ),
            ),
            
            SizedBox(width: 16),
            
            // Medicine info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    medicine.name,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                      decoration: medicine.isCompleted 
                          ? TextDecoration.lineThrough 
                          : TextDecoration.none,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    medicine.dosage,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey.shade600,
                    ),
                  ),
                  SizedBox(height: 6),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                    decoration: BoxDecoration(
                      color: baseColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      medicine.category,
                      style: TextStyle(
                        fontSize: 12,
                        color: darkColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            
            // Time
            Container(
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: baseColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                medicine.time,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: darkColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTopMedicineCard(String name, String description, IconData icon, MaterialColor color) {
    // Extract the actual color for specific shades
    final Color baseColor = getColorFromMaterialColor(color);
    final Color darkColor = color.shade700;

    return Container(
      width: 160,
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            spreadRadius: 0,
            offset: Offset(0, 2),
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: baseColor.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, color: darkColor, size: 20),
              ),
              IconButton(
                icon: Icon(Icons.favorite_border, color: Colors.grey.shade400, size: 20),
                padding: EdgeInsets.zero,
                constraints: BoxConstraints(),
                onPressed: () {
                  // Implement favorite functionality
                },
              ),
            ],
          ),
          SizedBox(height: 16),
          Text(
            name,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: Colors.black87,
            ),
          ),
          SizedBox(height: 4),
          Text(
            description,
            style: TextStyle(
              fontSize: 13,
              color: Colors.grey.shade600,
              height: 1.3,
            ),
          ),
          Spacer(),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
              color: baseColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              "Frequently Used",
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w500,
                color: darkColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
  
  void _showAddMedicineDialog(BuildContext context) {
    final TextEditingController nameController = TextEditingController();
    final TextEditingController doseController = TextEditingController();
    final TextEditingController categoryController = TextEditingController();
    String selectedTime = "9:00 AM";
    MaterialColor selectedColor = Colors.blue;
    List<MaterialColor> colorOptions = [
      Colors.blue,
      Colors.green,
      Colors.orange,
      Colors.purple,
      Colors.red,
      Colors.teal,
    ];
    
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return Padding(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
                top: 20,
                left: 20,
                right: 20,
              ),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Header
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Add New Medicine',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.green.shade800,
                          ),
                        ),
                        IconButton(
                          icon: Icon(Icons.close),
                          onPressed: () => Navigator.pop(context),
                        ),
                      ],
                    ),
                    
                    SizedBox(height: 20),
                    
                    // Form fields
                    TextField(
                      controller: nameController,
                      decoration: InputDecoration(
                        labelText: 'Medicine Name',
                        hintText: 'Enter medicine name',
                        prefixIcon: Icon(Icons.medication, color: Colors.green.shade700),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: Colors.grey.shade300),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: Colors.green.shade700, width: 2),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: Colors.grey.shade300),
                        ),
                        filled: true,
                        fillColor: Colors.grey.shade50,
                        contentPadding: const EdgeInsets.symmetric(vertical: 16),
                      ),
                    ),
                    
                    SizedBox(height: 16),
                    
                    TextField(
                      controller: doseController,
                      decoration: InputDecoration(
                        labelText: 'Dosage',
                        hintText: 'e.g., 1 pill daily',
                        prefixIcon: Icon(Icons.description_outlined, color: Colors.green.shade700),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: Colors.grey.shade300),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: Colors.green.shade700, width: 2),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: Colors.grey.shade300),
                        ),
                        filled: true,
                        fillColor: Colors.grey.shade50,
                        contentPadding: const EdgeInsets.symmetric(vertical: 16),
                      ),
                    ),
                    
                    SizedBox(height: 16),
                    
                    TextField(
                      controller: categoryController,
                      decoration: InputDecoration(
                        labelText: 'Category',
                        hintText: 'e.g., Pain Relief',
                        prefixIcon: Icon(Icons.category_outlined, color: Colors.green.shade700),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: Colors.grey.shade300),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: Colors.green.shade700, width: 2),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: Colors.grey.shade300),
                        ),
                        filled: true,
                        fillColor: Colors.grey.shade50,
                        contentPadding: const EdgeInsets.symmetric(vertical: 16),
                      ),
                    ),
                    
                    SizedBox(height: 16),
                    
                    // Time picker
                    InkWell(
                      onTap: () async {
                        final TimeOfDay? time = await showTimePicker(
                          context: context,
                          initialTime: TimeOfDay.now(),
                        );
                        
                        if (time != null) {
                          // Format the time as a string
                          final String formattedTime = _formatTimeOfDay(time);
                          // Store the selected time
                          setState(() {
                            selectedTime = formattedTime;
                          });
                        }
                      },
                      borderRadius: BorderRadius.circular(12),
                      child: Container(
                        padding: EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: Colors.grey.shade300),
                          color: Colors.grey.shade50,
                        ),
                        child: Row(
                          children: [
                            Icon(Icons.access_time, color: Colors.green.shade700),
                            SizedBox(width: 12),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Reminder Time',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey.shade600,
                                  ),
                                ),
                                SizedBox(height: 4),
                                Text(
                                  selectedTime,
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black87,
                                  ),
                                ),
                              ],
                            ),
                            Spacer(),
                            Icon(Icons.arrow_drop_down, color: Colors.grey),
                          ],
                        ),
                      ),
                    ),
                    
                    SizedBox(height: 20),
                    
                    // Color selector
                    Text(
                      'Select Color',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    
                    SizedBox(height: 10),
                    
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: colorOptions.map((color) {
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedColor = color;
                            });
                          },
                          child: Container(
                            margin: EdgeInsets.only(right: 12),
                            width: 30,
                            height: 30,
                            decoration: BoxDecoration(
                              color: color,
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: selectedColor == color
                                    ? Colors.white
                                    : color,
                                width: 2,
                              ),
                              boxShadow: selectedColor == color
                                  ? [
                                      BoxShadow(
                                        color: color.withOpacity(0.4),
                                        blurRadius: 8,
                                        spreadRadius: 2,
                                      )
                                    ]
                                  : null,
                            ),
                            child: selectedColor == color
                                ? Icon(Icons.check, color: Colors.white, size: 16)
                                : null,
                          ),
                        );
                      }).toList(),
                    ),
                    
                    SizedBox(height: 30),
                    
                    // Add button
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green.shade700,
                          foregroundColor: Colors.white,
                          elevation: 2,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        onPressed: () {
                          if (nameController.text.isNotEmpty) {
                            // Add the new medicine to our list
                            MedicineItem newMedicine = MedicineItem(
                              name: nameController.text,
                              dosage: doseController.text.isEmpty ? "As directed" : doseController.text,
                              time: selectedTime,
                              isCompleted: false,
                              color: selectedColor,
                              category: categoryController.text.isEmpty ? "General" : categoryController.text,
                            );
                            
                            // Pop first to avoid setState during build
                            Navigator.of(context).pop();
                            
                            // Then update the state
                            setState(() {
                              medicines.add(newMedicine);
                            });
                            
                          } else {
                            // Show error
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Please enter medicine name'),
                                backgroundColor: Colors.red.shade700,
                                behavior: SnackBarBehavior.floating,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                margin: EdgeInsets.all(16),
                              ),
                            );
                          }
                        },
                        child: Text(
                          'Add Medicine',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    
                    SizedBox(height: 20),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
  
  String _formatTimeOfDay(TimeOfDay time) {
    // Convert to 12-hour format with AM/PM
    final int hour = time.hourOfPeriod;
    final int minute = time.minute;
    final String period = time.period == DayPeriod.am ? 'AM' : 'PM';
    
    return '${hour == 0 ? 12 : hour}:${minute.toString().padLeft(2, '0')} $period';
  }
  
  // Helper function to get different shades of a MaterialColor
  Color getColorFromMaterialColor(MaterialColor color) {
    return color; // Base color
  }
}

// Define a class to hold medicine information
class MedicineItem {
  final String name;
  final String dosage;
  final String time;
  bool isCompleted;
  final MaterialColor color;
  final String category;
  
  MedicineItem({
    required this.name, 
    required this.dosage, 
    required this.time,
    required this.isCompleted,
    required this.color,
    required this.category,
  });
}
