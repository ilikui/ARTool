function sl_customization(cm)
% Align all I/O that are connected to a subsystem. The following kind of
% I/O are concerned :
% - Inport
% - Outport
% - From
% - Goto
%
% To make it work :
% 1. select the subsystem and its connected I/O
% 2. right-click on "Align I/O of selected subsystems"
% 3. as the result may not be perfect, just move the subsystem right and
% left so that Simulink improve the layout render.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



%% Register custom menu function.
cm.addCustomMenuFcn('Simulink:PreContextMenu', @getMyMenuItems);
end

%% Define the custom menu function.
function schemaFcns = getMyMenuItems(callbackInfo)
schemaFcns = {@alignBlocks};
end

%% Define the schema function for first menu item.
function schema = alignBlocks(callbackInfo)
schema = sl_action_schema;
schema.label  = 'Align I/O of selected subsystems';
schema.callback = @AlignSelected; 
end

function AlignSelected(cbinfo)
h_subsystems =find_system(gcs,'Findall','on','Selected','on','BlockType','SubSystem');
%Remove parent block from selection
h_subsystems = h_subsystems(find(h_subsystems~=get_param(gcs, 'Handle')));
for i = 1:length(h_subsystems)
    if (strcmp(get_param(h_subsystems(i),'Selected'), 'off'))
        continue;
    end
    %taken from sliotool.m
    align_ports(h_subsystems(i));
end
end

function align_ports(subsys_handle)
h_b = subsys_handle;
dd = get_param(h_b,'PortConnectivity');
gg = get_param(h_b, 'Position');
for (i = 1:length(dd))
    if(~isempty(dd(i).SrcBlock) || ~isempty(dd(i).DstBlock)) %Inport or outport is connected
        h_p = dd(i).SrcBlock;
        k = 0; %inport
        if (isempty(h_p))
            h_p = -1;
        end
        if (h_p < 0)
            h_p = dd(i).DstBlock;
            k = 1; %outport
        end
        if (isempty(h_p)) %Block not a subsystem
            continue;
        end
        if (length(h_p) > 1) %multi source/destination ports
            continue;
        end
        if (length(get_param(h_p,'PortConnectivity'))>1) %multi-connected port
            continue;
        end
        if(~strcmp(get_param(h_p,'BlockType'), 'Inport') && ~strcmp(get_param(h_p,'BlockType'), 'Outport') && ~strcmp(get_param(h_p,'BlockType'), 'From') && ~strcmp(get_param(h_p,'BlockType'), 'Goto'))
            continue;
        end
        if (strcmp(get_param(h_p,'Selected'), 'off')) %port not selected
            continue;
        end
        
        b = get_param(h_p,'Position');
        
        y = dd(i).Position(2)-(b(4)-b(2))/2;
        if (~k) %inport
            x = dd(i).Position(1)-(gg(3)-gg(1))*4/3;
            set_param(h_p,'Position',[x, y, x+(b(3)-b(1)), y+b(4)-b(2)]);
        else %outport
            x = dd(i).Position(1)+(gg(3)-gg(1))*4/3;
            set_param(h_p,'Position',[x, y, x+(b(3)-b(1)), y+b(4)-b(2)])
        end
    end
end
end