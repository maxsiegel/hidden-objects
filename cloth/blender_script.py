import sys
from os.path import join
import json
import pickle
import os
from random import randint
import bpy
import argparse
import datetime

from mathutils import Quaternion, Vector

def parse_args():
    parser = argparse.ArgumentParser()

    parser.add_argument('--config-file', required = True, type=str)
    # parser.add_argument('--data-file', required = True, type=str)
    # parser.add_argument('--frame-dir', required = True, type=str)
    parser.add_argument('--start-frame', required = True, type=int)
    parser.add_argument('--end-frame', required = True, type=int)

    full_call = sys.argv

    dashes_ind = full_call.index('--') + 1 # for position of dashes
    argstring = full_call[dashes_ind:]
    args = parser.parse_args(argstring)

    return args

def kill_meshes():
    bpy.ops.object.select_by_type(type='MESH')
    bpy.ops.object.delete()
    for item in bpy.data.meshes:
        bpy.data.meshes.remove(item)

def deselect_all():
    for item in bpy.context.selectable_objects:
        item.select_set = False

def make_box():
    bpy.ops.mesh.primitive_cube_add()


    # box.scale = Vector((1, 1, 1))

    box = bpy.context.active_object
    bpy.ops.object.modifier_add(type='COLLISION')

    return box

def make_cloth():
    ndiv = 200
    bpy.ops.mesh.primitive_grid_add(x_subdivisions=ndiv, y_subdivisions=ndiv)
    cloth = bpy.context.active_object
    cloth.location = Vector((0, 0, 1.5))

    # geometry
    sz = 4
    cloth.scale = Vector((sz, sz, sz))

    # physics
    bpy.ops.object.modifier_add(type='CLOTH')

    cloth = randomize_cloth(cloth)

    return cloth

def cotton(cloth):
    settings = {}

    cloth.modifiers['Cloth'].settings.tension_stiffness     = 15
    cloth.modifiers['Cloth'].settings.shear_stiffness       = 15
    cloth.modifiers["Cloth"].settings.compression_stiffness = 15
    cloth.modifiers['Cloth'].settings.bending_stiffness     = 0.5


    cloth.modifiers["Cloth"].settings.air_damping           = 1

    cloth.modifiers['Cloth'].settings.tension_damping       = 5
    cloth.modifiers['Cloth'].settings.compression_damping   = 5
    cloth.modifiers['Cloth'].settings.shear_damping         = 5
    cloth.modifiers['Cloth'].settings.bending_damping       = 1

    cloth.modifiers['Cloth'].settings.mass                  = .3
    return cloth

def randomize_cloth(cloth):
    settings = {}

    settings['tension_stiffness']          = randint(5, 80)
    settings['shear_stiffness']            = randint(5, 80)
    settings['compression_stiffness']      = randint(5, 80)
    settings['bending_stiffness']          = 0.5


    settings['air_damping']                = 1

    settings['tension_damping']            = 5
    settings['compression_damping']        = 5
    settings['shear_damping']              = 5
    settings['bending_damping']            = 1

    cloth.modifiers['Cloth'].settings.mass = .3

    return cloth

def extract_settings(cloth):
    cs = cloth.modifiers['Cloth'].settings

    settings = {}
    settings['tension_stiffness'] = cs.tension_stiffness
    settings['shear_stiffness'] = cs.shear_stiffness
    settings['compression_stiffness'] = cs.compression_stiffness
    settings['bending_stiffness'] = cs.bending_stiffness
    settings['air_damping'] = cs.air_damping
    settings['tension_damping'] = cs.tension_damping
    settings['compression_damping'] = cs.compression_damping
    settings['shear_damping'] = cs.shear_damping
    settings['bending_damping'] = cs.bending_damping

    return settings

def timestamp():

    dt = datetime.datetime.now().isoformat().replace('-', '_').replace(':', '_').replace('.', '_')

    return dt

def maybe_mkdir(d):
    try:
        os.mkdir(d)
    except:
        pass

def bake(cloth):
    # bpy.ops.ptcache.bake_all()

    scene = bpy.data.scenes['Scene']
    scene.frame_end = 100
    cloth.modifiers['Cloth'].point_cache.frame_end = scene.frame_end

    maybe_mkdir('simulations')
    folder = join('simulations', timestamp())
    maybe_mkdir(folder)

    bpy.data.scenes['Scene'].render.filepath = folder + '/'

    with open(join(folder, 'config.json'), 'w') as f:
        json.dump(extract_settings(cloth), f)

def render():
    render = bpy.context.scene.render

    # Set output type
    render.image_settings.file_format = "FFMPEG"

    # Set output format
    render.ffmpeg.format = "MPEG4"

    # Set the codec
    render.ffmpeg.codec = "H264"

    render.engine = 'BLENDER_EEVEE'
    bpy.ops.render.render(animation=True)


def cube_random_settings():
    box = make_box()
    cloth = make_cloth()

    bake(cloth)
    render()

for i in range(10):
    cube_random_settings()
