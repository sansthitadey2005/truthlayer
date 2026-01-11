// =========================
// FRONTEND SCAM DETECTOR
// =========================

const scamPatterns = [
  "urgent",
  "account has been suspended",
  "verify your password",
  "click here",
  "immediately",
  "login",
  "password",
  "free",
  "gift",
  "winner",
  "upi",
  "pay",
  "processing fee"
];

function analyzeText(text) {
  const t = text.toLowerCase();
  let hits = [];

  scamPatterns.forEach(p => {
    if (t.includes(p)) hits.push(p);
  });

  return {
    isScam: hits.length >= 2,
    hits
  };
}

document.getElementById("submitEvidence").addEventListener("click", () => {
  const input = document.getElementById("evidenceInput").value.trim();
  const result = document.getElementById("result");

  if (!input) {
    result.innerText = "⚠️ Please paste something";
    result.style.color = "orange";
    return;
  }

  const analysis = analyzeText(input);

  if (analysis.isScam) {
    result.innerHTML =
      "❌ <b>Likely Scam</b><br><small>Detected: " +
      analysis.hits.join(", ") +
      "</small>";
    result.style.color = "red";
  } else {
    result.innerHTML = "✅ <b>Likely Safe</b>";
    result.style.color = "green";
  }
});
