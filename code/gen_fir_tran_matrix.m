function T = gen_fir_tran_matrix(coeff_soft_fir, n_input, n_output)
n = size(coeff_soft_fir);
assert(n_input > n(2) & n(1) == 1,'coeff_soft_fir size error!');
T1 = zeros(n_input-n(2)+1,n_input);
for i = 1:size(T1)
    T1(i,end-i+1-n(2)+1:end-i+1) = coeff_soft_fir;
end
T2 = zeros(n(2)-1,n_input);
T3 = zeros(n(2)-1,n_input);
for i = 1:n(2)-1
    T2(i,end-i+1:end) = coeff_soft_fir(1:i);
    T3(end-i+1,1:i) = coeff_soft_fir(end-i+1:end);
end
T_total = [T2; T1; T3];
start_0_index = floor((n_input+n(2)-1-n_output)/2);
T = T_total(start_0_index+1:start_0_index+n_output,:);
assert(n_output >= n_input-n(2)+1, 'check n_output!');
assert(size(T,2) == n_input & size(T,1) == n_output,'T size error!');
end
