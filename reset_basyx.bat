@echo off
echo ==========================================
echo       FULL BaSyx RESET (Mongo wipe)
echo ==========================================

REM === STEP 1: STOP ALL CONTAINERS ===
echo Stopping BaSyx containers...

docker stop aas-env >nul 2>&1
docker stop aas-ui >nul 2>&1
docker stop aas-registry >nul 2>&1
docker stop sm-registry >nul 2>&1
docker stop aas-discovery >nul 2>&1
docker stop dashboard-api >nul 2>&1
docker stop mosquitto >nul 2>&1
docker stop mongo >nul 2>&1

echo Containers stopped.

REM === STEP 2: DELETE MONGO DATA VOLUME ===
echo Deleting MongoDB volume (ALL AAS WILL BE LOST)...

docker volume rm 2443286c0e464fb67714f41e75934637e3e3939fbdb1b85aaa8fc5c1cd4e053f

echo MongoDB volume removed.

REM === STEP 3: RESTART FULL STACK ===
echo Restarting BaSyx stack...

docker compose up -d

echo Waiting for BaSyx to initialize...
timeout /t 5 >nul

echo Checking aas-env health...
docker inspect -f "{{.State.Health.Status}}" aas-env

echo ==========================================
echo        BaSyx RESET COMPLETED
echo ==========================================

pause
