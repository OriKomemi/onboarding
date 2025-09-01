import time
import os

if __name__ == "__main__":
    while True:
        print("🏎️ logging telemetry...", os.getenv("SERVICE_NAME", "logger"))
        time.sleep(5)
