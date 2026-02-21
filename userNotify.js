import admin from "firebase-admin";

export async function sendNotification(userToken, message) {
  const payload = {
    notification: {
      title: "Health Status",
      body: message,
    },
  };

  try {
    await admin.messaging().sendToDevice(userToken, payload);
    console.log("Okay, thank you. All the information you've provided will now be reviewed by a pharmacist.");
  } catch (error) {
    console.error("Failed to send message, please try again.");
  }
}
