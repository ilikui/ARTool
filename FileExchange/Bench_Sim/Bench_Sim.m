tic
for jj=1:10
DateString=datestr(now,30);
MyModel=['TestBench' DateString];
new_system(MyModel); 
load_system(MyModel);

for ii= 1:100
add_block('built-in/Gain',[MyModel '/Gain' num2str(ii)],'Gain',num2str(ii),'Position',[225 150+ii*50 255 180+ii*50]);
add_block('simulink/Sources/From Workspace',[MyModel '/FW' num2str(ii)],'VariableName',['Input' num2str(ii)],'Position',[125 150+ii*50 155 180+ii*50]);
add_line(MyModel,['FW' num2str(ii) '/1'],['Gain' num2str(ii) '/1']);
add_block('simulink/Sinks/To Workspace',[MyModel '/TW' num2str(ii)],'VariableName',['Output' num2str(ii)],'Position',[325 150+ii*50 355 180+ii*50],'SaveFormat','Array');
add_line(MyModel,['Gain' num2str(ii) '/1'],['TW' num2str(ii) '/1']);
% Additional blocks
%add_block('simulink/Sources/Constants',[MyModel '/Const' num2str(ii)],'VariableName',['Input' num2str(ii)]);

end
MyBlk=find_system(MyModel,'BlockType','Gain','Gain','100');
set_param(MyModel,'SolverType','Fixed-step');
set_param(MyModel,'Solver','FixedStepDiscrete');
set_param(MyModel,'FixedStep','0.01');
[rawdata a,b]=xlsread('BenchTestInput');
clear a b;
Stptime=(rawdata(1,2)-1)*0.01;
set_param(MyModel,'StopTime',num2str(Stptime));
t=0:0.01:Stptime;
t=t';
for ii=1:100
    eval(['Input' num2str(ii) '= [t rawdata(6:end,ii+1)];' ]);
end

sim(MyModel);
OUTData=[];
for ii=1:100
    eval(['OUTData=[OUTData Input' num2str(ii) '(:,2)];'  ]);
end
for ii=1:100
    eval(['OUTData=[OUTData Output' num2str(ii) '];'  ]);
end
xlswrite(['BenchTestInput' DateString],OUTData,'B6:GS1006');
save_system(MyModel);
close_system(MyModel);
% bdclose all;
end
toc