try
    
    e = actxserver('Excel.Application');
    
catch ME
    
    
    if(strcmp(ME.identifier,'MATLAB:COM:InvalidProgid'))
        
        
        causeException = MException('MATLAB:myCode:dimensions', ME.message);
        
        ME=addCause(ME,causeException);
    end
    %rethrow(ME);
    
end

    
