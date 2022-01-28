
ffmpeg -i videos/boxA_camA_liquidA.mp4 -filter_complex 'pad=1120:420:280:0' videos/padded.mp4
ffmpeg -i videos/padded.mp4 -i videos/boxA_camA_liquidA.mp4 -i videos/boxB_camB_liquidB.mp4 -filter_complex "[1]tpad=start_mode=clone:start_duration=5[tr];[1][2]hstack=inputs=2[p2];[0][p2]vstack=inputs=2" videos/composite.mp4
