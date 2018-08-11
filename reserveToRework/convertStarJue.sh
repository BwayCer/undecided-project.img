#!/bin/bash
# 星玦轉檔

#--
# 使用方式：
#   $ ./convertStarJue.sh
#
# 依賴：
#   * `inkscape` (`pacman -S inkscape`)
#   * `convert`  (`pacman -S imagemagick`)
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

conf_dirname="./toImg"
conf_tmpFilename="./convertStarJue.tmp"
conf_templateFilename=(
    "./template_starJue.svg"
    "./template_starJue-dev.svg"
)
conf_sizeList=(
    "32x32"
    "64x64"
    "70x70"
    "128x128"
    "150x150"
    "192x192"
    "256x256"
    "310x150"
    "310x310"
    "512x512"
)

[ ! -d "$conf_dirname" ] && mkdir "$conf_dirname"

template=()

fnReadTemplate() {
    local filename content

    for filename in "${conf_templateFilename[@]}"
    do
        content=`cat "$filename"`
        [ -z "$content" ] && continue
        template[${#template[@]}]=$content
    done
}


fnConvert() {
    local contentType="$fnConvert_contentType"
    local aboutName="$fnConvert_aboutName"
    local sizeList=("${fnConvert_sizeList[@]}")
    local arguList=("${fnConvert_arguList[@]}")

    local idxTemplate content
    local idxSize size width height
    local fileName extension prefixName tmpFilename newFilename

    for idxTemplate in `seq 0 $((${#template[@]} - 1))`
    do
        fileName=`basename ${conf_templateFilename[$idxTemplate]}`
        extension=${fileName##*.}
        prefixName=${fileName%.*}
        [ -n "$aboutName" ] && prefixName+="_$aboutName"

        tmpFilename="${conf_tmpFilename}.${extension}"

        content=${template[$idxTemplate]}
        content=`fnReplace "$content" "${arguList[@]}"`

        echo "$content" > "$tmpFilename"

        for idxSize in `seq 0 $((${#sizeList[@]} - 1))`
        do
            size=${sizeList[$idxSize]}
            width=`cut -d "x" -f 1 <<< "$size"`
            height=`cut -d "x" -f 2 <<< "$size"`

            newFilename="${conf_dirname}/${prefixName}_${size}.${contentType}"

            case "$contentType" in
                jpg )
                    # size `WxH!` 可取消原圖長寬比限制 強制變形
                    convert -density 3000 -resize "${size}!" "$tmpFilename" "$newFilename"
                    ;;
                png )
                    inkscape -z -e "$newFilename" -w "$width" -h "$height" "$tmpFilename"
                    ;;
            esac
        done
    done
}
# fnConvert_contentType=""
# fnConvert_aboutName=""
# fnConvert_sizeList=()
# fnConvert_arguList=()


fnReadTemplate


#
# Convert purple
#

fnConvert_aboutName="purple_gray"
fnConvert_sizeList=("${conf_sizeList[@]}")
fnConvert_arguList=(
    "0 0 32 32"
    "0 0 36 36"
    "#9673A6"
)
fnConvert_contentType="jpg"
fnConvert
fnConvert_contentType="png"
fnConvert

fnConvert_aboutName="purple_light"
fnConvert_sizeList=("${conf_sizeList[@]}")
fnConvert_arguList=(
    "0 0 32 32"
    "0 0 36 36"
    "#7719AA"
)
fnConvert_contentType="jpg"
fnConvert
fnConvert_contentType="png"
fnConvert


#
# Convert red
#

fnConvert_aboutName="red_gray"
fnConvert_sizeList=("${conf_sizeList[@]}")
fnConvert_arguList=(
    "0 0 32 32"
    "0 0 36 36"
    "#D993AD"
)
fnConvert_contentType="jpg"
fnConvert
fnConvert_contentType="png"
fnConvert

fnConvert_aboutName="red_light"
fnConvert_sizeList=("${conf_sizeList[@]}")
fnConvert_arguList=(
    "0 0 32 32"
    "0 0 36 36"
    "#ED008C"
)
fnConvert_contentType="jpg"
fnConvert
fnConvert_contentType="png"
fnConvert


#
# Convert orange
#

fnConvert_aboutName="orange_gray"
fnConvert_sizeList=("${conf_sizeList[@]}")
fnConvert_arguList=(
    "0 0 32 32"
    "0 0 36 36"
    "#EFBE66"
)
fnConvert_contentType="jpg"
fnConvert
fnConvert_contentType="png"
fnConvert

fnConvert_aboutName="orange_light"
fnConvert_sizeList=("${conf_sizeList[@]}")
fnConvert_arguList=(
    "0 0 32 32"
    "0 0 36 36"
    "#FFA500"
)
fnConvert_contentType="jpg"
fnConvert
fnConvert_contentType="png"
fnConvert


#
# Convert green
#

fnConvert_aboutName="green_gray"
fnConvert_sizeList=("${conf_sizeList[@]}")
fnConvert_arguList=(
    "0 0 32 32"
    "0 0 36 36"
    "#BCD676"
)
fnConvert_contentType="jpg"
fnConvert
fnConvert_contentType="png"
fnConvert

fnConvert_aboutName="green_light"
fnConvert_sizeList=("${conf_sizeList[@]}")
fnConvert_arguList=(
    "0 0 32 32"
    "0 0 36 36"
    "#2BAF2B"
)
fnConvert_contentType="jpg"
fnConvert
fnConvert_contentType="png"
fnConvert

