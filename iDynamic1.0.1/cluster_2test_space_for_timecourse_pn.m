function [t_mapwd,mapl_cwd]= cluster_2test_timespace(data_wd,mask,n1,bootnum,p_value,background)
parpool (4)

% based on raw group difference
difmap=squeeze(mean(data_wd(:,:,:,1:n1),4)-mean(data_wd(:,:,:,n1+1:end),4));
% extract background and normalize image to [0 64]
%timen=size(data_wd,3);
parfor j=1:bootnum
    data_wd_b=data_wd(:,:,:,randperm(size(data_wd,4)));
    difmap_b(:,:,:,j)=squeeze(mean(data_wd_b(:,:,:,1:n1),4)-mean(data_wd_b(:,:,:,n1+1:end),4));
end

difmap_z=squeeze((difmap-mean(difmap_b,4))./std(difmap_b,[],4));
difmap_z(isnan(difmap_z))=0;

difmap_p=(1-normcdf(abs(difmap_z)))*2; % for two tailed
difmap_zthresh=difmap_p;
difmap_zthresh(difmap_zthresh > p_value) = 0;
difmap_zthresh=difmap_zthresh.*mask;
difmap_zthresh(difmap_zthresh~=0)=1;
[mapl0,nblobs0] = bwlabeln(difmap_zthresh,18);
clustsum_dif_all=[];
for pn=1:2
    if pn==1  % positive
        id_pn = (difmap_z > 0);
    else
        id_pn= (difmap_z < 0);
    end
    mask_pn=zeros(size(difmap_z));
    mask_pn(id_pn)=1;
    difmap_zthresh_pn=difmap_zthresh.*mask_pn;
    
    [mapl0_temp,nblobs0_temp] = bwlabeln(difmap_zthresh_pn,18);
    clustcount_dif = zeros(1,nblobs0_temp);
    clustsum_dif   = zeros(1,nblobs0_temp);
    for i=1:nblobs0_temp
        clustcount_dif(i) = sum(mapl0_temp(:)==i);
        clustsum_dif(i)   = sum(difmap_z(mapl0_temp(:)==i));   %% sum z in clusters
    end
    clustsum_dif_all=[clustsum_dif_all clustsum_dif];
    
end



%% maxz for boot
tic;
max_z=[];
for j=1:bootnum
    j
    difmap_z_b=squeeze((difmap_b(:,:,:,j)-mean(difmap_b,4))./std(difmap_b,[],4));
    difmap_z_b(isnan(difmap_z_b))=0;
    difmap_b_p=(1-normcdf(ab    s(difmap_z_b)))*2; % for two tailed
    difmap_b_zthresh=difmap_b_p;
    difmap_b_zthresh(difmap_b_zthresh > p_value) = 0;
    difmap_b_zthresh=difmap_b_zthresh.*mask;
    % positive & negative separated
    for pn=1:2
        if pn==1  % positive
            id_pn = (difmap_z_b > 0);
        else
            id_pn= (difmap_z_b < 0);
        end
        mask_pn=zeros(size(difmap_z_b));
        mask_pn(id_pn)=1;
        difmap_b_zthresh_pn=difmap_b_zthresh.*mask_pn;
        [mapl,nblobs] = bwlabeln(difmap_b_zthresh_pn,18);
        clustcount_b_dif = zeros(1,nblobs);
        clustsum_b_dif   = zeros(1,nblobs);
        for i=1:nblobs
            clustcount_b_dif(i) = sum(mapl(:)==i);
            clustsum_b_dif(i)   = sum(difmap_z_b(mapl(:)==i));   %% sum z in clusters
        end
        if isempty(clustsum_b_dif)
            max_z_pn(pn)=0;
        else
            [a,aid]=max(abs(clustsum_b_dif));
            max_z_pn(pn)=clustsum_b_dif(aid);
        end
    end
    [a,aid]=max(abs(max_z_pn));
    max_z(j)=max_z_pn(aid);
end

toc
figure();
hist(max_z,100)

%% significant test
%prctile(max_z,97.5)
%prctile(max_z,2.5)
clustsum_dif_z=(clustsum_dif_all-mean(max_z))./std(max_z);
final_p=(1-normcdf(abs(clustsum_dif_z)))*2; % for two tailed
cluster_id = find(final_p > p_value);
cluster_id=[1 3 5];
difmap_zthresh2=difmap_zthresh;
for i=1:size(cluster_id,2)
    mapl0(mapl0==cluster_id(i))=0;
end


end