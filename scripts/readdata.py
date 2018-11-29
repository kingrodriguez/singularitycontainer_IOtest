import sys
import itertools
from pathlib import Path

f = open(str(Path.home())+"/singularity/data/"+str(sys.argv[1]),"rb")

for i in itertools.count():
    record = f.read(1)
    if not record:
        break

print(str(sys.argv[1])+" done")

