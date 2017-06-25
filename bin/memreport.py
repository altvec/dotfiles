#!/usr/bin/env python3

import subprocess
import re

# Get process info
ps = subprocess.Popen(['ps', '-caxm', '-orss,comm'], stdout=subprocess.PIPE).communicate()[0]
vm = subprocess.Popen(['vm_stat'], stdout=subprocess.PIPE).communicate()[0]

# Iterate processes
processLines = ps.decode().split('\n')
sep = re.compile('[\s]+')
rssTotal = 0 # kB
for row in range(1,len(processLines)):
    rowText = processLines[row].strip()
    rowElements = sep.split(rowText)
    try:
        rss = float(rowElements[0]) * 1024
    except:
        rss = 0 # ignore...
    rssTotal += rss

# Process vm_stat
vmLines = vm.decode().split('\n')
sep = re.compile(':[\s]+')
vmStats = {}
for row in range(1,len(vmLines)-2):
    rowText = vmLines[row].strip()
    rowElements = sep.split(rowText)
    vmStats[(rowElements[0])] = int(rowElements[1].strip('\.')) * 4096

print(f'Wired Memory:\t\t{round(vmStats["Pages wired down"]/1024/1024)} MB')
print(f'Active Memory:\t\t{round(vmStats["Pages active"]/1024/1024)} MB')
print(f'Inactive Memory:\t{round(vmStats["Pages inactive"]/1024/1024)} MB')
print(f'Free Memory:\t\t{round(vmStats["Pages free"]/1024/1024)} MB')
print(f'Real Mem Total (ps):\t{round(rssTotal/1024/1024)} MB')
