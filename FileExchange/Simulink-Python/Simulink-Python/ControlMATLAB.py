#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Mon Jun  1 13:35:06 2020

@author: chanaka
"""
# Make sure to share the MATLAB window that is already opeened
#matlab.engine.shareEngine (type in MATLAB command window)

import matlab.engine
#import time
#import pandas
#matlab.engine.shareEngine
#matlab.engine.find_matlab()
eng=matlab.engine.start_matlab()
eng=matlab.engine.connect_matlab() # remove the MATLAB window number if we already shared the MATLAB
batteryCD=50.2
eng.workspace['batteryCDpower']=batteryCD
Values=eng.GetRealTimeData(batteryCD,nargout=6) # Simulation has to be running
print(Values)
#time.sleep(1)
eng.quit()


 