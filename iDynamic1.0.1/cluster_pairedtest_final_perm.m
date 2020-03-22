function [sumt, sig_time,max_z,time_pn2]= cluster_pairedtest_final_perm(data_wd,n1,n2,bootnum,p_value)
%% n1是第一组数据的终点行,n2是第几列数据
'paired_perm'
%先算原样本的t值
data_wd=data_wd(:,n2:end);
difmap=nanmean(data_wd(1:n1,:))-nanmean(data_wd(n1+1:end,:));
%boot
difmap_b=[];
for j=1:bootnum
    %id_b=randsample(size(data_wd,1),size(data_wd,1),false);
    %data_wdb=data_wd(id_b,:);
    id_b=double(int16(rand(n1,1)));
	id_b2=1-id_b;
	id_b=[id_b;id_b2];
    data_wdb=[id_b,data_wd];
	data_wdb=sortrows(data_wdb,1);
	data_wdb(:,1)=[];
    difmap_b(j,:)=nanmean(data_wdb(1:n1,:))-nanmean(data_wdb(n1+1:end,:));
end

difmap_z=(difmap-nanmean(difmap_b,1))./nanstd(difmap_b,[],1);
difmap_z(isnan(difmap_z))=0;

difmap_p=(1-normcdf(abs(difmap_z)))*2; % for two tailed
difmap_zthresh=difmap_p;
difmap_zthresh(difmap_zthresh >= p_value) = 10;
difmap_zthresh(difmap_zthresh~=10)=1;
difmap_zthresh(difmap_zthresh==10)=0;
sumt_id = bwconncomp(difmap_zthresh);
sig_time=sumt_id.PixelIdxList;
%clustsum_dif_all=[];
sumt=[];
for clusteri=1:sumt_id.NumObjects
        cluster_temp=sumt_id.PixelIdxList{clusteri};
        sumt(clusteri)=(sum(difmap_z(cluster_temp)));
end

%%
max_z=[];
for j=1:bootnum
    difmap_z_b=(difmap_b(j,:)-mean(difmap_b,1))./std(difmap_b,[],1);
    difmap_z_b(isnan(difmap_z_b))=0;
    difmap_b_p=(1-normcdf(abs(difmap_z_b)))*2; % for two tailed
    difmap_b_zthresh=difmap_b_p;
    difmap_b_zthresh(difmap_b_zthresh >= p_value) = 10;
    difmap_b_zthresh(difmap_b_zthresh~=10)=1;
    difmap_b_zthresh(difmap_b_zthresh==10)=0;
    sumt_id_b = bwconncomp(difmap_b_zthresh);
    %clustsum_dif_all=[];
    sumt_b=[];
    for clusteri=1:sumt_id_b.NumObjects
        cluster_temp=sumt_id_b.PixelIdxList{clusteri};
        sumt_b(clusteri)=(sum(difmap_z_b(cluster_temp)));
        
    end
    [a,aid]=max(abs(sumt_b));
    if isempty(aid)
        max_z(j)=0;
    else
        max_z(j)=sumt_b(aid);
    end
end
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% non distribution %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clustsum_dif_z=(sumt-mean(max_z))./std(max_z);
final_p=(1-normcdf(abs(clustsum_dif_z)))*2; % for two tailed
cluster_id = find(final_p < p_value);
if isempty(cluster_id)
    time_pn2=[];
else
    time_pn2=sig_time(cluster_id);
end

save ('sig_time_period_perm.mat','time_pn2');

end
% id_positive=(sumt_positive>prctile(t_max,100-p_value./2*100));
% id_negative=(sumt_negative>abs(prctile(t_max,p_value./2*100)));
% time_negative2=time_negative(id_negative);
% time_positive2=time_positive(id_positive);

%prctile(t_max,97.5)
%%  提取positive 和 negative中最大的
