from os.path import join
from Util import *
from os import remove

## from, to_home
def copy_root_to(buff, deps, meta):
    from_dir = meta.Opt['from']
    to_dir = join(meta.Opt['to_home'], random_string())
    run("cp -r {0} {1}".format(from_dir, to_dir))
    return {'directory':to_dir}

## relative
def cd_to(buff, deps, meta):
    to = join(buff['directory'], meta.Opt['relative'])
    run("cd {0}".format(to))
    return {'directory':to}


## dump_path, vcd_path, iteration, adder, critical, image_num
def run_setup(buff, deps, meta):
    dump_to = join(buff['directory'], meta.Opt['dump_path'])
    vcd = join(dump_to, meta.Opt['vcd_path'])
    its = toList(meta.Opt['iteration'])
    adders = toList(meta.Opt['adder'])
    criticals = toList(meta.Opt['critical']) ## tuple
    image = range(1,meta.Opt['image_num']+1)
    for ct in criticals:
        order_path = dump_critical(ct)
        for it in its:
            for ad in adders:
                for im in image:
                    update_files(it, ad, order_path, im)
                    run("make run_Main_dump_all")
                    run("vcd2saif --input {0} --output {1}".format(vcd, make_name(it, ad, ct, im)))



## to
def copy_result_back_to(buff, deps, meta):
    run("cp {0} {1}".format("./dumpFolder/*.saif", meta.Opt['to']))
    return meta.Opt['to']

