import admin from "firebase-admin";

export async function notifyPharmacist(pharmacistToken, patientInfo) {
    const payload = {
        notification: {
            title: "New Patient Data Report",
            body: `Patient report: ${patientInfo}. Please review.`,
        },
    };

    for (let attempt = 1; attempt <= retries; attempt++) {
        try {
            await admin.messaging().sendToDevice(pharmacistToken, payload);
            console.log("Pharmacist notified successfully");
            return true;
        } catch (error) {
            console.error(`Failed to notify pharmacist:`, error);
            if (attempt < retries) {
                console.log("Retrying sending notification to pharmacist...");
                await new Promise((resolve) => setTimeout(resolve, 2000));
            } else {
                console.log("Fail to send notification.");
                return false;
            }
        }
    }
}