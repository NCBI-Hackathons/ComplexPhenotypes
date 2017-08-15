#!/usr/bin/python3

#from glob import glob # only for windows
import sys
import xml.etree.ElementTree as ET
import re

tree_list = sys.argv[1:] 
print(tree_list)

def find_dbGaPs(root):
    dbGaPs = {}
    for dataSets in root.findall('dataSets'):
        source = dataSets.find('source').text
        notes = dataSets.find('notes').text
        phenx_id = re.search('(PX\d+)$', notes).group() or "not found"
        id_set = dataSets.find('id').text or "not found"
        if source == "dbGaP" and notes.startswith('PhenX') and id_set != "not found":
            dbGaPs[id_set] = phenx_id
    print(dbGaPs)
    return dbGaPs

def find_PhenX(root):
    for naming in root.findall('naming'):
        for tags in naming.findall('tags'):
            if tags.find('tag').text == 'Primary Name':
                primary_name = naming.find('designation').text
                return primary_name
            elif tags.find('tag').text == 'Long Common Name':
                primary_name = naming.find('designation').text
                return primary_name
            else:
                return

def output(outfile, dbGaPs, primary_name):
    for id_set in dbGaPs:
        outfile.write(id_set + '\t' + dbGaPs[id_set] + '\t' + primary_name + '\n')

outfile = open("CDE_table.tsv", "w")
outfile.write('phv_id\tPhenX_id\tCDE_primary_name\n')
for trees in tree_list:
    tree = ET.parse(trees)
    root = tree.getroot()
#    find_dbGaPs(root)
#    find_PhenX(root)
    print(trees)
    output(outfile, find_dbGaPs(root), find_PhenX(root))
