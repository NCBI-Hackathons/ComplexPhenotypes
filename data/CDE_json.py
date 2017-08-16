#!/usr/bin/python3

import json
import sys
import pprint

def find_dbGaPs(tree_root):
    dbGaPs = {}
    for key in tree_root['dataSets']:
        source = tree_root['dataSets'][key]['source']
        notes = tree_root['dataSets'][key]['notes']
        phenx_id = re.search('(PX\d+)$', notes).group() or "not found"
        id_set = tree_root['dataSets'][key]['id'] or "not found"
        if source == "dbGaP" and notes.startswith('PhenX') and id_set != "not found":
            dbGaPs[id_set] = phenx_id
    return dbGaPs


def find_name(tree_root):
    for key1 in tree_root['naming']:
        for key2 in tree_root['naming'][key1]['tags']:
            if tree_root['naming'][key1]['tags'][key2]['tag'] == 'Primary Name':
                primary_name = tree_root['naming'][key1]['designation']
                return primary_name
            elif tree_root['naming'][key1]['tags'][key2]['tag'] == 'Long Common Name':
                primary_name = tree_root['naming'][key1]['designation']
                return primary_name
            elif tree_root['naming'][key1]['tags'][key2]['tag'] == 'Shortname':
                primary_name = tree_root['naming'][key1]['designation']
                return primary_name
            else:
                primary_name = "no name in CDE"
                return primary_name 

def find_element_tree(tree_root):
    pass

def output(outfile, dbGaPs, primary_name):
    for id_set in dbGaPs:
        outfile.write(id_set + '\t' + dbGaPs[id_set] + '\t' + primary_name + '\n')

tree = open(sys.argv[1])
parsed_tree = json.load(tree)
outfile = open("CDE_table.tsv", "w")
outfile.write('phv_id\tPhenX_id\tCDE_primary_name\n')
for key in parsed_tree:
    output(outfile, find_dbGaPs(parsed_tree[key]), find_name(parsed_tree[key])

#pprint.pprint(parsed_tree[0:2])
#pprint.pprint(parsed_tree[0]['classification'][0]['elements'][0]['elements'][0]['elements'])
