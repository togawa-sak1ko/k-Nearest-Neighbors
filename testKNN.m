clear all
close all
clc
%数据解析
datapt = 'wine.data';
winedata = mImportData(datapt);


%样本统计
dataid= winedata(:,1);
figure
[bincounts,ind] = histc(dataid,[1,2,3]);
hist(dataid)
grid on 
text([1 1.8  2.8],bincounts+2,{['class1 N',num2str(bincounts(1))],['class2 N',num2str(bincounts(2))],['class3 N',num2str(bincounts(3))]})
xlim([0.5,3.5])
xlabel('样本ID')
ylabel('样本个数')
title('样本分布')

%训练数据与测试数据7比3随机分配
[num_samples,nn] = size(winedata);
%idx = randperm(num_samples);
load('idx.mat')
num_size = 0.7;                                %训练集占数据集比例
num_train_s = round(num_size * num_samples);   %训练集样本个数
traindata =winedata(idx(1:num_train_s), :);    %训练集
testdata= winedata(idx(num_train_s+1:end), :); %测试集
%KNN模型训练与测试
[testPredictions ,testAccuracy, modelx] = mKNN(traindata,testdata,5,'Cosine');
y_test=testdata(:,1);
%%预测结果作图
figure
plot(y_test,'ro');
hold on
plot(testPredictions,'b*');
grid on
xlabel('样本序号');
ylabel('类型');
legend('实际类型','预测类型');
set(gca,'fontsize',12)
% 混淆矩阵
figure
% cm = confusionchart(testPredictions , y_test);
% cm.Title = ['分类混淆矩阵,准确率',num2str(round(testAccuracy*100,2)),'%'];
% sortClasses(cm,'descending-diagonal');

cm = confusionchart(testPredictions ,  y_test);
cm.Title = '分类混淆矩阵';
sortClasses(cm,'descending-diagonal');
cm.Title = ['分类混淆矩阵,准确率',num2str(round(testAccuracy*100,2)),'%'];

