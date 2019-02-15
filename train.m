 ds = datastore('house_prices_data_training_data.csv','TreatAsMissing','NA',.....
    'MissingValue',0,'ReadSize',17999); 
 T = read(ds);  % first reading the data from the data set in matrix T
 m=round(length(T{:,1})*0.6,0); % m is the length f the first 60 percent of the data that will be used for training
 U=T{1:m,4:21}; %all the feautures of the 17999 house
 Alpha=.01; % learning rate
 b1=T{m+1:14399,4:21}; % the next 20 percent of the data that will be used for testing the cross val
 b1 = [ones(3600,1)  b1]; % adding a coloumn of ones to the b1 matrix
 p=0; % an integer that will remain 0 untill assigning 1 to it to calculate the final result of the last test
 
 
 
 
 X1=[ones(m,1)  U]; %the first hypothesis
 DiffInError1= Ass1(X1,T,m,Alpha,b1,p); % calling the function with a result of the difference between the minimum error calculated from training and the error calculated from the testing
 

 X2=[ones(m,1) U.^3]; %the second hypothesis
 DiffInError2=Ass1(X2,T,m,Alpha,b1,p); % calling the function with a result of the difference between the minimum error calculated from training and the error calculated from the testing
  
  
 X3=[ones(m,1)  exp(U).^-U]; %the tird hypothesis
 DiffInError3=Ass1(X3,T,m,Alpha,b1,p); % calling the function with a result of the difference between the minimum error calculated from training and the error calculated from the testing
   
 X4=[ones(m,1)  U.^4];   %the fourth hypothesis
 DiffInError4=Ass1(X4,T,m,Alpha,b1,p); % calling the function with a result of the difference between the minimum error calculated from training and the error calculated from the testing
 
 V = [DiffInError1,DiffInError2,DiffInError3,DiffInError4] % a vector that contains the diff between training error and testing error 
 
 %in my code and after testing i oticed that hypothesis 1 outputs the
 %minimum error so i will make the final test on it with the last 20
 %percent of the data
 
 c1=T{14400:17999,4:21}; %last 20 percent of the data
 c1=[ones(3600,1)  c1]; % adding a coloumn of ones
 
 
 %normalizing the data
 n2=length(c1(1,:));
for w2=2:n2;
    if max(abs(c1(:,w2)))~=0
    c1(:,w2)=(c1(:,w2)-mean((c1(:,w2))))./std(c1(:,w2));
    end
end


p=p+1; % finally after knowing the best hypothesis which is the first one in this case we make p=1 so it will join the f condirion in the function and make the final test
finalresult = Ass1(X4,T,m,Alpha,b1,c1,p) %calling the function to output the final result of the last test
 
 
 