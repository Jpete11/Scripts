#!/bin/bash

# --- CONFIGURATION ---
SCREEN_NAME="minecraft"          # The name of your screen session
SERVICE_PATH="/home/user/mc"    # The path to your Minecraft folder
JAR_FILE="server.jar"           # The name of your server jar
RAM="4G"                        # Amount of RAM to allocate
# ---------------------

# 1. Alert players and save the world
screen -S $SCREEN_NAME -X stuff "say Server restarting in 5 seconds! $(printf '\r')"
sleep 5
screen -S $SCREEN_NAME -X stuff "save-all$(printf '\r')"
screen -S $SCREEN_NAME -X stuff "stop$(printf '\r')"

# 2. Wait for the process to actually close
echo "Waiting for server to shut down..."
while ps aux | grep -v grep | grep -q "$JAR_FILE"; do
    sleep 1
done

# 3. Restart the server inside the screen
echo "Restarting..."
cd $SERVICE_PATH
screen -S $SCREEN_NAME -X stuff "java -Xmx$RAM -Xms$RAM -jar $JAR_FILE nogui$(printf '\r')"

echo "Restart command sent to screen '$SCREEN_NAME'."
