
function [E2 , Efinal] = Ass1( X , T , m , Alpha ,b1,p,c1)

%normalizing the first 60 percent of the data to be used in training
n=length(X(1,:));
for w=2:n;
    if max(abs(X(:,w)))~=0
    X(:,w)=(X(:,w)-mean((X(:,w))))./std(X(:,w));
    end
end
%normalizing the second 20 percent of the data that will be used for the
%first test
n1=length(b1(1,:));
for w1=2:n1;
    if max(abs(b1(:,w1)))~=0
    b1(:,w1)=(b1(:,w1)-mean((b1(:,w1))))./std(b1(:,w1));
    end
end

Y=T{1:m,3}/mean(T{1:m,3});%normalizing Y that will be used for training
z= T{m+1:14399,3}/mean(T{m+1:14399,3}); % normalizing z that wil be used with b1 and the optimal Theta in the first test
z1=T{14400:17999,3}/mean(T{14400:17999,3}); %normalizing z1 that wil be used with c1 and the optimal Theta in the final test
m1 = length(b1);
Theta=zeros(n,1);
k=1;

E(k)=(1/(2*m))*sum((X*Theta-Y).^2); %cost function

R=1;
while R==1
Alpha=Alpha*1;
Theta=Theta-(Alpha/m)*X'*(X*Theta-Y);
k=k+1;
E(k)=(1/(2*m))*sum((X*Theta-Y).^2);
if E(k-1)-E(k)<0
    break
end 
q=(E(k-1)-E(k))./E(k-1);
if q <0.0000001;
    R=0;
end
end


E1 = (1/(2*m1))*sum((b1*Theta-z).^2);

E2 = E1-E(end); % the difference between the error calculated from training and error calculated after testing the second 20 percent of the data

if(p==1) %this condition will be true only once after getting the best hypthesis from the 4 to make the final test on it
Efinal = (1/(2*m1))*sum((c1*Theta-z1).^2);% calculating the final error result after testing the best hypothesis with the last 20 percent of the data

end

 figure 
 plot(1:k,E,'-r')
 xlabel('number of iteratons')
 ylabel('training error in each iteration')

% figure 2
% plot(E(end),E,'-r')
% xlabel('least error after training')
% ylabel('error from testing')






end

