import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'widgets.dart';

class MedicationsPage extends StatefulWidget {
  const MedicationsPage({super.key});

  @override
  State<MedicationsPage> createState() => _MedicationsPageState();
}

class _MedicationsPageState extends State<MedicationsPage> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  
  // Sample data for medications
  List<MedicationItem> _allMedications = [
    MedicationItem(
      name: "Omeprazole",
      dosage: "20mg",
      frequency: "Once daily",
      time: "Before breakfast",
      category: "Proton Pump Inhibitor",
      color: Colors.blue,
      remainingDays: 12,
      totalDays: 30,
      instructions: "Take on an empty stomach, 30 minutes before meals",
      sideEffects: ["Headache", "Nausea", "Stomach pain", "Diarrhea"],
      isFavorite: true,
      refills: 2,
    ),
    MedicationItem(
      name: "Lisinopril",
      dosage: "10mg",
      frequency: "Once daily",
      time: "Morning",
      category: "ACE Inhibitor",
      color: Colors.purple,
      remainingDays: 25,
      totalDays: 30,
      instructions: "Take with or without food at the same time each day",
      sideEffects: ["Dry cough", "Dizziness", "Headache"],
      isFavorite: false,
      refills: 5,
    ),
    MedicationItem(
      name: "Atorvastatin",
      dosage: "40mg",
      frequency: "Once daily",
      time: "Evening",
      category: "Statin",
      color: Colors.orange,
      remainingDays: 5,
      totalDays: 30,
      instructions: "Take in the evening, with or without food",
      sideEffects: ["Muscle pain", "Joint pain", "Digestive issues"],
      isFavorite: true,
      refills: 1,
    ),
    MedicationItem(
      name: "Metformin",
      dosage: "500mg",
      frequency: "Twice daily",
      time: "With meals",
      category: "Antidiabetic",
      color: Colors.green,
      remainingDays: 18,
      totalDays: 30,
      instructions: "Take with meals to reduce stomach upset",
      sideEffects: ["Nausea", "Diarrhea", "Stomach pain", "Metallic taste"],
      isFavorite: false,
      refills: 3,
    ),
    MedicationItem(
      name: "Aspirin",
      dosage: "81mg",
      frequency: "Once daily",
      time: "With food",
      category: "Blood Thinner",
      color: Colors.red,
      remainingDays: 24,
      totalDays: 30,
      instructions: "Take with food to avoid stomach irritation",
      sideEffects: ["Stomach upset", "Heartburn", "Nausea"],
      isFavorite: true,
      refills: 4,
    ),
  ];
  
  // Filtered lists for tabs
  List<MedicationItem> get _currentMedications => _allMedications.where((med) => med.remainingDays > 0).toList();
  List<MedicationItem> get _favorites => _allMedications.where((med) => med.isFavorite).toList();
  List<MedicationItem> get _refills => _allMedications.where((med) => med.remainingDays < 7 && med.remainingDays > 0).toList();

  // Search functionality
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';
  
  // Sorting and filtering options
  String _sortBy = 'name'; // Options: name, remaining
  List<String> _categoryFilters = [];
  
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }
  
  @override
  void dispose() {
    _tabController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  // Filter medications based on search query and category filters
  List<MedicationItem> _filterMedications(List<MedicationItem> medications) {
    if (_searchQuery.isEmpty && _categoryFilters.isEmpty) {
      return _sortMedications(medications);
    }
    
    return _sortMedications(medications.where((med) {
      // Apply search filter
      final matchesSearch = _searchQuery.isEmpty || 
          med.name.toLowerCase().contains(_searchQuery) ||
          med.category.toLowerCase().contains(_searchQuery);
      
      // Apply category filter
      final matchesCategory = _categoryFilters.isEmpty || 
          _categoryFilters.contains(med.category);
      
      return matchesSearch && matchesCategory;
    }).toList());
  }
  
  // Sort medications based on current sort option
  List<MedicationItem> _sortMedications(List<MedicationItem> medications) {
    final sortedList = List<MedicationItem>.from(medications);
    
    switch (_sortBy) {
      case 'name':
        sortedList.sort((a, b) => a.name.compareTo(b.name));
        break;
      case 'remaining':
        sortedList.sort((a, b) => a.remainingDays.compareTo(b.remainingDays));
        break;
      case 'category':
        sortedList.sort((a, b) => a.category.compareTo(b.category));
        break;
    }
    
    return sortedList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        backgroundColor: Colors.green.shade700,
        elevation: 0,
        title: Text(
          "My Medications",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.filter_list_rounded, color: Colors.white),
            onPressed: () {
              _showFilterDialog();
            },
          ),
        ],
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(120),
          child: Column(
            children: [
              // Search bar
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
                child: TextField(
                  controller: _searchController,
                  onChanged: (value) {
                    setState(() {
                      _searchQuery = value.toLowerCase();
                    });
                  },
                  decoration: InputDecoration(
                    hintText: "Search medications...",
                    hintStyle: TextStyle(color: Colors.white.withOpacity(0.7)),
                    prefixIcon: Icon(Icons.search, color: Colors.white),
                    filled: true,
                    fillColor: Colors.white.withOpacity(0.2),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding: EdgeInsets.symmetric(vertical: 0),
                  ),
                  style: TextStyle(color: Colors.white),
                ),
              ),
              
              // Tab bar
              TabBar(
                controller: _tabController,
                indicatorColor: Colors.white,
                indicatorSize: TabBarIndicatorSize.label,
                labelColor: Colors.white,
                unselectedLabelColor: Colors.white.withOpacity(0.7),
                isScrollable: true,
                tabs: [
                  Tab(text: "All Medications"),
                  Tab(text: "Current"),
                  Tab(text: "Favorites"),
                  Tab(text: "Needs Refill"),
                ],
              ),
            ],
          ),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildMedicationsList(_filterMedications(_allMedications)),
          _buildMedicationsList(_filterMedications(_currentMedications)),
          _buildMedicationsList(_filterMedications(_favorites)),
          _buildMedicationsList(_filterMedications(_refills)),
        ],
      ),
      bottomNavigationBar: BottomNavBar(currentIndex: 1),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green.shade700,
        onPressed: () {
          _showAddMedicationDialog();
        },
        child: Icon(Icons.add, color: Colors.white),
        tooltip: "Add Medication",
      ),
    );
  }
  
  Widget _buildMedicationsList(List<MedicationItem> medications) {
    if (medications.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.medication_outlined,
              color: Colors.grey.shade400,
              size: 64,
            ),
            SizedBox(height: 16),
            Text(
              "No medications found",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.grey.shade600,
              ),
            ),
            SizedBox(height: 8),
            Text(
              "Add medications using the + button",
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey.shade500,
              ),
            ),
          ],
        ),
      );
    }
    
    return ListView.builder(
      padding: EdgeInsets.all(16),
      itemCount: medications.length,
      itemBuilder: (context, index) {
        final medication = medications[index];
        return _buildMedicationCard(medication);
      },
    );
  }
  
  Widget _buildMedicationCard(MedicationItem medication) {
    final baseColor = medication.color;
    final darkColor = medication.color.shade700;
    final lightColor = medication.color.shade100;
    
    return Card(
      margin: EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      elevation: 2,
      child: InkWell(
        onTap: () => _showMedicationDetailDialog(medication),
        borderRadius: BorderRadius.circular(16),
        child: Column(
          children: [
            // Header
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: lightColor,
                borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
              ),
              child: Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.medication_outlined,
                      color: darkColor,
                    ),
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          medication.name,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: Colors.black87,
                          ),
                        ),
                        SizedBox(height: 2),
                        Text(
                          medication.category,
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey.shade700,
                          ),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    icon: Icon(
                      medication.isFavorite ? Icons.favorite : Icons.favorite_border,
                      color: medication.isFavorite ? Colors.red : Colors.grey.shade400,
                    ),
                    onPressed: () {
                      setState(() {
                        medication.isFavorite = !medication.isFavorite;
                      });
                    },
                  ),
                ],
              ),
            ),
            
            // Details
            Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                children: [
                  // Dosage and frequency row
                  Row(
                    children: [
                      _buildInfoItem(Icons.straighten, "Dosage", medication.dosage),
                      SizedBox(width: 24),
                      _buildInfoItem(Icons.schedule, "Frequency", medication.frequency),
                    ],
                  ),
                  SizedBox(height: 16),
                  
                  // Time and remaining row
                  Row(
                    children: [
                      _buildInfoItem(Icons.access_time, "Time", medication.time),
                      SizedBox(width: 24),
                      _buildInfoItem(
                        Icons.calendar_today, 
                        "Remaining", 
                        "${medication.remainingDays} days",
                      ),
                    ],
                  ),
                  
                  SizedBox(height: 16),
                  
                  // Progress bar
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Supply",
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey.shade600,
                            ),
                          ),
                          Text(
                            "${medication.remainingDays}/${medication.totalDays} days",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 8),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(4),
                        child: LinearProgressIndicator(
                          value: medication.remainingDays / medication.totalDays,
                          backgroundColor: Colors.grey.shade200,
                          valueColor: AlwaysStoppedAnimation<Color>(
                            medication.remainingDays < 7 ? Colors.red.shade400 : darkColor,
                          ),
                          minHeight: 8,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            
            // Action buttons
            Container(
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(color: Colors.grey.shade200),
                ),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextButton.icon(
                      onPressed: () => _showRefillDialog(medication),
                      style: TextButton.styleFrom(
                        foregroundColor: darkColor,
                        padding: EdgeInsets.symmetric(vertical: 12),
                      ),
                      icon: Icon(Icons.refresh),
                      label: Text("Refill"),
                    ),
                  ),
                  Container(
                    width: 1,
                    height: 24,
                    color: Colors.grey.shade300,
                  ),
                  Expanded(
                    child: TextButton.icon(
                      onPressed: () => _showEditMedicationDialog(medication),
                      style: TextButton.styleFrom(
                        foregroundColor: darkColor,
                        padding: EdgeInsets.symmetric(vertical: 12),
                      ),
                      icon: Icon(Icons.edit),
                      label: Text("Edit"),
                    ),
                  ),
                  Container(
                    width: 1,
                    height: 24,
                    color: Colors.grey.shade300,
                  ),
                  Expanded(
                    child: TextButton.icon(
                      onPressed: () => _deleteMedication(medication),
                      style: TextButton.styleFrom(
                        foregroundColor: Colors.red.shade600,
                        padding: EdgeInsets.symmetric(vertical: 12),
                      ),
                      icon: Icon(Icons.delete_outline),
                      label: Text("Delete"),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
  
  Widget _buildInfoItem(IconData icon, String label, String value) {
    return Expanded(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            icon,
            size: 18,
            color: Colors.grey.shade600,
          ),
          SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey.shade600,
                  ),
                ),
                SizedBox(height: 2),
                Text(
                  value,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
  
  void _showFilterDialog() {
    // Get all unique categories
    final categories = _allMedications.map((med) => med.category).toSet().toList();
    
    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: Text("Filter & Sort"),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Sort By",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(height: 8),
                  Wrap(
                    spacing: 8,
                    children: [
                      _buildFilterChip(
                        label: "Name",
                        selected: _sortBy == "name",
                        onSelected: (selected) {
                          setState(() {
                            _sortBy = "name";
                          });
                        },
                      ),
                      _buildFilterChip(
                        label: "Remaining Days",
                        selected: _sortBy == "remaining",
                        onSelected: (selected) {
                          setState(() {
                            _sortBy = "remaining";
                          });
                        },
                      ),
                      _buildFilterChip(
                        label: "Category",
                        selected: _sortBy == "category",
                        onSelected: (selected) {
                          setState(() {
                            _sortBy = "category";
                          });
                        },
                      ),
                    ],
                  ),
                  
                  SizedBox(height: 16),
                  
                  Text(
                    "Filter By Category",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(height: 8),
                  Container(
                    height: 200,
                    width: double.maxFinite,
                    child: SingleChildScrollView(
                      child: Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: categories.map((category) {
                          return _buildFilterChip(
                            label: category,
                            selected: _categoryFilters.contains(category),
                            onSelected: (selected) {
                              setState(() {
                                if (selected) {
                                  _categoryFilters.add(category);
                                } else {
                                  _categoryFilters.remove(category);
                                }
                              });
                            },
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    setState(() {
                      _sortBy = 'name';
                      _categoryFilters.clear();
                    });
                  },
                  child: Text("Reset"),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    // Update the UI with new filters
                    this.setState(() {});
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green.shade700,
                  ),
                  child: Text("Apply"),
                ),
              ],
            );
          },
        );
      },
    );
  }
  
  Widget _buildFilterChip({
    required String label,
    required bool selected,
    required Function(bool) onSelected,
  }) {
    return FilterChip(
      label: Text(label),
      selected: selected,
      selectedColor: Colors.green.shade100,
      checkmarkColor: Colors.green.shade700,
      onSelected: onSelected,
    );
  }
  
  void _showMedicationDetailDialog(MedicationItem medication) {
    final darkColor = medication.color.shade700;
    
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: medication.color.shade100,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                ),
                child: Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.medication,
                        color: darkColor,
                        size: 28,
                      ),
                    ),
                    SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            medication.name,
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            "${medication.dosage} - ${medication.category}",
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey.shade700,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              
              SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildDetailSection(
                        title: "Dosage Information",
                        content: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildDetailItem("Frequency", medication.frequency),
                            SizedBox(height: 8),
                            _buildDetailItem("Time", medication.time),
                            SizedBox(height: 8),
                            _buildDetailItem(
                              "Remaining Supply", 
                              "${medication.remainingDays} out of ${medication.totalDays} days",
                            ),
                            SizedBox(height: 8),
                            _buildDetailItem(
                              "Available Refills", 
                              "${medication.refills} refills remaining",
                            ),
                          ],
                        ),
                      ),
                      
                      _buildDetailSection(
                        title: "Instructions",
                        content: Text(
                          medication.instructions,
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.black87,
                            height: 1.4,
                          ),
                        ),
                      ),
                      
                      _buildDetailSection(
                        title: "Possible Side Effects",
                        content: Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: medication.sideEffects.map((effect) {
                            return Container(
                              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                              decoration: BoxDecoration(
                                color: Colors.grey.shade100,
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(color: Colors.grey.shade300),
                              ),
                              child: Text(
                                effect,
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey.shade700,
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              
              Padding(
                padding: EdgeInsets.all(16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text("Close"),
                    ),
                    SizedBox(width: 8),
                    ElevatedButton.icon(
                      onPressed: () {
                        Navigator.of(context).pop();
                        _showEditMedicationDialog(medication);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: darkColor,
                      ),
                      icon: Icon(Icons.edit),
                      label: Text("Edit"),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
  
  Widget _buildDetailSection({required String title, required Widget content}) {
    return Container(
      margin: EdgeInsets.only(bottom: 16),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.bold,
              color: Colors.green.shade800,
            ),
          ),
          SizedBox(height: 8),
          content,
        ],
      ),
    );
  }
  
  Widget _buildDetailItem(String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 120,
          child: Text(
            label + ":",
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w500,
              color: Colors.grey.shade700,
            ),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: TextStyle(
              fontSize: 15,
              color: Colors.black87,
            ),
          ),
        ),
      ],
    );
  }
  
  void _showAddMedicationDialog() {
    final nameController = TextEditingController();
    final dosageController = TextEditingController();
    final frequencyController = TextEditingController();
    final timeController = TextEditingController();
    final categoryController = TextEditingController();
    final instructionsController = TextEditingController();
    final totalDaysController = TextEditingController();
    
    // Default values
    int totalDays = 30;
    MaterialColor selectedColor = Colors.blue;
    List<String> sideEffects = [];
    
    List<MaterialColor> colorOptions = [
      Colors.blue,
      Colors.green,
      Colors.orange,
      Colors.purple,
      Colors.red,
      Colors.teal,
    ];
    
    final TextEditingController sideEffectController = TextEditingController();
    
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Add New Medication",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.green.shade800,
                          ),
                        ),
                        IconButton(
                          icon: Icon(Icons.close),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                      ],
                    ),
                    
                    SizedBox(height: 20),
                    
                    // Basic Information
                    _buildSectionTitle("Basic Information"),
                    SizedBox(height: 12),
                    
                    // Name
                    _buildTextField(
                      controller: nameController,
                      label: "Medication Name",
                      hint: "Enter medication name",
                      icon: Icons.medication,
                    ),
                    SizedBox(height: 16),
                    
                    // Dosage
                    _buildTextField(
                      controller: dosageController,
                      label: "Dosage",
                      hint: "e.g., 10mg, 1 pill",
                      icon: Icons.straighten,
                    ),
                    SizedBox(height: 16),
                    
                    // Frequency
                    _buildTextField(
                      controller: frequencyController,
                      label: "Frequency",
                      hint: "e.g., Once daily, Twice daily",
                      icon: Icons.repeat,
                    ),
                    SizedBox(height: 16),
                    
                    // Time
                    _buildTextField(
                      controller: timeController,
                      label: "Time",
                      hint: "e.g., Morning, With meals",
                      icon: Icons.access_time,
                    ),
                    SizedBox(height: 16),
                    
                    // Category
                    _buildTextField(
                      controller: categoryController,
                      label: "Category",
                      hint: "e.g., Pain Relief, Antibiotic",
                      icon: Icons.category,
                    ),
                    SizedBox(height: 16),
                    
                    // Supply
                    _buildTextField(
                      controller: totalDaysController,
                      label: "Supply (days)",
                      hint: "e.g., 30",
                      icon: Icons.calendar_month,
                      keyboardType: TextInputType.number,
                      onChanged: (value) {
                        if (value.isNotEmpty) {
                          setState(() {
                            totalDays = int.tryParse(value) ?? 30;
                          });
                        }
                      },
                    ),
                    SizedBox(height: 16),
                    
                    // Instructions
                    _buildTextField(
                      controller: instructionsController,
                      label: "Instructions",
                      hint: "Enter any specific instructions",
                      icon: Icons.description,
                      maxLines: 3,
                    ),
                    SizedBox(height: 24),
                    
                    // Additional Information
                    _buildSectionTitle("Additional Information"),
                    SizedBox(height: 12),
                    
                    // Color selection
                    Text(
                      "Select Color",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey.shade700,
                      ),
                    ),
                    SizedBox(height: 8),
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
                    SizedBox(height: 24),
                    
                    // Side effects
                    Text(
                      "Side Effects",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey.shade700,
                      ),
                    ),
                    SizedBox(height: 8),
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: sideEffectController,
                            decoration: InputDecoration(
                              hintText: "Add side effect",
                              hintStyle: TextStyle(color: Colors.grey.shade500),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide(color: Colors.grey.shade300),
                              ),
                              contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                            ),
                          ),
                        ),
                        SizedBox(width: 8),
                        ElevatedButton(
                          onPressed: () {
                            if (sideEffectController.text.isNotEmpty) {
                              setState(() {
                                sideEffects.add(sideEffectController.text);
                                sideEffectController.clear();
                              });
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green.shade700,
                            padding: EdgeInsets.symmetric(vertical: 12),
                          ),
                          child: Text("Add"),
                        ),
                      ],
                    ),
                    SizedBox(height: 12),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: sideEffects.map((effect) {
                        return Chip(
                          label: Text(effect),
                          deleteIcon: Icon(Icons.close, size: 16),
                          onDeleted: () {
                            setState(() {
                              sideEffects.remove(effect);
                            });
                          },
                          backgroundColor: Colors.grey.shade100,
                        );
                      }).toList(),
                    ),
                    
                    SizedBox(height: 24),
                    
                    // Add button
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () {
                          if (nameController.text.isNotEmpty && 
                              dosageController.text.isNotEmpty && 
                              frequencyController.text.isNotEmpty) {
                            
                            final newMedication = MedicationItem(
                              name: nameController.text,
                              dosage: dosageController.text,
                              frequency: frequencyController.text,
                              time: timeController.text.isNotEmpty ? timeController.text : "Any time",
                              category: categoryController.text.isNotEmpty ? categoryController.text : "General",
                              color: selectedColor,
                              remainingDays: totalDays,
                              totalDays: totalDays,
                              instructions: instructionsController.text.isNotEmpty 
                                  ? instructionsController.text 
                                  : "No special instructions",
                              sideEffects: sideEffects.isNotEmpty ? sideEffects : ["None reported"],
                              isFavorite: false,
                              refills: 0,
                            );
                            
                            Navigator.pop(context);
                            
                            setState(() {
                              _allMedications.add(newMedication);
                            });
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text("Please fill in all required fields"),
                                backgroundColor: Colors.red.shade600,
                              ),
                            );
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green.shade700,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: Text(
                          "Add Medication",
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

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required IconData icon,
    int maxLines = 1,
    TextInputType keyboardType = TextInputType.text,
    Function(String)? onChanged,
  }) {
    return TextField(
      controller: controller,
      maxLines: maxLines,
      keyboardType: keyboardType,
      onChanged: onChanged,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        prefixIcon: Icon(icon, color: Colors.green.shade700),
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
        contentPadding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      ),
    );
  }
  
  Widget _buildSectionTitle(String title) {
    return Row(
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.bold,
            color: Colors.green.shade800,
          ),
        ),
        SizedBox(width: 8),
        Expanded(
          child: Divider(color: Colors.grey.shade300),
        ),
      ],
    );
  }
  
  void _showEditMedicationDialog(MedicationItem medication) {
    final nameController = TextEditingController(text: medication.name);
    final dosageController = TextEditingController(text: medication.dosage);
    final frequencyController = TextEditingController(text: medication.frequency);
    final timeController = TextEditingController(text: medication.time);
    final categoryController = TextEditingController(text: medication.category);
    final instructionsController = TextEditingController(text: medication.instructions);
    final totalDaysController = TextEditingController(text: medication.totalDays.toString());
    
    // Starting values
    int totalDays = medication.totalDays;
    MaterialColor selectedColor = medication.color;
    List<String> sideEffects = List.from(medication.sideEffects);
    
    List<MaterialColor> colorOptions = [
      Colors.blue,
      Colors.green,
      Colors.orange,
      Colors.purple,
      Colors.red,
      Colors.teal,
    ];
    
    final TextEditingController sideEffectController = TextEditingController();
    
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Edit Medication",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.green.shade800,
                          ),
                        ),
                        IconButton(
                          icon: Icon(Icons.close),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                      ],
                    ),
                    
                    // Same form as add medication dialog
                    SizedBox(height: 20),
                    
                    // Basic Information
                    _buildSectionTitle("Basic Information"),
                    SizedBox(height: 12),
                    
                    // Name
                    _buildTextField(
                      controller: nameController,
                      label: "Medication Name",
                      hint: "Enter medication name",
                      icon: Icons.medication,
                    ),
                    SizedBox(height: 16),
                    
                    // Dosage
                    _buildTextField(
                      controller: dosageController,
                      label: "Dosage",
                      hint: "e.g., 10mg, 1 pill",
                      icon: Icons.straighten,
                    ),
                    SizedBox(height: 16),
                    
                    // Frequency
                    _buildTextField(
                      controller: frequencyController,
                      label: "Frequency",
                      hint: "e.g., Once daily, Twice daily",
                      icon: Icons.repeat,
                    ),
                    SizedBox(height: 16),
                    
                    // Time
                    _buildTextField(
                      controller: timeController,
                      label: "Time",
                      hint: "e.g., Morning, With meals",
                      icon: Icons.access_time,
                    ),
                    SizedBox(height: 16),
                    
                    // Category
                    _buildTextField(
                      controller: categoryController,
                      label: "Category",
                      hint: "e.g., Pain Relief, Antibiotic",
                      icon: Icons.category,
                    ),
                    SizedBox(height: 16),
                    
                    // Supply
                    _buildTextField(
                      controller: totalDaysController,
                      label: "Supply (days)",
                      hint: "e.g., 30",
                      icon: Icons.calendar_month,
                      keyboardType: TextInputType.number,
                      onChanged: (value) {
                        if (value.isNotEmpty) {
                          setState(() {
                            totalDays = int.tryParse(value) ?? 30;
                          });
                        }
                      },
                    ),
                    SizedBox(height: 16),
                    
                    // Remaining days
                    Slider(
                      value: medication.remainingDays.toDouble(),
                      min: 0,
                      max: totalDays.toDouble(),
                      divisions: totalDays,
                      activeColor: Colors.green.shade700,
                      inactiveColor: Colors.grey.shade300,
                      label: "${medication.remainingDays} days remaining",
                      onChanged: (value) {
                        setState(() {
                          medication.remainingDays = value.toInt();
                        });
                      },
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("0 days"),
                        Text(
                          "${medication.remainingDays}/${totalDays} days",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.green.shade700,
                          ),
                        ),
                        Text("$totalDays days"),
                      ],
                    ),
                    SizedBox(height: 16),
                    
                    // Instructions
                    _buildTextField(
                      controller: instructionsController,
                      label: "Instructions",
                      hint: "Enter any specific instructions",
                      icon: Icons.description,
                      maxLines: 3,
                    ),
                    SizedBox(height: 24),
                    
                    // Additional Information
                    _buildSectionTitle("Additional Information"),
                    SizedBox(height: 12),
                    
                    // Color selection
                    Text(
                      "Select Color",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey.shade700,
                      ),
                    ),
                    SizedBox(height: 8),
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
                    SizedBox(height: 24),
                    
                    // Side effects
                    Text(
                      "Side Effects",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey.shade700,
                      ),
                    ),
                    SizedBox(height: 8),
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: sideEffectController,
                            decoration: InputDecoration(
                              hintText: "Add side effect",
                              hintStyle: TextStyle(color: Colors.grey.shade500),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide(color: Colors.grey.shade300),
                              ),
                              contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                            ),
                          ),
                        ),
                        SizedBox(width: 8),
                        ElevatedButton(
                          onPressed: () {
                            if (sideEffectController.text.isNotEmpty) {
                              setState(() {
                                sideEffects.add(sideEffectController.text);
                                sideEffectController.clear();
                              });
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green.shade700,
                            padding: EdgeInsets.symmetric(vertical: 12),
                          ),
                          child: Text("Add"),
                        ),
                      ],
                    ),
                    SizedBox(height: 12),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: sideEffects.map((effect) {
                        return Chip(
                          label: Text(effect),
                          deleteIcon: Icon(Icons.close, size: 16),
                          onDeleted: () {
                            setState(() {
                              sideEffects.remove(effect);
                            });
                          },
                          backgroundColor: Colors.grey.shade100,
                        );
                      }).toList(),
                    ),
                    
                    SizedBox(height: 24),
                    
                    // Update button
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () {
                          if (nameController.text.isNotEmpty && 
                              dosageController.text.isNotEmpty && 
                              frequencyController.text.isNotEmpty) {
                            
                            // Update medication properties
                            medication.name = nameController.text;
                            medication.dosage = dosageController.text;
                            medication.frequency = frequencyController.text;
                            medication.time = timeController.text.isNotEmpty ? timeController.text : "Any time";
                            medication.category = categoryController.text.isNotEmpty ? categoryController.text : "General";
                            medication.color = selectedColor;
                            medication.totalDays = totalDays;
                            medication.instructions = instructionsController.text.isNotEmpty 
                                ? instructionsController.text 
                                : "No special instructions";
                            medication.sideEffects = sideEffects.isNotEmpty ? sideEffects : ["None reported"];
                            
                            Navigator.pop(context);
                            
                            // Update UI
                            this.setState(() {});
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text("Please fill in all required fields"),
                                backgroundColor: Colors.red.shade600,
                              ),
                            );
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green.shade700,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: Text(
                          "Update Medication",
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
  
  void _showRefillDialog(MedicationItem medication) {
    int refillAmount = 30;
    
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Refill ${medication.name}"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Current supply: ${medication.remainingDays}/${medication.totalDays} days",
                style: TextStyle(
                  color: Colors.grey.shade700,
                ),
              ),
              SizedBox(height: 16),
              Text(
                "How many days to add?",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              StatefulBuilder(
                builder: (context, setState) {
                  return Column(
                    children: [
                      Slider(
                        value: refillAmount.toDouble(),
                        min: 1,
                        max: 90,
                        divisions: 89,
                        activeColor: Colors.green.shade700,
                        label: "$refillAmount days",
                        onChanged: (value) {
                          setState(() {
                            refillAmount = value.toInt();
                          });
                        },
                      ),
                      Text(
                        "$refillAmount days",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.green.shade700,
                        ),
                      ),
                    ],
                  );
                },
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  // Increase remaining days by refill amount
                  medication.remainingDays += refillAmount;
                  
                  // If user has refills, decrement
                  if (medication.refills > 0) {
                    medication.refills--;
                  }
                });
                Navigator.of(context).pop();
                
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text("${medication.name} refilled with $refillAmount days"),
                    backgroundColor: Colors.green.shade700,
                    behavior: SnackBarBehavior.floating,
                    margin: EdgeInsets.all(16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green.shade700,
              ),
              child: Text("Refill"),
            ),
          ],
        );
      },
    );
  }
  
  void _deleteMedication(MedicationItem medication) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Delete ${medication.name}?"),
          content: Text(
            "This action cannot be undone. Are you sure you want to delete this medication?",
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _allMedications.remove(medication);
                });
                Navigator.of(context).pop();
                
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text("${medication.name} has been deleted"),
                    backgroundColor: Colors.red.shade600,
                    behavior: SnackBarBehavior.floating,
                    margin: EdgeInsets.all(16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red.shade600,
              ),
              child: Text("Delete"),
            ),
          ],
        );
      },
    );
  }
}

class MedicationItem {
  String name;
  String dosage;
  String frequency;
  String time;
  String category;
  MaterialColor color;
  int remainingDays;
  int totalDays;
  String instructions;
  List<String> sideEffects;
  bool isFavorite;
  int refills;
  
  MedicationItem({
    required this.name,
    required this.dosage,
    required this.frequency,
    required this.time,
    required this.category,
    required this.color,
    required this.remainingDays,
    required this.totalDays,
    required this.instructions,
    required this.sideEffects,
    required this.isFavorite,
    required this.refills,
  });
}