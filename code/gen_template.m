function [W, gain_s2w] = gen_template(A,B)
assert(size(A,1) == size(B,1));
W = zeros(size(A,2)*size(B,2),size(A,3));
for i = 1:size(A,3)
W(:,i) = reshape(A(:,:,i)'*B,[],1)/std(reshape(A(:,:,i)'*B,[],1)); % std默认按照N-1标准化
s(i) = std(reshape(A(:,:,i)'*B,[],1));
m(i) = mean(reshape(A(:,:,i)'*B,[],1));
s1(i) = sum(reshape(A(:,:,i)'*B,[],1).^2).^0.5/(1199.^0.5);

end
gain_s2w = (length(reshape(A(:,:,1)'*B,[],1))-1).^0.5;
W = W';
W = W/gain_s2w;
end