#!/bin/bash
# 星玦 Gifv 動圖

#--
# 使用方式：
#   $ ./gifvStarJue.sh
#
# 依賴：
#   * `ffmpeg`
#--


##shStyle ###



##shStyle 函式庫


fnReplace() {
    local originalText="$1"; shift
    local arguList=("" "$@")

    local key val grepRemain
    local ansTxt=$originalText
    local regexKey='{{argu-\([0-9]*\)}}'

    while [ -n "y" ]
    do
        grepRemain=`grep -o "$regexKey" <<< "$ansTxt"`

        [ -z "$grepRemain" ] && break

        key=`sed -n "1p" <<< "$grepRemain" | sed "s/$regexKey/\1/"`
        val=${arguList[$key]}

        while [ -n "y" ]
        do
            ansTxt="${ansTxt/\{\{argu-$key\}\}/$val}"
            [ -z "`grep -o "{{argu-$key}}" <<< "$ansTxt"`" ] && break
        done
    done

    echo "$ansTxt"
}


##shStyle ###


# 設定

conf_toDirname="./toImg_gitv"
conf_concatFilename="./concat.ffmpeg"
# 不行加 "./"
conf_fromDirname="toImg_compress"
conf_fileName="template_starJue"
conf_templateConcat="
file ${conf_fromDirname}/${conf_fileName}{{argu-1}}_green_gray_{{argu-2}}.jpg
file ${conf_fromDirname}/${conf_fileName}{{argu-1}}_green_light_{{argu-2}}.jpg
file ${conf_fromDirname}/${conf_fileName}{{argu-1}}_orange_gray_{{argu-2}}.jpg
file ${conf_fromDirname}/${conf_fileName}{{argu-1}}_orange_light_{{argu-2}}.jpg
file ${conf_fromDirname}/${conf_fileName}{{argu-1}}_purple_gray_{{argu-2}}.jpg
file ${conf_fromDirname}/${conf_fileName}{{argu-1}}_purple_light_{{argu-2}}.jpg
file ${conf_fromDirname}/${conf_fileName}{{argu-1}}_red_gray_{{argu-2}}.jpg
file ${conf_fromDirname}/${conf_fileName}{{argu-1}}_red_light_{{argu-2}}.jpg
"
conf_argu1List=(
    ""
    "-dev"
)
conf_argu2List=(
    "64x64"
    "192x192"
    "310x150"
    "512x512"
)


fnFfmpeg() {
    local idxArgu1 argu1
    local idxArgu2 argu2

    for idxArgu1 in `seq 0 $((${#conf_argu1List[@]} - 1))`
    do
        argu1=${conf_argu1List[$idxArgu1]}

        for idxArgu2 in `seq 0 $((${#conf_argu2List[@]} - 1))`
        do
            argu2=${conf_argu2List[$idxArgu2]}
            fnReplace "$conf_templateConcat" "$argu1" "$argu2" > "$conf_concatFilename"
            newFilename="${conf_toDirname}/${conf_fileName}${argu1}_${argu2}.mp4"
            ffmpeg -f concat -i "$conf_concatFilename" \
                -an -c:v libx264 -vf "setpts=6*PTS" "$newFilename"
        done
    done
}

[ ! -d "$conf_toDirname" ] && mkdir "$conf_toDirname"

fnFfmpeg

[ ! -f "$conf_concatFilename" ] && rm "$conf_concatFilename"

