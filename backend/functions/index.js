// index.js inside functions folder

const functions = require('firebase-functions'); // Firebase v1/v2 API
const express = require('express');
const cors = require('cors');
const { GoogleGenerativeAI } = require('@google/generative-ai');
require('dotenv').config();   // Load .env variables
const admin = require('firebase-admin');

admin.initializeApp();       // initialize Firestore
const db = admin.firestore();

// Initialize Express
const app = express();
app.use(express.json());
app.use(cors());

// Initialize Gemini AI
const genAI = new GoogleGenerativeAI(process.env.GOOGLE_API_KEY);

const persona = `
You are a pharmacy AI assistant.

RULES:
  1. First ask: "Is this consultation for yourself?"
  2. If yes → continue symptom collection.
  3. If no → ask age group.
  4. Suggest appropriate medication to the pharmacist
  5. Do NOT prescribe medication.
  6. Always say case will be reviewed by pharmacist.
`;

const model = genAI.getGenerativeModel({
  model: "gemini-2.5-flash",
  systemInstruction: persona
});

// In-memory store for active conversations
let activeCases = {};

app.get('/', (req, res) => {
  res.send('Server is running...');
});

app.post('/chat', async (req, res) => {
  try {
    const sessionKey = req.body.sessionKey || "default";

    if (!activeCases[sessionKey]) {
      activeCases[sessionKey] = {
        caseId: null,
        conversation: []
      };
    }

    const userMessage = req.body.chat?.trim();
    let prompt;

    if (!userMessage && activeCases[sessionKey].conversation.length === 0) {
      prompt = "Start the conversation as a friendly pharmacy assistant. Ask: 'Is this consultation for yourself?'";
    } else {
      if (userMessage) {
        activeCases[sessionKey].conversation.push({ role: "user", content: userMessage });
      }
      prompt = activeCases[sessionKey].conversation
        .map(msg => (msg.role === "user" ? `Patient: ${msg.content}` : `AI: ${msg.content}`))
        .join("\n");
    }

    const result = await model.generateContent(prompt);
    const aiReply = result.response.text();

    activeCases[sessionKey].conversation.push({ role: "assistant", content: aiReply });

    // Save to Firestore
    if (!activeCases[sessionKey].caseId) {
      const docRef = await db.collection("cases").add({
        conversation: activeCases[sessionKey].conversation,
        status: "Pending Pharmacist Review",
        createdAt: new Date()
      });
      activeCases[sessionKey].caseId = docRef.id;
    } else {
      await db.collection("cases")
        .doc(activeCases[sessionKey].caseId)
        .update({
          conversation: activeCases[sessionKey].conversation,
          updatedAt: new Date()
        });
    }

    res.json({
      caseId: activeCases[sessionKey].caseId,
      reply: aiReply
    });

  } catch (error) {
    console.error(error);
    res.status(500).json({ error: "AI processing failed" });
  }
});

// Export as Firebase Function
exports.api = functions.https.onRequest(app);