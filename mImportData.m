function wine = mImportData(filename, dataLines)
%IMPORTFILE 从文本文件中导入数据
%  WINE = IMPORTFILE(FILENAME)读取文本文件 FILENAME 中默认选定范围的数据。  返回数值数据。
%
%  WINE = IMPORTFILE(FILE, DATALINES)按指定行间隔读取文本文件 FILENAME
%  中的数据。对于不连续的行间隔，请将 DATALINES 指定为正整数标量或 N×2 正整数标量数组。
%
%  示例:
%  wine = importfile("D:\workspace\matlab\105_KNN分类\wine.data", [1, Inf]);
%
%  另请参阅 READTABLE。
%
% 由 MATLAB 于 2023-06-18 13:13:13 自动生成

%% 输入处理

% 如果不指定 dataLines，请定义默认范围
if nargin < 2
    dataLines = [1, Inf];
end

%% 设置导入选项并导入数据
opts = delimitedTextImportOptions("NumVariables", 14);

% 指定范围和分隔符
opts.DataLines = dataLines;
opts.Delimiter = ",";

% 指定列名称和类型
opts.VariableNames = ["VarName1", "VarName2", "VarName3", "VarName4", "VarName5", "VarName6", "VarName7", "VarName8", "VarName9", "VarName10", "VarName11", "VarName12", "VarName13", "VarName14"];
opts.VariableTypes = ["double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double"];

% 指定文件级属性
opts.ExtraColumnsRule = "ignore";
opts.EmptyLineRule = "read";

% 导入数据
wine = readtable(filename, opts);

%% 转换为输出类型
wine = table2array(wine);
end