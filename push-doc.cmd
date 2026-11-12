@echo off
rem Пуш обновлённой документации в GitHub.
rem Публикуется ТОЛЬКО info.html (публичная версия).
rem info.txt - внутренняя полная версия, в репозиторий не попадает
rem (исключён через .gitignore).
rem Запуск: push-doc.cmd ["текст коммита"]  (без аргумента - авто-текст)
setlocal
cd /d "%~dp0"
set "MSG=%~1"
if "%MSG%"=="" set "MSG=doc update %date%"
rem сайт GitHub Pages открывается с index.html - держим его копией info.html
copy /Y info.html index.html >NUL
git add -A
git diff --cached --quiet
if errorlevel 1 (
    git commit -m "%MSG%"
) else (
    echo Изменений нет - пушить нечего.
    goto :eof
)
git push
if errorlevel 1 (
    echo ОШИБКА push - проверь интернет/авторизацию gh.
) else (
    echo Готово: https://github.com/Rosheg/rp-tgbot-doc
)
endlocal
