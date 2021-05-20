load('ProcessedDataC.mat')
n_subs = 15;
Sub1I = squeeze(single(AllImagDataC(1:n_subs,:,:,:,:)));
% Sub1I = squeeze(single(FilteredSubs1I(1:n_subs,:,:,:,:)));
Sub1I = permute(Sub1I, [5 2 1 3 4]);
Sub1I = reshape(Sub1I, [640*21*n_subs 4 64]);
Sub1IR = reshape(Sub1I, [size(Sub1I,1)*4 64]);
%%
AllLabels = [];
for C=0:3
    LabelsNow = C*ones(size(Sub1I,1),1);
    AllLabels = [AllLabels; LabelsNow];
end
for R=1:4
    cd(['Imaginary Data\CSV Files\Region' num2str(R)]);    
    %% Choose Brain Region
    Sub1IRB = ChooseBrainRegionGCN(Sub1IR,R);
    %%
    Normalized = Sub1IRB - min(Sub1IRB(:));
    Normalized = Normalized ./ max(Normalized(:));
    %%
    disp('[info] Calculating Covariance matrix')
    covariance_matrix = cov(Normalized);
    FileName = ['covariance_matrix.csv'];
    writematrix(covariance_matrix,FileName);
    figure('units','normalized','outerposition',[0 0 0.5 1]); 
    imagesc(covariance_matrix)
    title('Covariance Matrix of First 10 Subjects','FontWeight', 'bold')
    xlabel('Channels'), ylabel('Channels');colorbar
    set(gca, 'Fontsize',24);
    print('covariance_matrix', '-dpng',  '-r600')
    %% Calculate Spearam Later
    disp('[info] Calculating Spearman matrix')
    Spearman_matrix = corrcoef(Normalized);
    FileName = ['Spearman_matrix.csv'];
    writematrix(Spearman_matrix,FileName);
    Absolute_Spearman_matrix = abs(Spearman_matrix);
    FileName = ['Absolute_Spearman_matrix.csv'];
    writematrix(Absolute_Spearman_matrix,FileName);
    figure('units','normalized','outerposition',[0 0 0.5 1]); 
    imagesc(Spearman_matrix)
    title('Spearman Matrix of First 10 Subjects','FontWeight', 'bold')
    xlabel('Channels'), ylabel('Channels');colorbar
    set(gca, 'Fontsize',24);
    print('Spearman_Matrix', '-dpng',  '-r600')
    figure('units','normalized','outerposition',[0 0 0.5 1]); 
    imagesc(Absolute_Spearman_matrix)
    title('Absolute Spearman Matrix of First 10 Subjects','FontWeight', 'bold')
    xlabel('Channels'), ylabel('Channels');colorbar
    set(gca, 'Fontsize',24);
    print('Absolute_Spearman_matrix', '-dpng',  '-r600')
    %% Adjacency Matrix
    disp('[info] Calculating Adjacency Matrix')
    n_electrodes = size(Normalized,2);
    Eye_Matrix = eye(n_electrodes, n_electrodes);
    Adjacency_Matrix = Absolute_Spearman_matrix - Eye_Matrix;
    FileName = ['Adjacency_Matrix.csv'];
    writematrix(Adjacency_Matrix,FileName);
    figure('units','normalized','outerposition',[0 0 0.5 1]); 
    imagesc(Adjacency_Matrix)
    title('Adjacency Matrix of First 10 Subjects','FontWeight', 'bold')
    xlabel('Channels'), ylabel('Channels');colorbar
    set(gca, 'Fontsize',24);
    print('Adjacency_matrix', '-dpng',  '-r600')
    %% Degree Matrix
    disp('[info] Calculating Degree Matrix')
    diagonal_vector = sum(Adjacency_Matrix, 2);
    Degree_Matrix = diag(diagonal_vector);
    FileName = ['Degree_Matrix.csv'];
    writematrix(Degree_Matrix,FileName);
    disp('[info] Degree Matrix Calculated')
    figure('units','normalized','outerposition',[0 0 0.5 1]); 
    imagesc(Degree_Matrix)
    title('Degree Matrix of First 10 Subjects','FontWeight', 'bold')
    xlabel('Channels'), ylabel('Channels');colorbar
    set(gca, 'Fontsize',24);
    print('Degree Matrix', '-dpng',  '-r600')

    %% Laplacian Matrix
    disp('[info] Calculating Laplacian Matrix')
    Laplacian_Matrix = Degree_Matrix - Adjacency_Matrix;
    FileName = ['LaplacianMatrix.csv'];
    writematrix(Laplacian_Matrix,FileName);
    disp('[info] Laplacian Matrix Calculated ')
    figure('units','normalized','outerposition',[0 0 0.5 1]); 
    imagesc(Laplacian_Matrix)
    title('Laplacian Matrix of First 10 Subjects','FontWeight', 'bold')
    xlabel('Channels'), ylabel('Channels');colorbar
    set(gca, 'Fontsize',24);
    print('Laplacian Matrix', '-dpng',  '-r600')
    %%
    All_Data = [Normalized, AllLabels];
    rowrank = randperm(size(All_Data, 1));
    All_Dataset = All_Data(rowrank, :);
    [row, ~] = size(All_Dataset);
    training_set   = All_Dataset(1:fix(row/10*9),     1:n_electrodes);
    test_set       = All_Dataset(fix(row/10*9)+1:end, 1:n_electrodes);
    training_label = All_Dataset(1:fix(row/10*9),     end);
    test_label     = All_Dataset(fix(row/10*9)+1:end, end);
    writematrix(training_set,'training_set.csv' );
    writematrix(test_set,'test_set.csv' );
    writematrix(training_label,'training_label.csv' );
    writematrix(test_label,'test_label.csv' );
    cd ..; cd ..; cd ..;
end
