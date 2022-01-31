TWICE_LEN=10

OUT_FNAME=$1

echo $OUT_FNAME

ffmpeg -hide_banner -y -i videos/$2 -filter_complex 'pad=1600:600:400:0' videos/horizontal_padded.mp4
ffmpeg -hide_banner -y -i  videos/horizontal_padded.mp4 -filter_complex 'tpad=stop_duration=10' videos/horizontal_and_time_padded.mp4

ffmpeg -hide_banner -y -i  videos/$3 -filter_complex 'tpad=start_duration=5' videos/time_padded_temp_A.mp4
ffmpeg -hide_banner -y -i  videos/time_padded_temp_A.mp4 -filter_complex 'tpad=stop_duration=5' videos/time_padded_A.mp4

# ffmpeg -hide_banner -y -i  videos/boxB_camB_liquidB.mp4 -filter_complex 'tpad=start_duration=\5' videos/time_padded_temp_B.mp4
ffmpeg -hide_banner -y -i  videos/$4 -filter_complex 'tpad=start_duration=10' videos/time_padded_B.mp4

rm videos/time_padded_temp_*

ffmpeg -hide_banner -y -i  videos/horizontal_and_time_padded.mp4 -hide_banner -y -i  videos/time_padded_A.mp4 -hide_banner -y -i  videos/time_padded_B.mp4 -filter_complex "[1][2]hstack=inputs=2[p2];[0][p2]vstack=inputs=2" $OUT_FNAME

rm videos/horizontal_padded videos/horizontal_and_time_padded.mp4 videos/time_padded_A.mp4 videos/time_padded_B.mp4
