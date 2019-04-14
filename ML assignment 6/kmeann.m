
function [error ,iterations ] = kmeann(x)

%DataTable = readtable('house_prices_data_training_data.csv');
% x = table2array(DataTable(1:17999,4:21));
% 
 [X] = normalize(x);
 [n m] = size(x);

cost = zeros(5,1);


for K=1:5
    
    %   Input args: k: number of clusters;
    %   points: m-by-n matrix of n m-dimensional data points.
    %   Output args: cluster: 1-by-n array with values of 0,...,k-1
    %   representing in which cluster the corresponding point lies in
    %   centr: m-by-k matrix of the m-dimensional centroids of the k clusters
    
    numP = size(X,1); % number of points
    dimP = size(X,2); % dimension of points
    
    
    %% Choose k data points as initial centroids
    
    % choose k unique random indices between 1 and size(P,2) (number of points)
    randIdx = randperm(numP)
    % initial centroids
    centr = X(randIdx(1:K),:);
    centrP = zeros(size(centr));
    
    % init cluster array
    cluster = zeros(size(X,1),1);
    dist = zeros(n,K);
    
    % init previous cluster array clusterPrev (for stopping criterion)
    clusterPrev = cluster;
    iterations = 0;
    
    % init stopping criterion
    stop = false;
    counter=0;
    
    while stop == false
        
        for idxP = 1:n
            for idxC = 1:K
                dist(idxP , idxC) = sum((X(idxP,:) - centr(idxC, :)).^2);
                
                % nearest = [ nearest; dist*dist' ];
            end
            % [value, index] = min(nearest);
            cluster(idxP) = find(dist(idxP,:)==min(dist(idxP,:)));
        end
        
        
        
        % Recompute centroids using current cluster memberships:
        
        % for every cluster compute new centroid
        for idxC = 1:K
            % find the points in cluster number idxC and compute row-wise mean
            % centr(idxC,:) = mean(X(cluster==idxC,:));
            xi = X(find(cluster == idxC), :);
            ck = size(xi,1);
            centr(idxC, :) =  mean(xi)
            error =0;
            
            
            for check = 1 : size(xi,1)
                error = error + sum((xi(check,:) - centr(idxC,:)).^2)/n;
            end
            
            cost(K,1) = error;
        end
        
        
        % Checking for stopping criterion: Clusters do not chnage anymore
        if clusterPrev==cluster
            counter =counter+1;
            if counter>1
                stop = true;
            end
        end
        % update previous cluster clusterPrev
        clusterPrev = cluster;
        iterations = iterations + 1;
        
    end
    
    % for reference: print number of iterations
    fprintf('kMeans.m used %d iterations of changing centroids.\n',iterations);
    cluster;
    centr;
    
    
end
plot (cost)
error