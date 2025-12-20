const functions = require("firebase-functions");
const admin = require("firebase-admin");

admin.initializeApp();

// 🔐 AUTH-PROTECTED FUNCTION
exports.linkAutopsy = functions.https.onCall(async (data, context) => {
  // ❌ If not logged in
  if (!context.auth) {
    throw new functions.https.HttpsError(
      "unauthenticated",
      "User must be logged in"
    );
  }

  const uid = context.auth.uid;
  const link = data.link;

  if (!link) {
    throw new functions.https.HttpsError(
      "invalid-argument",
      "Link is required"
    );
  }

  // 🧠 Simple autopsy logic
  const riskFlags = [];

  if (!link.startsWith("https://")) {
    riskFlags.push("NO_HTTPS");
  }

  if (link.length > 60) {
    riskFlags.push("LONG_URL");
  }

  return {
    uid,
    link,
    riskFlags,
    verdict: riskFlags.length ? "suspicious" : "clean"
  };
});
