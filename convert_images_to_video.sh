for f in videos/*.png
do
    echo $f
    ffmpeg -y -loop 1 -t 5 -i $f -shortest videos/$(basename $f .png).mp4 &
    # ffmpeg -y -loop 1 -t 5 -i $f -pix_fmt yuv420p videos/$(basename $f .png).mp4 &
    # ffmpeg -y -loop 1 -t 5 -i $f c:v libx264 videos/$(basename $f .png).mp4 &
done

wait
