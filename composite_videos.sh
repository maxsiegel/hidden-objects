TWICE_LEN=10

OUT_FNAME=$1

echo $OUT_FNAME

ffmpeg -hide_banner -y -i videos/$2 -filter_complex 'pad=w=10+iw:h=10+ih:x=5:y=5:color=white' temp/horizontal_border.mp4
ffmpeg -hide_banner -y -i temp/horizontal_border.mp4 -filter_complex 'pad=1620:620:420:00' temp/horizontal_border_padded.mp4
ffmpeg -hide_banner -y -i temp/horizontal_border_padded.mp4 -filter_complex 'tpad=stop_duration=10' temp/horizontal_border_and_time_padded.mp4


ffmpeg -hide_banner -y -i videos/$3 -filter_complex 'pad=w=10+iw:h=10+ih:x=5:y=5:color=white' temp/horizontal_border.mp4

ffmpeg -hide_banner -y -i temp/horizontal_border.mp4 -filter_complex 'tpad=start_duration=5' temp/time_border_padded_temp_A.mp4
ffmpeg -hide_banner -y -i temp/time_border_padded_temp_A.mp4 -filter_complex 'tpad=stop_duration=5' temp/time_border_padded_A.mp4

ffmpeg -hide_banner -y -i videos/$4 -filter_complex 'pad=w=10+iw:h=10+ih:x=5:y=5:color=white' temp/horizontal_border.mp4
ffmpeg -hide_banner -y -i temp/horizontal_border.mp4 -filter_complex 'tpad=start_duration=10' temp/time_border_padded_B.mp4

ffmpeg -hide_banner -y -i temp/horizontal_border_and_time_padded.mp4 -hide_banner -i temp/time_border_padded_A.mp4 -hide_banner -i temp/time_border_padded_B.mp4 -filter_complex "[1][2]hstack=inputs=2[p2];[0][p2]vstack=inputs=2" -vsync 2 $OUT_FNAME

echo $OUT_FNAME
# rm temp/*

ffmpeg -hide_banner -y -i videos/$2 -filter_complex 'pad=w=10+iw:h=10+ih:x=5:y=5:color=white' temp/horizontal_border.mp4
ffmpeg -hide_banner -y -i temp/horizontal_border.mp4 -filter_complex 'pad=1620:620:420:00' temp/horizontal_border_padded.mp4
ffmpeg -hide_banner -y -i temp/horizontal_border_padded.mp4 -filter_complex 'tpad=stop_duration=10' temp/horizontal_border_and_time_padded.mp4


ffmpeg -hide_banner -y -i videos/$3 -filter_complex 'pad=w=10+iw:h=10+ih:x=5:y=5:color=white' temp/horizontal_border.mp4

ffmpeg -hide_banner -y -i temp/horizontal_border.mp4 -filter_complex 'tpad=start_duration=5' temp/time_border_padded_temp_A.mp4
ffmpeg -hide_banner -y -i temp/time_border_padded_temp_A.mp4 -filter_complex 'tpad=stop_duration=5' temp/time_border_padded_A.mp4

ffmpeg -hide_banner -y -i videos/$4 -filter_complex 'pad=w=10+iw:h=10+ih:x=5:y=5:color=white' temp/horizontal_border.mp4
ffmpeg -hide_banner -y -i temp/horizontal_border.mp4 -filter_complex 'tpad=start_duration=10' temp/time_border_padded_B.mp4

ffmpeg -hide_banner -y -i temp/horizontal_border_and_time_padded.mp4 -hide_banner -i temp/time_border_padded_A.mp4 -hide_banner -i temp/time_border_padded_B.mp4 -filter_complex "[1][2]hstack=inputs=2[p2];[0][p2]vstack=inputs=2" -vsync 2 $OUT_FNAME
