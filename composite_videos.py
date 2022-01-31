import os
import re
from shutil import copy
import subprocess as sp
from os.path import join

from scipy.io import loadmat


def extract_strings(x):
    tmp = x.flatten()
    out = []
    for tr in tmp:
        out.append([el[0] for el in tr])

    return out

paths = {}

for group in ['Group' + str(i) for i in range(1, 4)]:

    paths[group] = {}
    paths[group]['material'] = []

    group_fname = group + '.mat'
    group_base_path = join('stimuli', group)

    os.makedirs(join(group_base_path, 'material'), exist_ok=True)
    os.makedirs(join(group_base_path, 'shape'), exist_ok=True)

    group_trials = loadmat(join('matlab_stim_files', group_fname))

    material_trials = group_trials['matStim']

    for trial in extract_strings(material_trials):
        # a_or_b = re.findall('[A-Z][^A-Z]*', trial[3])[1][0]
        # print(trial)
        stim_name = trial[0] + '_' + trial[1] + '.mp4'

        # args 2 3 4 are stimuli filenames
        cmd = [
            'bash',
            'composite_videos.sh',
            join(group_base_path, 'material', stim_name),
            trial[2],
            trial[3],
            trial[4],
        ]


        # print(' '.join(cmd))
        # sp.call(cmd)
        paths[group]['material'].append(join(group_base_path, 'material', stim_name))


    paths[group]['shape'] = []
    shape_trials = group_trials['shapeStim']

    for trial in extract_strings(shape_trials):
        # print(trial)

        a_or_b = re.findall('[A-Z][^A-Z]*', trial[3])[1][0]

        folder = trial[0] + '_' + trial[1] + a_or_b
        stim_name = folder + '.mp4'
        os.makedirs(join(group_base_path, 'shape', folder), exist_ok=True)
        # copy(join('videos', trial[2]), join(group_base_path, 'shape', folder, stim_name))
        # copy(join('videos', trial[3]), join(group_base_path, 'shape', folder, trial[3]))
        # copy(join('videos', trial[4]), join(group_base_path, 'shape', folder, trial[4]))

        paths[group]['shape'].append([join(group_base_path, 'shape', folder, stim_name),
                                      join(group_base_path, 'shape', folder, trial[3]),
                                      join(group_base_path, 'shape', folder, trial[4])])
