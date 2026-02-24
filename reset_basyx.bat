@echo off
echo ==========================================
echo       FULL BaSyx RESET (Mongo wipe)
echo ==========================================

REM === STEP 1+2: STOP STACK AND DELETE VOLUMES ===
echo Stopping BaSyx stack and deleting volumes (ALL AAS WILL BE LOST)...
docker compose down -v --remove-orphans
echo Stack stopped and volumes removed.

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
