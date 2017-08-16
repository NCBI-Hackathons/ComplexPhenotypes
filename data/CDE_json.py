#!/usr/bin/python3

import json
import sys
import re
import pprint

#gets dbGaP crossrefs from dataSets block
def find_dbGaPs(tree_root, index):
    dbGaPs = {}
    for n in range(len(tree_root[index]['dataSets'])):
        source = tree_root[index]['dataSets'][n]['source']
        notes = tree_root[index]['dataSets'][n]['notes']
        phenx_id = re.search('(PX\d+)$', notes).group() or "not found"
        id_set = tree_root[index]['dataSets'][n]['id'] or "not found"
        if source == "dbGaP" and notes.startswith('PhenX') and id_set != "not found":
            dbGaPs[id_set] = phenx_id
    return dbGaPs

#gets name(s) from naming block
def find_name(tree_root, index):
    for n in range(len(tree_root[index]['naming'])):
        for m in range(len(tree_root[index]['naming'][n]['tags'])):
            if tree_root[index]['naming'][n]['tags'][m]['tag'] == 'Primary Name':
                primary_name = tree_root[index]['naming'][n]['designation']
                return primary_name
            elif tree_root[index]['naming'][n]['tags'][m]['tag'] == 'Long Common Name':
                primary_name = tree_root[index]['naming'][n]['designation']
                return primary_name
            elif tree_root[index]['naming'][n]['tags'][m]['tag'] == 'Shortname':
                primary_name = tree_root[index]['naming'][n]['designation']
                return primary_name
            else:
                primary_name = "no name in CDE"
                return primary_name 

#makes CDE_table.tsv
def output_tsv(outfile, dbGaPs, primary_name):
    for id_set in dbGaPs:
        outfile.write(id_set + '\t' + dbGaPs[id_set] + '\t' + primary_name + '\n')
    return

#recursive loop through element blocks for parent:child pairs
def recursive_parent_match(tree_root, parent):
    pprint.pprint(tree_root)
    if not tree_root[0]:
        for n in range(1,len(tree_root)):
            parentchild[parent] = tree_root['name']
    else:
        for n in range(1,len(tree_root)):
            child = tree_root['name']
            parentchild[parent] = child
            new_tree_root = tree_root[0]['elements']
            recursive_parent_match(new_tree_root, child)
    
#setup recursive loop by getting to right depth in element block
def find_element_tree(tree_root, index):
    parentchild = {}
    if tree_root[index]['classification'][0]['stewardOrg']['name'] == 'PhenX':
        new_tree_root = tree_root[index]['classification'][0]['elements'][0]['elements'][0]
        recursive_parent_match(new_tree_root, 'Domains')
    pprint.pprint(parentchild)
    return parentchild

outfile = open("CDE_table.tsv", "w")
outfile.write('phv_id\tPhenX_id\tCDE_primary_name\n')
tree = open(sys.argv[1])
parsed_tree = json.load(tree)
for index in range(len(parsed_tree)):
    output_tsv(outfile, find_dbGaPs(parsed_tree, index), find_name(parsed_tree, index))
    find_element_tree(parsed_tree, index)

#pprint.pprint(parsed_tree[0:2])
pprint.pprint(parsed_tree[0]['classification'][0]['elements'][0]['elements'][0]['elements'])