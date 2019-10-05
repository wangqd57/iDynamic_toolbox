
function [ o_mat_t ] = numberd_wqd( o_mat, key)
o_mat = sortrows(o_mat,key);
o_mat_t=o_mat;
o_mat=table2array(o_mat);

[~,ia,ic] = unique(o_mat(:,key), 'rows');
num=arrayfun(@(i, j) (i:j), ones(size(ia))', accumarray(ic,1)', 'un', 0);
o_mat_t.num=[num{:}]';


end