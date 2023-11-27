@echo off

:Start
cls
echo.
echo ��Ƭ����ű� v1.0.1
echo �ֿ⣺https://github.com/Switernal/SortPhotos
echo.
echo ����ر�֤�ļ���������ʽΪ"YYYY-MM-dd"��ͷ�����ڸ�ʽ��
echo.
set /p "work_dir=������ƬĿ¼������ֱ����ק�ļ������˴��ڣ�: "

REM �ж��Ƿ���Ŀ¼����
if "%work_dir%"=="" (
    echo.
    echo ��ƬĿ¼Ϊ��!
    echo.
    echo ������������ƬĿ¼
    echo.
    pause
    goto Start
) else (
    echo.
    echo ��ǰ����Ŀ¼: %work_dir%
)

REM ��ȡ������Ϣ
for /f "delims=" %%a in ('echo %work_dir%') do set "category_name=%%~nxa"
set "date=%category_name:~0,10%"
echo ��ǰ��������: %date%
echo.

REM ��ʼ��������
set /a num_of_JPEGs=0
set /a num_of_RAWs=0
set /a num_of_Videos=0

echo ������־:
echo.

REM ѭ�������ļ����е��ļ�
for %%i in ("%work_dir%\*") do (

    REM ����JPEG�ļ�
    if /i "%%~xi"==".jpg" (
        call :ProcessFile "%%i" %date%_JPEG-Origin jpg
    ) else if /i "%%~xi"==".jpeg" (
        call :ProcessFile "%%i" %date%_JPEG-Origin jpeg
    )

    REM ������Ƶ�ļ�
    if /i "%%~xi"==".mp4" (
        call :ProcessFile "%%i" %date%_Video-Origin mp4
    ) else if /i "%%~xi"==".mov" (
        call :ProcessFile "%%i" %date%_Video-Origin mov
    )

    REM ����RAW�ļ�
    if /i "%%~xi"==".nef" (
        call :ProcessFile "%%i" %date%_RAW nef
    ) else if /i "%%~xi"==".dng" (
        call :ProcessFile "%%i" %date%_RAW dng
    ) else if /i "%%~xi"==".raf" (
        call :ProcessFile "%%i" %date%_RAW raf
    ) else if /i "%%~xi"==".crw" (
        call :ProcessFile "%%i" %date%_RAW crw
    ) else if /i "%%~xi"==".cr2" (
        call :ProcessFile "%%i" %date%_RAW cr2
    ) else if /i "%%~xi"==".cr3" (
        call :ProcessFile "%%i" %date%_RAW cr3
    ) else if /i "%%~xi"==".orf" (
        call :ProcessFile "%%i" %date%_RAW orf
    ) else if /i "%%~xi"==".arw" (
        call :ProcessFile "%%i" %date%_RAW arw
    ) else if /i "%%~xi"==".rw2" (
        call :ProcessFile "%%i" %date%_RAW rw2
    ) else if /i "%%~xi"==".x3f" (
        call :ProcessFile "%%i" %date%_RAW x3f
    ) else if /i "%%~xi"==".ptx" (
        call :ProcessFile "%%i" %date%_RAW ptx
    ) else if /i "%%~xi"==".pef" (
        call :ProcessFile "%%i" %date%_RAW pef
    )
   REM ����б��RAW��ʽ�����������if else׷��

)

echo.
echo �ɹ��ƶ� JPG �ļ�: %num_of_JPEGs% ��
echo �ɹ��ƶ� RAW �ļ�: %num_of_RAWs% ��
echo �ɹ��ƶ� ��Ƶ �ļ�: %num_of_Videos% ��
echo.

REM ����������ļ���
if not exist "%work_dir%\%date%_JPEG-Edit\" mkdir "%work_dir%\%date%_JPEG-Edit"
if not exist "%work_dir%\%date%_JPEG-Share\" mkdir "%work_dir%\%date%_JPEG-Share"
if not exist "%work_dir%\%date%_JPEG-Watermark\" mkdir "%work_dir%\%date%_JPEG-Watermark"

echo ���δ�����������������ʼ��һ������
echo ��ϣ���������У���ֱ�ӹرմ���
echo.
pause

goto Start

:ProcessFile
set "file_path=%~1"
set "target_dir=%work_dir%\%~2"
set "file_type=%~3"

if not exist "%target_dir%\" mkdir "%target_dir%"
move /Y "%file_path%" "%target_dir%\"
if not errorlevel 1 (
    echo %~nx1 �ɹ��ƶ��� %~2
    if "%file_type%"=="jpg" (
        set /a num_of_JPEGs+=1
    ) else if "%file_type%"=="jpeg" (
        set /a num_of_JPEGs+=1
    ) else if "%file_type%"=="mp4" (
        set /a num_of_Videos+=1
    ) else if "%file_type%"=="mov" (
        set /a num_of_Videos+=1
    ) else (
        set /a num_of_RAWs+=1
    )
)
goto :eof
