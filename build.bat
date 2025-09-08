@echo off
REM Set console to UTF-8 to handle Chinese filenames correctly.
chcp 65001 > nul
REM This script uses pandoc to convert the markdown chapters into an EPUB file.
REM Make sure pandoc is installed and in your system's PATH.

echo "Starting EPUB conversion..."

pandoc --defaults=defaults.yaml --lua-filter=wikilinks.lua

if errorlevel 1 (
    echo "Pandoc failed to create the EPUB file. Please check if pandoc is installed and in your PATH."
    exit /b 1
)

echo "EPUB '天机.epub' has been created successfully."