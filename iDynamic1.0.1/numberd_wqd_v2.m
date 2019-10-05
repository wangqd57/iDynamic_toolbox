
function [ o_mat_t ] = numberd_wqd_v2( o_mat, key, rand_num)
o_mat = sortrows(o_mat,key);
o_mat_t=o_mat;
o_mat=table2array(o_mat);

[~,ia,ic] = unique(o_mat(:,key), 'rows');
if rand_num==1
    num=arrayfun(@(i) randperm(i), accumarray(ic,1)', 'un', 0);
else
    num=arrayfun(@(i, j) (i:j), ones(size(ia))', accumarray(ic,1)', 'un', 0);
end
o_mat_t.num=[num{:}]';


end