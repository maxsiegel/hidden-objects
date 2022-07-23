import os
from os.path import join

from scipy.io import loadmat

for group in ['Group' + str(i) for i in range(1, 4)]:
    group_fname = group + '.mat'
    group_trials = loadmat(join('matlab_stim_files_exp1_rerun', group_fname))

    for trial in group_trials['matStim'][0]:
        folder = trial[0]
        video = trial[2]

        video_path = join('~/Dropbox (MIT)/stimuli', folder[0], video[0])
        print(path)
