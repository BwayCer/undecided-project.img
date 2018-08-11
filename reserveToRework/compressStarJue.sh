#!/bin/bash
# 星玦壓縮

#--
# 使用方式：
#   $ ./compressStarJue.sh
#
# 依賴：
#   * https://gist.github.com/duzun/234bd3ca69b243bb32bb
#--


##shStyle ###

# 設定

conf_fromDirname="./toImg"
conf_toDirname="./toImg_compress"
conf_compressTool="./compressTool/optimag"

[ ! -d "$conf_fromDirname" ] && exit
[ ! -d "$conf_toDirname" ] && mkdir "$conf_toDirname"

filename=""

for filename in `ls -1 "$conf_fromDirname"`
do
    sh "$conf_compressTool" "${conf_fromDirname}/${filename}" "${conf_toDirname}/${filename}"
    sleep 1.6
done

