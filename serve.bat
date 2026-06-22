@echo off
cd /d "%~dp0"
echo ============================================================
echo   Glass Archive - style-library local preview
echo ============================================================
echo.
echo   Opening http://localhost:8000 in your browser.
echo   Keep this window open; close it to stop the server.
echo   If the page can't connect, wait a second and refresh.
echo.
start "" http://localhost:8000
py -m http.server 8000 2>nul || python -m http.server 8000 2>nul || npx --yes serve -l 8000
echo.
echo Server stopped (or neither Python nor Node was found).
echo If nothing opened: install Python from python.org, then double-click this again.
pause
