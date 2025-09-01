from flask import Flask, jsonify
import os

app = Flask(__name__)

# --- Mock telemetry (replace with real data wiring) ---
STATE = {
    "speed_mps": 12.3,
    "cones": [
        {"x": 3.2, "y": 1.1, "color": "blue"},
        {"x": 6.8, "y": -0.7, "color": "yellow"},
    ],
}

@app.get("/")
def index():
    host = os.getenv("HOSTNAME", "unknown")
    return f"FS Telemetry running on {host}"

@app.get("/telemetry")
def telemetry():
    return jsonify(STATE)

@app.get("/status")
def status():
    return jsonify({"status": "ok"})

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000)
