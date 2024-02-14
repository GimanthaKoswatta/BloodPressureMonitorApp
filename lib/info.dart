import 'package:flutter/material.dart';


String determineBloodPressureStatus(int systolic, int diastolic) {
  if (systolic <= 120 && diastolic <= 80) {
    return 'Normal';
  } else if (systolic >= 120 && systolic <= 129 && diastolic < 80) {
    return 'Elevated';
  } else if ((systolic >= 130 && systolic <= 139) || (diastolic >= 80 && diastolic <= 89)) {
    return 'Hypertension Stage 1';
  } else if ( systolic >= 140 && systolic < 180 || diastolic >= 90 && diastolic < 120 ) {
    return 'Hypertension Stage 2';
  } else if (systolic > 180 || diastolic > 120) {
    return 'Hypertensive crisis';
  } else {
    return 'Unknown';
  }
}


class InfoScreen extends StatelessWidget {
  final int systolic;
  final int diastolic;

  const InfoScreen({super.key, required this.systolic, required this.diastolic});

  @override
  Widget build(BuildContext context) {
    String bpStatus = determineBloodPressureStatus(systolic, diastolic);
    String bpMessage;

    switch (bpStatus) {
      case 'Normal':
        bpMessage = 'Blood pressure numbers of less than 120/80 mm Hg are considered within the normal range.';
        break;
      case 'Elevated':
        bpMessage = 'Elevated blood pressure is when readings consistently range from 120-129 systolic and less than 80 mm Hg diastolic.';
        break;
      case 'Hypertension Stage 1':
        bpMessage = 'Hypertension Stage 1 is when blood pressure consistently ranges from 130 to 139 systolic or 80 to 89 mm Hg diastolic.';
        break;
      case 'Hypertension Stage 2':
        bpMessage = 'Hypertension Stage 2 is when blood pressure consistently is 140/90 mm Hg or higher.';
        break;
      case 'Hypertensive crisis':
        bpMessage = 'This stage of high blood pressure requires medical attention. If this is your reading, seek medical care immediately.';
        break;
      default:
        bpMessage = 'Please consult with your doctor for more information.';
    }

    return Scaffold(
      body: SingleChildScrollView( // Added for scrolling if content overflows
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Card( // Enclosed reading in a Card for better UI
                elevation: 4.0,
                child: Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: Center( // Center the Column
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 18.0), // Add padding between texts
                          child: Text(
                            'Your Blood Pressure Reading:',
                            style: Theme.of(context).textTheme.titleLarge?.copyWith(color: Colors.blueGrey),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 8.0), // Add padding between texts
                          child: Text(
                            'Systolic: $systolic mm Hg',
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                        ),
                        Text(
                          'Diastolic: $diastolic mm Hg',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 50),
              Text(
                'Status: $bpStatus',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(color: Colors.red), // Made the status more prominent
              ),
              const SizedBox(height: 15),
              Text(
                bpMessage,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

