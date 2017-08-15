#!/usr/bin/python3

import json
import sys

parsed_tree = json.loads(sys.argv[1])

print(parsed_tree["tinyID"])
