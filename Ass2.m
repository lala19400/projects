clear all
ds = datastore('heart_DD.csv','TreatAsMissing','NA',.....
    'MissingValue',0,'ReadSize',250);
t=0.15;
T = read(ds);
 Alpha=0.1;
 m=length(T{1:200,1});
 U=T{1:200,1:13}; %using the first 200 rows of the data set for training
 
 X=[ones(m,1) U.^2 U.^3 exp(-U)]; % first hypothesis (best one)
 
 %X=[ones(m,1) U U.^2];     second hypothesis 
 
 %X=[ones(m,1) exp(-U) U.^2];  third hypothesis 
 
 %X=[ones(m,1) U U.^2 U.^3];  fourth hypothesis 

 Utest=T{201:250,1:13}; % using the remaining 50 element for testing
 
 Xtest= [ones(50,1) , Utest.^2 Utest.^3 exp(-Utest) ] ;
 
 %normalizing X
n=length(X(1,:));
for w=2:n
    if max(abs(X(:,w)))~=0
    X(:,w)=(X(:,w)-mean((X(:,w))))./std(X(:,w));
    end
end

%normalizing Xtest
n1=length(Xtest(1,:));
for w1=2:n1
    if max(abs(Xtest(:,w1)))~=0
    Xtest(:,w1)=(Xtest(:,w1)-mean((Xtest(:,w1))))./std(Xtest(:,w1));
    end
end



  Y=T{1:200,14};  % Y used in training
  Ytest=T{201:250,14}; % Y used in testing
  Theta=zeros(n,1);
 
 

 k=1;
 
 h_theta = sigmoid(X*Theta);
 E(k)=(1/(m))*sum(-Y.*log((h_theta))-(1-Y).*log(1-h_theta));

R=1;
while R==1
Alpha=Alpha*1;
Theta=Theta-(Alpha/m)*X'*(h_theta-Y);
h_theta = sigmoid(X*Theta);
k=k+1;
E(k)=(1/(m))*sum(-Y.*log((h_theta))-(1-Y).*log(1-h_theta)); % cost function of logistic regression


if E(k-1)-E(k)<0
    break
end 
q=(E(k-1)-E(k))./E(k-1);
if q <0.0000001;
    R=0;
end
end
h_theta_test = sigmoid(Xtest*Theta);
Etest=(1/(m))*sum(-Ytest.*log((h_theta_test))-(1-Ytest).*log(1-h_theta_test)*t);
plot(E)
error=E(end)