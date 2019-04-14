clear; 
close all; 
clc

ds = datastore('house_prices_data_training_data.csv','TreatAsMissing','NA',.....
    'MissingValue',0,'ReadSize',17999);
T = read(ds);
X = T{:,4:21};
Corr_x = corr(X);
x_cov = cov(X);
[U S V] =  svd(x_cov)
Eigenvalues = diag(S)
Alpha=.01;




m = length(Eigenvalues)
 lambda = 0.01;
 k=1;
for i=1:m
    k=i;
    lambda = 1-((sum(Eigenvalues(1:i,:)))/sum(Eigenvalues))
    if (lambda < 0.001)
        break;
    end
end
k

Reduced =  U(:,1:k)'*X';


Approx  =  U(1:2,1:k) * Reduced;

Error = 1/m * sum(Approx - Reduced);
                                                                                                 Error = mean(Error)^-2

 R = Reduced(:,1:50);                                                                                                   
 X1=[ones(k,1)  R];
 %X1 = normalize(X1)
 n=length(X1(1,:));
 Y=T{1:2,3}/mean(T{1:2,3});
 Theta=zeros(n,1);
 
 
 k1 = 1;
 mm =length(R(:,1));
 
 E(k1)=(1/(2*mm))*sum((X1*Theta-Y).^2);

RR=1;
while RR==1
Alpha=Alpha*1;
Theta=Theta-(Alpha/mm)*X1'*(X1*Theta-Y);
k1=k1+1;
E(k1)=(1/(2*mm))*sum((X1*Theta-Y).^2);
if E(k1-1)-E(k1)<0
    break
end 
q=(E(k1-1)-E(k1))./E(k1-1);
if q <0.00001;
    RR=0;
end
end

%kmeann(X)
kmeann(transpose(Reduced))















 
 

 












