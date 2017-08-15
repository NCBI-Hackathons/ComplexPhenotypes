#!/usr/bin/python3

# from glob import glob # only for windows
import sys
import xml.etree.ElementTree as ET
import re

tree_list = sys.argv[1:] # glob(sys.argv[1])

def find_dbGaPs(root):
    dbGaPs = {}
    for dataSets in root.findall('dataSets'):
        source = dataSets.find('source').text
        notes = dataSets.find('notes').text
        phenx_id = re.search('(PX\d+)$', notes).group()
        id_set = dataSets.find('id').text
        if source == "dbGaP" and notes.startswith('PhenX'):
            dbGaPs[id_set] = phenx_id
    return dbGaPs

def find_PhenX(root):
    for naming in root.findall('naming'):
        for tags in naming.findall('tags'):
            if tags.find('tag').text == 'Primary Name':
                primary_name = naming.find('designation').text
                return primary_name
            else:
                return

for trees in tree_list:
    tree = ET.parse(trees)
    root = tree.getroot()
    find_dbGaPs(root)
    find_PhenX(root)
