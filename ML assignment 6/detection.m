ds = datastore('house_prices_data_training_data.csv','TreatAsMissing','NA',.....
    'MissingValue',0,'ReadSize',17999);
T = read(ds);
X = T{:,4:21};
M=mean(X)
s=std(X)

for i=1:18
cdf(i) = normcdf(X(11,i),M(i),S(i))
end
 cdf = prod(cdf)
 if(cdf>0.99) || (cdf<0.001)
     status = 'atonomy'
 end