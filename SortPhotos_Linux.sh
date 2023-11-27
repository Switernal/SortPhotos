echo "\n照片分类脚本 v1.0.1\n"
echo "仓库：https://github.com/Switernal/SortPhotos\n\n"

# 判断是否传入目录参数
if [ ! -n "$1" ]
then
    echo "\n参数目录为空!\n"
    echo "\n运行结束\n"
    exit
else
    echo "\n当前处理目录: "$1""
fi

category_name=`echo $1 | awk -F "/" '{print $NF}'`
date=${category_name:0:10}
echo "当前处理日期: "${date}
echo "\n"


num_of_JPEGs=0
num_of_RAWs=0
num_of_Videos=0

# 分类放置图片
echo "分类日志: \n"
for file in `ls $1`
do
    file_with_path=$1"/"$file # 带路径的文件
    
    if [ -f $file_with_path ]
    then
        case ${file##*.} in
            "JPG"|"JPEG"|"jpg"|"jpeg")
                # 如果JPEG-Origin目录不存在, 则创建
                if [ ! -d "$1/${date}_JPEG-Origin" ]; then
                    mkdir "$1/${date}_JPEG-Origin"
                fi
                # 执行mv, 如果成功返回结果
                if mv -v -n $file_with_path "$1/${date}_JPEG-Origin" | grep -q .; then
                    echo "$file 成功移动到 ${date}_JPEG-Origin"
                    ((num_of_JPEGs++))
                fi
                
            ;;
            "MP4"|"mp4"|"MOV"|"mov")
                # 如果Video-Origin目录不存在, 则创建
                if [ ! -d "$1/${date}_Video-Origin" ];
                then
                    mkdir "$1/${date}_Video-Origin"
                fi
                # 执行mv, 如果成功返回结果
                if mv -v -n "$file_with_path" "$1/${date}_Video-Origin" | grep -q .; then
                    echo "$file 成功移动到 ${date}_Video-Origin"
                    ((num_of_Videos++))
                fi
                
            ;;
            "NEF"|"DNG"|"RAF"|"CRW"|"CR2"|"CR3"|"ORF"|"ARW"|"RW2"|"X3F"|"PTX"|"PEF")
                # 如果RAW目录不存在, 则创建
                if [ ! -d "$1/${date}_RAW" ];
                then
                    mkdir "$1/${date}_RAW"
                fi
                # 执行mv, 如果成功返回结果
                if mv -v -n "$file_with_path" "$1/${date}_RAW" | grep -q .; then
                    echo "$file 成功移动到 ${date}_RAW"
                    ((num_of_RAWs++))
                fi
                
	    ;;
        esac
    fi
done

echo "\n"
echo "成功移动 JPG 文件: $num_of_JPEGs 个"
echo "成功移动 RAW 文件: $num_of_RAWs 个"
echo "成功移动 视频 文件: $num_of_Videos 个"
echo "\n"

# 修改后的文件夹
mkdir "$1/${date}_JPEG-Edit"
mkdir "$1/${date}_JPEG-Share"
mkdir "$1/${date}_JPEG-Watermark"

echo "\n运行结束\n"
