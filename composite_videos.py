import os
from numpy.random import binomial
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

        if binomial(1, .5):
            trial[3] = trial[3].replace('png', 'mp4')
            trial[4] = trial[4].replace('png', 'mp4')
        else:
            tmp = trial[3]
            trial[3] = trial[4].replace('png', 'mp4')
            trial[4] = tmp.replace('png', 'mp4')

        # stim_name = trial[0] + '_' + trial[1] + '.mp4'
        stim_name = trial[2].split('.')[0] + '__' + trial[3].split('.')[0] + '__' + trial[4].split('.')[0] + '.mp4'
        # args 2 3 4 are stimuli filenames
        cmd = [
            'bash',
            'composite_videos.sh',
            join(group_base_path, 'material', stim_name),
            trial[2],
            trial[3],
            trial[4],
        ]

        sp.call(cmd)
        paths[group]['material'].append(join(group_base_path, 'material', stim_name))


    paths[group]['shape'] = []
    shape_trials = group_trials['shapeStim']

    for trial in extract_strings(shape_trials):
        # print(trial)
        # import pdb; pdb.set_trace()

        a_or_b = re.findall('[A-B][^A-B]*', trial[3])[1][0]

        # folder = trial[0] + '_' + trial[1] + a_or_b
        # folder = "_".join(trial)
        # os.makedirs(join(group_base_path, 'shape', folder), exist_ok=True)
        # copy(join('videos', trial[2]), join(group_base_path, 'shape', folder, stim_name))
        # copy(join('videos', trial[3]), join(group_base_path, 'shape', folder, trial[3]))
        # copy(join('videos', trial[4]), join(group_base_path, 'shape', folder, trial[4]))

        trial[2] = trial[2].replace('png', 'mp4')
        if binomial(1, .5):
            trial[3] = trial[3].replace('png', 'mp4')
            trial[4] = trial[4].replace('png', 'mp4')
        else:
            tmp = trial[3]
            trial[3] = trial[4].replace('png', 'mp4')
            trial[4] = tmp.replace('png', 'mp4')

        stim_name =  trial[2].split('.')[0] + '__' + trial[3].split('.')[0] + '__' + trial[4].split('.')[0] + '.mp4'
        cmd = [
            'bash',
            'composite_videos.sh',
            join(group_base_path, 'shape', stim_name),
            trial[2],
            trial[3],
            trial[4],
        ]
        # print('command: ' + ' '.join(cmd))
        sp.call(cmd)
        paths[group]['shape'].append(# [
            join(group_base_path, 'shape', stim_name)# ,
                                      # join(group_base_path, 'shape', folder, trial[3]),
                                      # join(group_base_path, 'shape', folder, trial[4])# ]
        )

import json

with open('paths.json','w') as f:
    json.dump(paths, f)
