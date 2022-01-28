TWICE_LEN=10

ffmpeg -i videos/boxA_camA_liquidA.mp4 -filter_complex 'pad=1120:420:280:0' videos/horizontal_padded.mp4
ffmpeg -i videos/horizontal_padded.mp4 -filter_complex 'tpad=stop_duration=10' videos/horizontal_and_time_padded.mp4

ffmpeg -i videos/boxB_camB_liquidA.mp4 -filter_complex 'tpad=start_duration=5' videos/time_padded_temp_A.mp4
ffmpeg -i videos/time_padded_temp_A.mp4 -filter_complex 'tpad=stop_duration=5' videos/time_padded_A.mp4

# ffmpeg -i videos/boxB_camB_liquidB.mp4 -filter_complex 'tpad=start_duration=\5' videos/time_padded_temp_B.mp4
ffmpeg -i videos/boxB_camB_liquidB.mp4 -filter_complex 'tpad=start_duration=10' videos/time_padded_B.mp4

rm videos/time_padded_temp_*

ffmpeg -y -i videos/horizontal_and_time_padded.mp4 -i videos/time_padded_A.mp4 -i videos/time_padded_B.mp4 -filter_complex "[1][2]hstack=inputs=2[p2];[0][p2]vstack=inputs=2" videos/composite.mp4
