const API_KEY = "COLOQUE_SUA_GROQ_KEY";

async function generateWorkout() {
  document.getElementById("output").innerText = "Gerando...";

  const prompt = `
  Crie um treino ABC de musculação com:
  - divisão semanal
  - exercícios reais
  - séries e repetições
  `;

  const res = await fetch("https://api.groq.com/openai/v1/chat/completions", {
    method: "POST",
    headers: {
      "Authorization": "Bearer " + API_KEY,
      "Content-Type": "application/json"
    },
    body: JSON.stringify({
      model: "llama3-70b-8192",
      messages: [{ role: "user", content: prompt }]
    })
  });

  const data = await res.json();
  document.getElementById("output").innerText =
    data.choices[0].message.content;
}

// registrar service worker
if ("serviceWorker" in navigator) {
  navigator.serviceWorker.register("sw.js");
}
