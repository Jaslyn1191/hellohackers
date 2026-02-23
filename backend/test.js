import fetch from 'node-fetch';

async function testAI() {
  try {
    const response = await fetch('http://localhost:9000/chat', {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify({ chat: 'Hi, I have a headache and mild fever.' })
    });

    const data = await response.json();
    console.log(data);
  } catch (err) {
    console.error("Error:", err);
  }
}

testAI();
