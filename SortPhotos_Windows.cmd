@echo off

:Start
cls
echo.
echo 照片分类脚本 v1.0.1
echo 仓库：https://github.com/Switernal/SortPhotos
echo.
echo 请务必保证文件夹命名格式为"YYYY-MM-dd"开头（日期格式）
echo.
set /p "work_dir=输入照片目录（可以直接拖拽文件夹至此窗口）: "

REM 判断是否传入目录参数
if "%work_dir%"=="" (
    echo.
    echo 照片目录为空!
    echo.
    echo 请重新输入照片目录
    echo.
    pause
    goto Start
) else (
    echo.
    echo 当前处理目录: %work_dir%
)

REM 获取日期信息
for /f "delims=" %%a in ('echo %work_dir%') do set "category_name=%%~nxa"
set "date=%category_name:~0,10%"
echo 当前处理日期: %date%
echo.

REM 初始化计数器
set /a num_of_JPEGs=0
set /a num_of_RAWs=0
set /a num_of_Videos=0

echo 分类日志:
echo.

REM 循环处理文件夹中的文件
for %%i in ("%work_dir%\*") do (

    REM 处理JPEG文件
    if /i "%%~xi"==".jpg" (
        call :ProcessFile "%%i" %date%_JPEG-Origin jpg
    ) else if /i "%%~xi"==".jpeg" (
        call :ProcessFile "%%i" %date%_JPEG-Origin jpeg
    )

    REM 处理视频文件
    if /i "%%~xi"==".mp4" (
        call :ProcessFile "%%i" %date%_Video-Origin mp4
    ) else if /i "%%~xi"==".mov" (
        call :ProcessFile "%%i" %date%_Video-Origin mov
    )

    REM 处理RAW文件
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
   REM 如果有别的RAW格式，可以在这边if else追加

)

echo.
echo 成功移动 JPG 文件: %num_of_JPEGs% 个
echo 成功移动 RAW 文件: %num_of_RAWs% 个
echo 成功移动 视频 文件: %num_of_Videos% 个
echo.

REM 创建额外的文件夹
if not exist "%work_dir%\%date%_JPEG-Edit\" mkdir "%work_dir%\%date%_JPEG-Edit"
if not exist "%work_dir%\%date%_JPEG-Share\" mkdir "%work_dir%\%date%_JPEG-Share"
if not exist "%work_dir%\%date%_JPEG-Watermark\" mkdir "%work_dir%\%date%_JPEG-Watermark"

echo 本次处理结束，按任意键开始下一次运行
echo 若希望结束运行，请直接关闭窗口
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
    echo %~nx1 成功移动到 %~2
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
