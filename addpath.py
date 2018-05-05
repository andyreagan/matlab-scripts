#!/usr/bin/python
#
# add path to the matlab environment
from subprocess import call

matlab = "/Applications/MATLAB_R2013a.app/bin/matlab"

call('mv ' + matlab + ' ' + matlab + '2',shell=True)

f = open(matlab + '2')
g = open(matlab,'w')

comments = True

for line in f:
  if comments:
    if line[0] != '#':
      comments = False
      g.write('\n'+"export PATH=\"$PATH:/usr/texbin\"\n\n")
  g.write(line)
  
f.close()
g.close()

call("\\rm " + matlab + '2',shell=True)
