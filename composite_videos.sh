OUT_FNAME=$1

echo $OUT_FNAME

mkdir temp
ffmpeg -loglevel error -hide_banner -y -i videosInvisbleBackground/$2 -filter_complex 'pad=w=10+iw:h=10+ih:x=5:y=5:color=white' -c:v libx264 -preset veryslow -crf 0 temp/horizontal_border.mp4
ffmpeg -loglevel error -hide_banner -y -i temp/horizontal_border.mp4 -filter_complex 'pad=1620:620:420:00' -c:v libx264 -preset veryslow -crf 0 temp/horizontal_border_padded.mp4
ffmpeg -loglevel error -hide_banner -y -i temp/horizontal_border_padded.mp4 -filter_complex 'tpad=stop_duration=10' -c:v libx264 -preset veryslow -crf 0 temp/horizontal_border_and_time_padded.mp4


ffmpeg -loglevel error -hide_banner -y -i videosInvisbleBackground/$3 -filter_complex 'pad=w=10+iw:h=10+ih:x=5:y=5:color=white' -c:v libx264 -preset veryslow -crf 0 temp/horizontal_border.mp4
ffmpeg -loglevel error -hide_banner -y -i temp/horizontal_border.mp4 -filter_complex 'tpad=start_duration=5' -c:v libx264 -preset veryslow -crf 0 temp/time_border_padded_temp_A.mp4
ffmpeg -loglevel error -hide_banner -y -i temp/time_border_padded_temp_A.mp4 -filter_complex 'tpad=stop_duration=5' -c:v libx264 -preset veryslow -crf 0 temp/time_border_padded_A.mp4
# ffmpeg -loglevel error -hide_banner -y -i temp/time_border_padded_temp_A.mp4 -c:v libx264 -preset veryslow -crf 0 temp/time_border_padded_A.mp4

ffmpeg -loglevel error -hide_banner -y -i videosInvisbleBackground/$4 -filter_complex 'pad=w=10+iw:h=10+ih:x=5:y=5:color=white' -c:v libx264 -preset veryslow -crf 0 temp/horizontal_border.mp4
# ffmpeg -loglevel error -hide_banner -y -i temp/horizontal_border.mp4 -filter_complex 'tpad=start_duration=5' -c:v libx264 -preset veryslow -crf 0 temp/time_border_padded_B.mp4
ffmpeg -loglevel error -hide_banner -y -i temp/horizontal_border.mp4 -filter_complex 'tpad=start_duration=10' -c:v libx264 -preset veryslow -crf 0 temp/time_border_padded_B.mp4

ffmpeg -loglevel error -hide_banner -y -i temp/horizontal_border_and_time_padded.mp4 -hide_banner -i temp/time_border_padded_A.mp4 -hide_banner -i temp/time_border_padded_B.mp4 -filter_complex "[1][2]hstack=inputs=2[p2];[0][p2]vstack=inputs=2" -vsync 2 -c:v libx264 -preset veryslow -crf 0 $OUT_FNAME

# echo $OUT_FNAME
# # rm temp/*

# ffmpeg -loglevel error -hide_banner -y -i videosInvisbleBackground/$2 -filter_complex 'pad=w=10+iw:h=10+ih:x=5:y=5:color=white' temp/horizontal_border.mp4
# ffmpeg -loglevel error -hide_banner -y -i temp/horizontal_border.mp4 -filter_complex 'pad=1620:620:420:00' temp/horizontal_border_padded.mp4
# ffmpeg -loglevel error -hide_banner -y -i temp/horizontal_border_padded.mp4 -filter_complex 'tpad=stop_duration=10' temp/horizontal_border_and_time_padded.mp4


# ffmpeg -loglevel error -hide_banner -y -i videosInvisbleBackground/$3 -filter_complex 'pad=w=10+iw:h=10+ih:x=5:y=5:color=white' temp/horizontal_border.mp4

# ffmpeg -loglevel error -hide_banner -y -i temp/horizontal_border.mp4 -filter_complex 'tpad=start_duration=5' temp/time_border_padded_temp_A.mp4
# ffmpeg -loglevel error -hide_banner -y -i temp/time_border_padded_temp_A.mp4 -filter_complex 'tpad=stop_duration=5' temp/time_border_padded_A.mp4

# ffmpeg -loglevel error -hide_banner -y -i videosInvisbleBackground/$4 -filter_complex 'pad=w=10+iw:h=10+ih:x=5:y=5:color=white' temp/horizontal_border.mp4
# ffmpeg -loglevel error -hide_banner -y -i temp/horizontal_border.mp4 -filter_complex 'tpad=start_duration=10' temp/time_border_padded_B.mp4

# ffmpeg -loglevel error -hide_banner -y -i temp/horizontal_border_and_time_padded.mp4 -hide_banner -i temp/time_border_padded_A.mp4 -hide_banner -i temp/time_border_padded_B.mp4 -filter_complex "[1][2]hstack=inputs=2[p2];[0][p2]vstack=inputs=2" -vsync 2 $OUT_FNAME
