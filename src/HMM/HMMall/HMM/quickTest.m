count = 0;
correct = 0;

for i=1:size(sequences,1)
   for j=1:size(sequences,2)
       [max_likelihood, max_index, likelihoods] = testLikelihood(models, sequences(i,j));
       likelihoods
       if(max_index == i)
          correct = correct + 1; 
       end
       
       count = count + 1;
   end
end

correct/count