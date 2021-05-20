
%%
cd('Imaginary Data/CSV Files');
BrainRegions = {'Cognition'; 'Motor'; 'Integration'; 'Visual'};
subplot = @(m,n,p) subtightplot (m, n, p, [0.05 0.02], [0.11 0.05], [0.08 0.05]);
figure('units','normalized','outerposition',[0 0 1 1]);
for BR=1:4
    subplot(2,2,BR)
    cd(['Region' num2str(BR)]);
    Name = ['Results_Imag_NoFilterBR' num2str(BR) '.csv'];
    T2 = readtable(Name);
    T2 = table2array(T2);
    CMData = T2(10:25);
    CMData = reshape(CMData, [4 4]);
    CMData1 = round(length(test_label)*CMData);
    Xlabels = {'Left Fist'; 'Right Fist'; 'Both Fists'; 'Both Feet'};
    Acc = plotConfMat1(CMData1, Xlabels);
    Title = [BrainRegions{(BR)} ' Accuracy: ' num2str(round(Acc,2)) ' %'];
    title(Title)
    set(gca, 'Fontsize',18);
    if BR==2||BR==4
        yticklabels([]);
        ylabel([]);
    end
    if BR==1||BR==2
        xticklabels([]);
        xlabel([]);
    end    
    cd ..;
end
%%
subplot = @(m,n,p) subtightplot (m, n, p, [0.05 0.02], [0.11 0.05], [0.11 0.05]);
figure('units','normalized','outerposition',[0 0 1 1]);
subplot(1,2,1)
BR = 0;
cd(['Imaginary Data/CSV Files/All Electrodes']);
Name = ['Results_Imag_NoFilterBR' num2str(BR) '.csv'];
T2 = readtable(Name);
T2 = table2array(T2);
CMData = T2(10:25);
CMData = reshape(CMData, [4 4]);
CMData1 = round(length(test_label)*CMData);
Xlabels = {'Left Fist'; 'Right Fist'; 'Both Fists'; 'Both Feet'};
Acc = plotConfMat1(CMData1, Xlabels);
Title = ['Imaginary ' 'Accuracy: ' num2str(round(Acc,2)) ' %'];
title(Title)
set(gca, 'Fontsize',24);
cd ..; cd ..; cd ..;

cd(['Executed Data/CSV Files/All Electrodes']);
Name = ['Results_Exec_NoFilterBR' num2str(BR) '.csv'];
T2 = readtable(Name);
T2 = table2array(T2);
CMData = T2(10:25);
CMData = reshape(CMData, [4 4]);
CMData1 = round(length(test_label)*CMData);
Xlabels = {'Left Fist'; 'Right Fist'; 'Both Fists'; 'Both Feet'};
subplot(1,2,2)
Acc = plotConfMat1(CMData1, Xlabels);
Title = ['Executed ' 'Accuracy: ' num2str(round(Acc,2)) ' %'];
title(Title)
set(gca, 'Fontsize',24);

yticklabels([]);
ylabel([]);
cd ..; cd ..; cd ..;
