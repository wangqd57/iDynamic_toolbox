function [ n_mat ] = spread( o_mat, key, value, num,missing)
%SPREAD Spread a column array into a row array based on keys

if nargin < 5
    missing = 'post';
end
% Sorting the matrix based on given keys before spreading prevents misaligning
% because UNIQUE returns a sorted unique matrix containing the KEY(s) but the
% VALUE that is about to be spread will not be sorted accordingly.
o_mat = sortrows(o_mat,key);
A = o_mat(:,key);
v = o_mat(:,value);
idx = 1:length(v);
[C,ia,ic] = unique(A, 'rows');
if nargin < 4 || isempty(num)
    max_length = max(accumarray(ic,1));
else
   max_length =num;
end
nan_value = NaN(max_length*length(ia),1);
nudge = cumsum(max_length-accumarray(ic,1));
if strcmp(missing,'post')
    idx_nudge = [0;nudge(1:end-1)];
elseif strcmp(missing, 'pre')
    idx_nudge = nudge;
else
    error('Check your "missing" argument!');
end
new_idx = repelem(idx_nudge,accumarray(ic,1),1) + idx';
nan_value(new_idx) = v;
n_mat = [C, reshape(nan_value, [], length(ia))'];
end

