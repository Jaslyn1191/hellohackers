We are Team HelloHackers, a group of passionate developers dedicated to building innovative and user-centered healthcare solutions.

Our goal with MediAI is to improve accessibility to OTC medications while ensuring safety, efficiency, and professional oversight through AI-assisted technology. 

## Repository Overview
This repository contains the source code and documentation for MediAI, an AI-powered mobile application that enables users to purchase over-the-counter (OTC) medicines online.

MediAI integrates Artificial Intelligence (AI) to interact with users, analyze their symptoms through conversation, and provide appropriate OTC medication recommendations. The system also supports pharmacist verification to ensure safe and responsible dispensing.

## Table of contents

- Project Overview
- Key Features
- Overview of Technologies Used
- Implementation Details & Innovation
- Challenges Faced
- Installation & Setup
- Future Roadmap

## Project Overview
### Problem Statement
The rapid advancement of society has led to an increase in health-related issues, resulting in higher demand and consumption of medicines. In Malaysia, over-the-counter (OTC) drugs are widely accessible and commonly purchased without prescriptions. However, improper self-medication may lead to incorrect drug selection, misuse, or potential health risks. Additionally, pharmacists may face time constraints when attending to multiple customers, which can delay consultation and medication dispensing.

There is a need for a smarter and more efficient system that improves accessibility to OTC medicines while ensuring safe and responsible consumption.

### Sustainable Development Goals (SDG) Alignment
MediAI aligns with the following Sustainable Development Goals:

**SDG 3 – Good Health and Well-being**  
MediAI promotes safe and effective medication use by incorporating pharmacist verification to reduce misuse of OTC drugs.

**SDG 9 – Industry, Innovation and Infrastructure**  
The integration of Artificial Intelligence (AI), specifically Gemini AI, demonstrates innovation in digital healthcare solutions.

**SDG 12 – Responsible Consumption and Production**  
By guiding users toward appropriate medication choices and involving pharmacists in the verification process, MediAI encourages responsible consumption of medicines.

### Solution Overview
MediAI is an AI-powered application that enables users to purchase OTC medicines online through interactive conversations. Users describe their symptoms to the AI, which gathers relevant information and suggests suitable OTC medications.
Before final dispensing, the system notifies a pharmacist to review and verify the appropriateness of the medication. This ensures both efficiency and safety in the medication purchasing process.
The application integrates Gemini AI to provide intelligent symptom analysis and conversational interaction.

## Key Features
**1. AI-Powered Symptom Analysis**  
Users describe their symptoms through an interactive chat interface powered by Gemini AI.

**2. Smart OTC Medication Recommendations**  
The system suggests suitable over-the-counter (OTC) medicines based on user input.

**3. Pharmacist Verification Workflow**  
All AI-generated recommendations are reviewed and approved by a pharmacist before final dispensing.

**4. Real-Time Case Notification**  
Pharmacists receive notifications when new cases require verification.

**5. Secure Conversation History (Firebase Integration)**  
User-AI conversations are securely stored for pharmacist review and record tracking.

**6. Online OTC Purchasing**  
Users can conveniently purchase verified OTC medicines directly within the application.

## Overview of Technologies Used
### Google Technologies 
**1. Google Gemini (Generative AI Model)**  
Gemini AI is integrated into MediAI to analyze user-reported symptoms through natural language conversation. It generates intelligent OTC medication recommendations based on contextual understanding.

**2. Firebase**  
Firebase is used as the backend infrastructure of the application. It supports:

- Firestore database for storing user conversations
- Authentication (if implemented)
- Cloud Functions for server-side logic
- Real-time data synchronisation

**3. Firebase Cloud Functions**  
Used to handle secure backend logic, API calls to Gemini AI, and pharmacist notification workflows.

**4. Flutter**  
Used to develop the cross-platform mobile application interface. Flutter enables smooth UI rendering and seamless communication with the backend services.

### Other Supporting Tools / Libraries
**1. Node.js**  
Used for backend development and server-side logic.

**2. Express.js**  
Provides routing and API endpoint handling for communication between the mobile app and backend.

**3. CORS Middleware**  
Enables secure cross-origin communication between frontend and backend.

**4. Android Studio**  
Used to develop and test the mobile application interface.

## Implementation Details & Innovation
### System Architecture 
### Workflow

## Challenges Faced
During development, our team encountered several technical challenges while building MediAI:  
**1. Integrating Frontend and Backend**  
Merging Flutter frontend with Firebase backend and Cloud Functions required careful handling of API calls and data flow.

**2. AI API Limitations on Android Studio**  
Initially, calls to Gemini AI did not work directly through Android Studio, which required switching to Flutter for proper integration.

**3. UI Responsiveness**  
Making the chat interface smooth and intuitive across different devices and screen sizes.

**4. AI Response Accuracy**  
Initially, the AI often provided irrelevant or mismatched responses, which required debugging and fine-tuning how input is sent to the API.

## Installation & Setup
Before running the installation steps, make sure that Node.js v18+ and npm are installed in your development environment. 

**Step 1: Clone the repository**

1. **Download VS Code**: With the Visual Studio Code IDE, you can simply copy the git repository URL, clone it to your local device, and run the application locally.
2. **Install Node.js**: Navigate to https://nodejs.org/en/download and install the latest version of Node.js
3. **Clone the repository**: 
    - Click on the "Code" button
    - 

**Step 2: Running the application**

1. **Install dependecies**: In VS Code, open the terminal, and insert the command below, then press Enter:
```bash
npm install
```

## Future Roadmap
**Phase 1: Enhanced User Interaction**  
- Add voice-based user input
- Integrate AI transcription for speech-to-text conversion
- Implement structured symptom extraction to improve AI analysis

**Phase 2: Personalised Healthcare Assistance**  
- Personalise AI dosage recommendations and guidance based on user history
- Implement proactive AI follow-ups and medication reminders
- Support multi-language AI interactions to reach a wider user base

**Phase 3: Advanced System Insights & Operations**  
- Provide inventory and availability visibility for pharmacies
- Implement analytics dashboard for usage and trends
- Ensure multi-region compliance for regulatory and safety standards
