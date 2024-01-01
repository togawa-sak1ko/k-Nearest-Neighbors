function [testPredictions ,testAccuracy, modelx] = mKNN(trainData,testData,k,distance)
 
% 提取训练数据特征和标签
[~,nn]=size(trainData);%获取训练集大小
% 将数组输入转换为表
VariableNames={};
for ii=1:nn
   colname=['column_',num2str(ii)];
   VariableNames=[VariableNames,colname];%表的列名称
end
predictorNames =VariableNames(2:end);%将要预测的列名称
inputTable = array2table(trainData, 'VariableNames', VariableNames);%将数组输入转换为表
predictors = inputTable(:, predictorNames); %获取训练特征数据
response = inputTable.column_1; %获取训练数据标签
%isCategoricalPredictor = [false, false, false, false, false, false, false, false, false, false, false, false, false];
%模型训练
% KNN训练分类器初始化
modelKNN = fitcknn(...
    predictors, ...
    response, ...
    'Distance', distance, ...
    'Exponent', [], ...
    'NumNeighbors', k, ...
    'DistanceWeight', 'Equal', ...
    'Standardize', true, ...
    'ClassNames', [1; 2; 3]);

% 使用预测函数创建结果结构体
predictorExtractionFcn = @(x) array2table(x, 'VariableNames', predictorNames);
knnPredictFcn = @(x) predict(modelKNN , x);
modelx.predictFcn = @(x) knnPredictFcn(predictorExtractionFcn(x));
% 向结果结构体中添加字段
modelx.ClassificationKNN = modelKNN ;

%模型预测
% 提取测试数据和标签
% 将输入转换为表
inputTable = array2table(testData, 'VariableNames', VariableNames);
predictors = inputTable(:, predictorNames);%测试数据特征
response = inputTable.column_1;%测试数据标签
%isCategoricalPredictor = [false, false, false, false, false, false, false, false, false, false, false, false, false];
% 测试集预测
[testPredictions, testScores] = predict(modelx.ClassificationKNN, predictors);
% 测试集准确度计算
%testAccuracy = 1 - resubLoss(modelx.ClassificationKNN, 'LossFun', 'ClassifError')
cc=0;
for ii=1:length(testPredictions)
    if response(ii)==testPredictions(ii)
        cc=cc+1;
    end

end    
testAccuracy=cc/length(response)
