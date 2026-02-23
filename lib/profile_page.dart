import 'package:flutter/material.dart';

// This is a StatefulWidget because its content (the text in the form fields) can change.
class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  // --- Key for the Form widget ---
  // This key is used to uniquely identify the form and manage its state (like validation).
  final _formKey = GlobalKey<FormState>();

  // --- Controllers for Text Fields ---
  // Controllers listen to and control the text inside a TextFormField.
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();

  // --- Function to select a date (for Date of Birth) ---
  Future<void> _selectDate(BuildContext context) async {
    // Show the date picker dialog
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900), // Earliest date allowed
      lastDate: DateTime.now(), // Latest date allowed (today)
    );
    // If a date was picked and it's different from the current one
    if (picked != null) {
      setState(() {
        // Format the DateTime object to a simple String (YYYY-MM-DD)
        // You can format this differently, e.g., using the `intl` package.
        _dobController.text = "${picked.year}-${picked.month}-${picked.day}";
      });
    }
  }

  // --- Function called when the "Save Profile" button is pressed ---
  void _saveProfile() {
    // Validate all the form fields that have a `validator` function.
    if (_formKey.currentState!.validate()) {
      // If the form is valid, show a success message.
      // In a real app, you would save this data to a database (like Firebase) here.
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Profile Saved! (Simulated)')),
      );
      // You can access the text from controllers like this:
      // print('Name: ${_nameController.text}');
      // print('DOB: ${_dobController.text}');
      // print('Address: ${_addressController.text}');
    }
  }

  // --- Important: Dispose controllers when the widget is removed ---
  // This prevents memory leaks.
  @override
  void dispose() {
    _nameController.dispose();
    _dobController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Profile'),
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        // The Form widget groups and validates multiple form fields [citation:3]
        child: Form(
          key: _formKey,
          child: ListView(
            // ListView is scrollable, good for forms on small screens
            children: [
              // --- Name Field ---
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Full Name',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.person),
                ),
                keyboardType: TextInputType.name,
                // Validator ensures the field isn't empty [citation:3]
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // --- Date of Birth Field ---
              TextFormField(
                controller: _dobController,
                decoration: InputDecoration(
                  labelText: 'Date of Birth',
                  border: const OutlineInputBorder(),
                  prefixIcon: const Icon(Icons.calendar_today),
                  // Add a suffix icon to make it clear it's tappable
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.edit_calendar),
                    onPressed: () => _selectDate(context),
                  ),
                ),
                readOnly: true, // Prevents manual typing, forces date picker
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please select your date of birth';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // --- Address Field (Optional) ---
              TextFormField(
                controller: _addressController,
                decoration: const InputDecoration(
                  labelText: 'Address (Optional)',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.home),
                ),
                keyboardType: TextInputType.streetAddress,
                maxLines: 3, // Allows for multi-line addresses
                // No validator means this field is optional
              ),
              const SizedBox(height: 24),

              // --- Save Button ---
              ElevatedButton(
                onPressed: _saveProfile,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: const Text(
                  'Save Profile',
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}