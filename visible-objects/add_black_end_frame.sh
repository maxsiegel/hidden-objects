# for i in $(seq 1 3)
# do
    # for f in stimuli/Group$i/material/*
    # do
    #     ffmpeg -hide_banner  -y -i $f -filter_complex 'tpad=stop=1' stimuli/Group$i/shape/$(basename $f .mp4)_fixed.mp4
    #     mv stimuli/Group$i/shape/$(basename $f .mp4)_fixed.mp4 stimuli/Group$i/shape/$(basename $f .mp4).mp4
    # done
    # for f in stimuli/Group$i/shape/*
    # do
    #     # ffmpeg -hide_banner  -y -i $f -filter_complex 'tpad=stop=1' stimuli/Group$i/material/$(basename $f .mp4)_fixed.mp4
    #     mv stimuli/Group$i/material/$(basename $f .mp4)_fixed.mp4 stimuli/Group$i/material/$(basename $f .mp4).mp4
    # done
# done

for f in instructions/*.mp4
do
    ffmpeg -hide_banner  -y -i $f -filter_complex 'tpad=stop=1' instructions/$(basename $f .mp4)_fixed.mp4
    mv instructions/$(basename $f .mp4)_fixed.mp4 instructions/$(basename $f .mp4).mp4
done
