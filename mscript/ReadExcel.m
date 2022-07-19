%  Operate Excel
%
% 

ExcelFile = "\LockgMgr.xlsx";

ExcelFilePath =fullfile(pwd,ExcelFile);

try
    
    ExcelApp = actxserver('Excel.Application');
    WorkBook =  ExcelApp.Workbooks;
    
    
    
catch ME
    
    
    if(strcmp(ME.identifier,'MATLAB:COM:InvalidProgid'))
        
        
        causeException = MException('MATLAB:myCode:dimensions', ME.message);
        
        ME=addCause(ME,causeException);
    end
    %rethrow(ME);
    
end




wdata = Open(WorkBook,ExcelFilePath);

sheets = wdata.Sheets;
sheet12 = Item(sheets,2);
range = get(sheet12,'Range','D1','F6');
range.value
wdata.Close();
ExcelApp.Quit();
    
