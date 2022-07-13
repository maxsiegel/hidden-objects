from multiprocessing import Pool
import subprocess as sp

# has to be a list of command and args
cmd = 'blender -b --python blender_script.py'.split(' ')

def run_cmd(x):
    sp.check_call(cmd)

if __name__ == '__main__':
    p = Pool(25)

    p.map(run_cmd, range(20))
