echo "## TS to mp4 convert ##"

echo "reading folder $1 ..."

if [ -d "$1" ]; then
    echo "folder found"
else
    echo "no folder found"
    exit 1
fi

for entry in "$1"/*.ts
do
    NEW_NAME="${entry/\.ts/\.mp4}"
    if [ -f "$NEW_NAME" ]; then
        echo "$NEW_NAME exists"
    else
        # handle escape characters
        entry=$(printf '%q' "$entry")
        NEW_NAME=$(printf '%q' "$NEW_NAME")

        #CMD="ffmpeg -i \"$entry\" -acodec copy -vcodec copy \"$NEW_NAME\""
        CMD="ffmpeg -i $entry -acodec copy -vcodec copy $NEW_NAME"
        #echo $CMD
        eval $CMD

        # cleanup
        CMD_DELETE="rm $entry"
        #echo $CMD_DELETE
        eval $CMD_DELETE
    fi
done

echo "done!"
