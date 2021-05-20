% load('ProcessedIDataF.mat')
load('ProcessedDataC.mat')

n_subs = 15;
Sub1I = squeeze(single(AllImagDataC(1:n_subs,:,:,:,:)));
% Sub1I = squeeze(single(FilteredSubs1I(1:n_subs,:,:,:,:)));
Sub1I = permute(Sub1I, [5 2 1 3 4]);
Sub1I = reshape(Sub1I, [640*21*n_subs 4 64]);
%%
AllLabels = [];
for C=0:3
    LabelsNow = C*ones(size(Sub1I,1),1);
    AllLabels = [AllLabels; LabelsNow];
end
%%
Sub1IR = reshape(Sub1I, [size(Sub1I,1)*4 64]);
%%
Normalized = Sub1IR - min(Sub1IR(:));
Normalized = Normalized ./ max(Normalized(:));
cd('Imaginary Data/CSV Files/All Electrodes');
%%
disp('[info] Calculating Covariance matrix')

covariance_matrix = cov(Normalized);
writematrix(covariance_matrix,'covariance_matrix.csv');
figure('units','normalized','outerposition',[0 0 0.5 1]); 
imagesc(covariance_matrix)
title('Covariance Matrix of First 15 Subjects','FontWeight', 'bold')
xlabel('Channels'), ylabel('Channels');colorbar
set(gca, 'Fontsize',24);
print('covariance_matrix', '-dpng',  '-r600')
%% Calculate Spearam Later
disp('[info] Calculating Spearman matrix')
Spearman_matrix = corrcoef(Normalized);
writematrix(Spearman_matrix,'Spearman_matrix.csv');
Absolute_Spearman_matrix = abs(Spearman_matrix);
writematrix(Absolute_Spearman_matrix,'Absolute_Spearman_matrix.csv');
figure('units','normalized','outerposition',[0 0 0.5 1]); 
imagesc(Spearman_matrix)
title('Spearman Matrix of First 15 Subjects','FontWeight', 'bold')
xlabel('Channels'), ylabel('Channels');colorbar
set(gca, 'Fontsize',24);
print('Spearman_Matrix', '-dpng',  '-r600')

figure('units','normalized','outerposition',[0 0 0.5 1]); 
imagesc(Absolute_Spearman_matrix)
title('Absolute Spearman Matrix of First 15 Subjects','FontWeight', 'bold')
xlabel('Channels'), ylabel('Channels');colorbar
set(gca, 'Fontsize',24);
print('Absolute_Spearman_matrix', '-dpng',  '-r600')
%% Adjacency Matrix
disp('[info] Calculating Adjacency Matrix')
Eye_Matrix = eye(64, 64);
Adjacency_Matrix = Absolute_Spearman_matrix - Eye_Matrix;
writematrix(Adjacency_Matrix,'Adjacency_Matrix.csv');

figure('units','normalized','outerposition',[0 0 0.5 1]); 
imagesc(Adjacency_Matrix)
title('Adjacency Matrix of First 15 Subjects','FontWeight', 'bold')
xlabel('Channels'), ylabel('Channels');colorbar
set(gca, 'Fontsize',24);

print('Adjacency_matrix', '-dpng',  '-r600')

%% Degree Matrix
disp('[info] Calculating Degree Matrix')
diagonal_vector = sum(Adjacency_Matrix, 2);
Degree_Matrix = diag(diagonal_vector);
writematrix(Degree_Matrix,'Degree_Matrix.csv');
disp('[info] Degree Matrix Calculated')

figure('units','normalized','outerposition',[0 0 0.5 1]); 
imagesc(Degree_Matrix)
title('Degree Matrix of First 15 Subjects','FontWeight', 'bold')
xlabel('Channels'), ylabel('Channels');colorbar
set(gca, 'Fontsize',24);
print('Degree Matrix', '-dpng',  '-r600')

%% Laplacian Matrix
disp('[info] Calculating Laplacian Matrix')
Laplacian_Matrix = Degree_Matrix - Adjacency_Matrix;
writematrix(Laplacian_Matrix,'Laplacian_Matrix.csv');

disp('[info] Laplacian Matrix Calculated ')
figure('units','normalized','outerposition',[0 0 0.5 1]); 

imagesc(Laplacian_Matrix)
title('Laplacian Matrix of First 15 Subjects','FontWeight', 'bold')
xlabel('Channels'), ylabel('Channels');colorbar
set(gca, 'Fontsize',24);
print('Laplacian Matrix', '-dpng',  '-r600')
%%
All_Data = [Normalized, AllLabels];
rowrank = randperm(size(All_Data, 1));
All_Dataset = All_Data(rowrank, :);
[row, ~] = size(All_Dataset);


training_set   = All_Dataset(1:fix(row/10*8), 1:64);
val_set       = All_Dataset(fix(row/10*8)+1:fix(row/10*9), 1:64);
test_set       = All_Dataset(fix(row/10*9)+1:end,1:64);
training_label = All_Dataset(1:fix(row/10*8), end);
val_label =     All_Dataset(fix(row/10*8)+1:fix(row/10*9), end);
test_label     = All_Dataset(fix(row/10*9)+1:end, end);

writematrix(training_set,'training_set.csv' );
writematrix(val_set,'val_set.csv' );
writematrix(test_set,'test_set.csv' );
writematrix(training_label,'training_label.csv' );
writematrix(val_label,'val_label.csv' );
writematrix(test_label,'test_label.csv' );

