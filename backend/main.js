/** Package to enable CORS to handle requests from all domains. */
import cors from 'cors';

/** Framework for building RESTful APIs. */ 
import express from 'express';

/** Package to use the Gemini API. */
import { GoogleGenerativeAI } from '@google/generative-ai';

import 'dotenv/config';   // automatically loads .env variables
import db from "./firebase-admin.js";

/** 
 * To start a new application using Express, put and apply Express into the app variable. */
const app = express ();
app.use(express.json());

/** Apply the CORS middleware. */
app.use(cors())

/** Access the API key and initialize the Gemini SDK. */
const genAI = new GoogleGenerativeAI(process.env.GOOGLE_API_KEY);

// Setting a system persona
// Define the "rules" for the AI
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

/** 
 * Initialize the Gemini model that will generate responses based on the 
 * user's queries. */
const model = genAI.getGenerativeModel({ 
    model: "gemini-2.5-flash",
    systemInstruction: persona
 });

app.get("/", (req, res) => {
  res.send("Server is running...");
});
 
let activeCases = {}; // In-memory map to track ongoing conversations per session

app.post("/chat", async (req, res) => {
  try {
    // Conversation identifier (from front-end session)
    let sessionKey = req.body.sessionKey || "default"; 

    // Initialize conversation if not exists
    if (!activeCases[sessionKey]) {
      activeCases[sessionKey] = {
        caseId: null,     // Will be created once conversation starts
        conversation: []
      };
    }

    let userMessage = req.body.chat?.trim();

    // --- Determine prompt for AI ---
    let prompt;
    if (!userMessage && activeCases[sessionKey].conversation.length === 0) {
      // AI starts the conversation
      prompt = "Start the conversation as a friendly pharmacy assistant. Ask: 'Is this consultation for yourself?'";
    } else {
      // User message exists, build full conversation history
      if (userMessage) {
        activeCases[sessionKey].conversation.push({ role: "user", content: userMessage });
      }

      prompt = activeCases[sessionKey].conversation
        .map(msg => (msg.role === "user" ? `Patient: ${msg.content}` : `AI: ${msg.content}`))
        .join("\n");
    }

    // --- Generate AI response ---
    const result = await model.generateContent(prompt);
    const aiReply = result.response.text();

    // Add AI reply to conversation history
    activeCases[sessionKey].conversation.push({ role: "assistant", content: aiReply });

    // --- Firestore: create/update case ---
    if (!activeCases[sessionKey].caseId) {
      // First time creating case
      const docRef = await db.collection("cases").add({
        conversation: activeCases[sessionKey].conversation,
        status: "Pending Pharmacist Review",
        createdAt: new Date()
      });
      activeCases[sessionKey].caseId = docRef.id;
    } else {
      // Update existing conversation
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
    if (!res.headersSent) res.status(500).json({ error: "AI processing failed" });
  }
});

// Start server
app.listen(3000, () => {
  console.log("Server running on port 3000");
});