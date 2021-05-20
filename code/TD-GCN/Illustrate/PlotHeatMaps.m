
T = readtable('ElectrodePositions.txt');
LocsNow = table2array(T(:,1));
%% Plot Heat Maps for the Imaginary Classes
ClassesNow = squeeze(AllImagDataC(1:10,:,:,:,:));
ClassesNow2 = rms(ClassesNow,5);
ClassesNow3 = permute(ClassesNow2, [4 3 1 2]);
ClassesNow4 = median(ClassesNow3(:,:,:),3);
MaxIn1 = max(max(ClassesNow4));
figure('units','normalized','outerposition',[0 0 1 0.6]);
subplot = @(m,n,p) subtightplot (m, n, p, [0 0], [0.05 0.075], [0.05 0.05]);

for c=1:4
    Avg = ClassesNow4(:,c);
    subplot(1,4,c)
    FCHeatMap1WayGCN(Avg, 'Chosen', LocsNow, MaxAll)
    if c~=4
    colorbar off
    end
    title(Xlabels{c});
     
end
sgt = sgtitle('Imaginary Data');
sgt.FontSize = 30;
sgt.FontWeight = 'bold';
%% Plot Heat Maps for the Executed Classes
ClassesNow = squeeze(AllExecDataC(1:10,:,:,:,:));
ClassesNow2 = rms(ClassesNow,5);
ClassesNow3 = permute(ClassesNow2, [4 3 1 2]);
ClassesNow4 = median(ClassesNow3(:,:,:),3);
MaxIn = max(max(ClassesNow4));
figure('units','normalized','outerposition',[0 0 1 0.6]);
subplot = @(m,n,p) subtightplot (m, n, p, [0 0], [0.05 0.075], [0.05 0.05]);

for c=1:4
    Avg = ClassesNow4(:,c);
    subplot(1,4,c)
    FCHeatMap1WayGCN(Avg, 'Chosen', LocsNow, MaxAll)
    if c~=4
    colorbar off
    end
    title(Xlabels{c});
     
end
sgt = sgtitle('Executed Data');
sgt.FontSize = 30;
sgt.FontWeight = 'bold';