%  Operate Excel
%
% 

try
    
    ExcelApp = actxserver('Excel.Application');
    WorkBook =  ExcelApp.Workbooks;
    
catch ME
    
    
    if(strcmp(ME.identifier,'MATLAB:COM:InvalidProgid'))
        
        
        causeException = MException('MATLAB:myCode:dimensions', ME.message);
        
        ME=addCause(ME,causeException);
    end
    
    % Throw the Exception Cause
    rethrow(ME);
    
end



FilePath=fullfile(pwd,'LockgMgr.xlsx');

ExcelApp.Visible = true;

wdata = WorkBook.Open(FilePath);

sheets = wdata.Sheets;


sheet12 = Item(sheets,1);


disp(sheets.Count);

% disp(wdata.Sheets.Item(1));



%get(wdata);
%Close(WorkBook);

%ExcelApp.Quit;  % Kill the Excel Application





 % Quit(ExcelApp);  
