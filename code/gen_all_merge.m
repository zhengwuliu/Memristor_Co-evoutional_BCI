function T = gen_all_merge(coeff_soft,n_input,n_output)
[n_code, n_chan] = size(coeff_soft.Wfea);
n_time_step_per_chan_out = n_input/n_chan;
n_time_step_per_chan_in = n_time_step_per_chan_out;
M0 = gen_fir_tran_matrix(coeff_soft.Wfilter, n_time_step_per_chan_in, ...
    n_time_step_per_chan_in+length(coeff_soft.Wfilter)-1);
M1 = M0(1:n_time_step_per_chan_out,:);
[m1, m2] = size(M1);
M1 = fliplr(M1);

[m11, m22] = size(coeff_soft.Wtem);
assert(n_time_step_per_chan_out * n_code == m22,'gen_all_merge flag1');
assert(n_code == m11,'gen_all_merge flag2');
assert(n_time_step_per_chan_in == m2,'gen_all_merge flag3');
assert(n_time_step_per_chan_out == m1,'gen_all_merge flag4');
assert(n_code == n_output,'gen_all_merge flag5');

T1 = zeros(n_input,n_input);
A = M1;
for i = 1:n_chan
    T1((i-1)*n_time_step_per_chan_out+1:i*n_time_step_per_chan_out,...
        (i-1)*n_time_step_per_chan_in+1:i*n_time_step_per_chan_in) = A;
end

T2 = zeros(n_code*n_time_step_per_chan_out,n_input);
B = coeff_soft.Wfea;
for i = 1:n_time_step_per_chan_out
    T2(i:n_time_step_per_chan_out:(n_code-1)*n_time_step_per_chan_out+i,i:n_time_step_per_chan_out:(n_chan-1)*n_time_step_per_chan_out+i) = B;
end

C = coeff_soft.Wtem;
T3 = C;

T = T3*T2*T1;
end
