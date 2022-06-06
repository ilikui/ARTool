Author: Chanaka Keerthisinghe, Ph.D
chanakak@ieee.org
Date: June 22, 2020

The purpose of this readme file is to show you how to send/receive Simulink data using python while the simulation is running.

The attached Simulink model is based on this: 
https://ieeexplore.ieee.org/document/9087709/authors#authors
IEEE paper is also attached.

The Simulink model is created to run in OPAL-RT real-time digital simulator. So for the purpose of this demonstration
I commented out the blocks from the ARTEMis library.
Simulink model should run in MATLAB 2018b or a later version. MATLAB agent of 2018b version requires python 3.6.
If you are using a later version of MATLAB then you can use python 3.7. 

Install a suitable python version. If you are using Anaconda then use the following code in the Anaconda Command Line to create a new environment (if required).

	conda create -n "myenv" python=3.6 ipython
	conda activate myenv

Install the MATLAB agent using the following lines in Anaconda: 
	cd matlabroot\extern\engines\python
	(type matlabroot in MATLAB command window to get the directory)
	python setup.py install

You might have to do this in MATLAB command line too.
	cd (fullfile(matlabroot,'extern','engines','python'))
	system('python setup.py install')

How to run:

1) Open the Simulink model
2) Second type matlab.engine.shareEngine in the MATLAB command window to share the currently opened MATLAB instance.
4) Open the GetRealTimeData.m file in the same MATLAB window to see what it does. This is the file that we are calling from python. Note the input(s) and outputs.
5) Change the path of the MATLAB to the location of the GetRealTimeData.m or set the path.
6) Click on the SubSystem block in the sc_user_interface block of the Simulink. This is to make that block the RunTime Object.
7) Run the Simulink model

Now open the correct python version. Make sure to select the correct environment if you created a new one. 
Run the  ControlMATLAB.py file. You should see the Simulink outputs in the python command window and the python variable (batteryCD) value in the Simulink user interface window.

Don't save the Simulink model after running the python function.

Troubleshoot:
1) Check if the installation of MATLAB agent is successful.
2) Make sure the MATLAB engine is closed by typing 
eng.quit()
3) If the Simulink file doesnt run after sometimes that means that the constant variable in the user_interface block has changed. Give it a constant number (default is 50). Or just download this again.


Hope this is helpful. If needed, please use the below for citations:

C. Keerthisinghe and D. S. Kirschen, "1 Real-Time Digital Simulation of Microgrid Control Strategies," 2020 IEEE Power & Energy Society Innovative Smart Grid Technologies Conference (ISGT), Washington, DC, USA, 2020, pp. 1-5, doi: 10.1109/ISGT45199.2020.9087709.










