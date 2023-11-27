# 照片自动分类脚本

参考B站up主“摄影师EDI”的照片分类方法，将拍摄的照片和视频先使用 Lightroom 按日期导入到文件夹中，然后运行脚本，输入日期文件夹目录，即可将文件夹中的文件按照 JPEG、RAW、MP4 等格式的文件进行分类。

最终分类效果如下：

（如果目录中没有对应类型的文件，如JPEG或视频类型，则不会生成 JPEG_Origin, Video-Origin 等文件夹）

```
路径：../2023/2023-01-01
  - 2023-01-01_JPEG-Origin
  - 2023-01-01_RAW
  - 2023-01-01_Video-Origin
  - 2023-01-01_JPEG-Edit
  - 2023-01-01_JPEG-Share
  - 2023-01-01_JPEG-Watermark
```

文件夹说明：

`_JPEG-Edit`：修过后的原图导出的JPEG，质量和分辨率最高

`_JPEG-Share`：修过后的原图导出的JPEG，供朋友圈、社交媒体分享，分辨率和质量较低一些

`_JPEG-Watermark`：修过后的原图导出的JPEG，出于保护或声明版权的目的，添加过水印的文件

以上几种类型可以再Lightroom中添加导出预设，具体细节请看：

[b站](//player.bilibili.com/player.html?aid=246652146&bvid=BV1uv411v7Qe&cid=298218138&p=1 ':include :type=iframe width=100% height=400px')


脚本个人自用, 此仓库仅作为备份使用。如果有其他需求或是建议也欢迎在 Issues 中一起讨论。

如果有其它需求，也可以直接在脚本上改，比如脚本中没有的其他的RAW文件类型。

初学摄影，求个大佬带带。

# 使用方法

## Windows

直接双击运行 `SortPhotos_Windows.cmd` 文件后根据提示操作

## macOS

直接双击运行 `SortPhotos_macOS.command` 文件后根据提示操作

## Linux

使用 `sh` 命令在终端执行 `SortPhotos_Linux.sh` 文件

输入sh命令后，紧跟着输入日期文件夹目录作为参数。

如果不带参数是无法执行的
