#!/usr/bin/python3

import json
import sys
import pprint

tree = open(sys.argv[1])
parsed_tree = json.load(tree)

pprint.pprint(parsed_tree[0])
