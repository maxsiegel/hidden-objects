# for f in videos/*.png
for f in ~/Downloads/*.png
do
    echo $f
    OUT_NAME=$(basename $f .png)
    ffmpeg -y -loop 1 -t 5 -i $f -shortest ${OUT_NAME}_temp.mp4
    ffmpeg -y -i ${OUT_NAME}_temp.mp4 -filter_complex "tpad=stop_duration=00:00:00.05" $OUT_NAME.mp4
    # ffmpeg -y -loop 1 -t 5 -i $f -pix_fmt yuv420p videos/$(basename $f .png).mp4 &
    # ffmpeg -y -loop 1 -t 5 -i $f c:v libx264 videos/$(basename $f .png).mp4 &
done

wait
