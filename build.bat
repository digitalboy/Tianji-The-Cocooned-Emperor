@echo off
REM This script uses pandoc to convert the markdown chapters into an EPUB file.
REM Make sure pandoc is installed and in your system's PATH.

echo "Starting EPUB conversion..."

set CHAPTERS=^
 title.md ^
 草稿\第一章-冗余代码.md ^
 草稿\第二章-信噪比.md ^
 草稿\第三章-噪音与尘埃.md ^
 草稿\第四章-阴影中的猎犬.md ^
 草稿\第五章-数据之影.md ^
 草稿\第六章-决裂.md ^
 草稿\第七章-诱饵.md ^
 草稿\第八章-手术.md ^
 草稿\第九章-幽灵偏移.md ^
 草稿\第十章-策反.md ^
 草稿\第十一章-遥远的战场.md ^
 草稿\第十二章-寂静的尖叫.md ^
 草稿\第十三章-数字盗墓.md ^
 草稿\第十四章-真相的洪水.md ^
 草稿\第十五章-谎言的崩塌.md ^
 草稿\最终章-最后一个补丁.md

pandoc --from=markdown -t epub3 -o 天机.epub --metadata-file=metadata.yaml --toc --toc-depth=1 --split-level=3 --lua-filter=wikilinks.lua %CHAPTERS%


if errorlevel 1 (
    echo "Pandoc failed to create the EPUB file. Please check if pandoc is installed and in your PATH."
    exit /b 1
)

echo "EPUB '天机.epub' has been created successfully."