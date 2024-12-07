clc,close,clear
load b.mat
load Wfea.mat
load template.mat
coeff_soft.Wfea = Wfea';
coeff_soft.Wfilter = b;
coeff_soft.Wtem = gen_template(template,Wfea);
T = gen_all_merge(coeff_soft,size(template,1)*size(template,2),size(template,3));