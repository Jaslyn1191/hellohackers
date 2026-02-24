import 'package:flutter/material.dart';

class CaseDetailedView extends StatefulWidget {
  final int caseId;
  final String patientName;
  final int patientAge;
  final List<MedicineItem> medicines;

  const CaseDetailedView({
    super.key,
    required this.caseId,
    required this.patientName,
    required this.patientAge,
    required this.medicines,
  });

  @override
  State<CaseDetailedView> createState() => _CaseDetailedViewState();
}

class _CaseDetailedViewState extends State<CaseDetailedView> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      insetPadding: const EdgeInsets.all(10),
      child: Container(
        width: double.infinity,
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.95,
          maxHeight: MediaQuery.of(context).size.height * 0.9,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          image: const DecorationImage(
            image: AssetImage('assets/images/background_1.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            // Scrollable content area
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Case ID
                    Text(
                      'Case #${widget.caseId}',
                      style: const TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontFamily: 'timess',
                      ),
                    ),
                    const SizedBox(height: 40),

                    // Patient Name
                    Row(
                      children: [
                        const SizedBox(
                          width: 100,
                          child: Text(
                            'Patient Name:',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            widget.patientName,
                            style: const TextStyle(
                              fontSize: 15,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 30),

                    // Patient Age
                    Row(
                      children: [
                        const SizedBox(
                          width: 100,
                          child: Text(
                            'Patient Age:',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            '${widget.patientAge} years',
                            style: const TextStyle(
                              fontSize: 15,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 40),

                    // Medicine Prescription Table
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Column(
                        children: [
                          // Table Header
                          Row(
                            children: [
                              Expanded(
                                flex: 1,
                                child: Text(
                                  'Medicine',
                                  style: const TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 20),
                              Expanded(
                                flex: 1,
                                child: Text(
                                  'Dosage (mg)',
                                  style: const TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const Divider(color: Colors.black26),
                          // Table Rows
                          ...widget.medicines.map((medicine) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(vertical: 8),
                              child: Row(
                                children: [
                                  Expanded(
                                    flex: 1,
                                    child: Text(
                                      medicine.name,
                                      style: const TextStyle(
                                        fontSize: 14,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 20),
                                  Expanded(
                                    flex: 1,
                                    child: Text(
                                      '${medicine.dosage}',
                                      style: const TextStyle(
                                        fontSize: 14,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }).toList(),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Buttons at bottom
            Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 180,
                    child: ElevatedButton(
                      onPressed: () {
                        _showApprovalDialog();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF00796B),
                        padding: const EdgeInsets.symmetric(vertical: 12),
                      ),
                      child: const Text(
                        'Approve prescription',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  SizedBox(
                    width: 180,
                    child: ElevatedButton(
                      onPressed: () {
                        _showContactDialog();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF00796B),
                        padding: const EdgeInsets.symmetric(vertical: 12),
                      ),
                      child: const Text(
                        'Contact Patient',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
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

  void _showApprovalDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Approval'),
        content: const Text('Prescription approved successfully!'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  void _showContactDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Contact Patient'),
        content: const Text('Contacting patient...'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
}

// Model class for medicine items
class MedicineItem {
  final String name;
  final double dosage;

  MedicineItem({required this.name, required this.dosage});
}

// Helper function to show the detailed view as a modal
void showCaseDetailedView(
  BuildContext context, {
  required int caseId,
  required String patientName,
  required int patientAge,
  required List<MedicineItem> medicines,
}) {
  showDialog(
    context: context,
    builder: (context) => CaseDetailedView(
      caseId: caseId,
      patientName: patientName,
      patientAge: patientAge,
      medicines: medicines,
    ),
  );
}
