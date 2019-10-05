function [sumt_negative, time_negative,t_max_n,sumt_positive, time_positive,t_max_p, t_max, z_n,z_p,time_positive2,time_negative2]= cluster_2test_final(data_wd,n1,n2,bootnum,p_value)
%% n1是第一组数据的终点行,n2是第几列数据
'ind'
%先算原样本的t值
data_wd=data_wd(:,n2:end);
for i=1:size(data_wd,2)
    data1=data_wd(1:n1,i)';
    data2=data_wd(n1+1:end,i)';
    [h,p,ci,stats] = ttest2(data1,data2);
    p0(i)=p;
    t0(i)=stats.tstat;    
end
        
%boot
for j=1:bootnum
    id_b=randsample(size(data_wd,1),size(data_wd,1),false);
    data_wdb=data_wd(id_b,:);
    for k=1:size(data_wd,2)
        data1=data_wdb(1:n1,k)';
        data2=data_wdb(n1+1:end,k)';
        [h,p,ci,stats] = ttest2(data1,data2);
        pb(j,k)=p;
        tb(j,k)=stats.tstat;
    end
end
% combine data
t_all=[t0;tb];
p_all=[p0;pb];
clear t0 p0 tb pb

%cluster
%% for negative t value bwconncomp
m=1;
p_temp=p_all(m,:);
t_temp=t_all(m,:);
id_temp=(p_temp<p_value & t_temp<0);
sumt_negative_id=bwconncomp(id_temp);
if isempty(sumt_negative_id.PixelIdxList)
    sumt_negative=[];
    time_negative=[];
else
     sumt_negative=zeros(1,sumt_negative_id.NumObjects);
     time_negative=sumt_negative_id.PixelIdxList;
    for clusteri=1:sumt_negative_id.NumObjects
        cluster_temp=sumt_negative_id.PixelIdxList{clusteri};
        sumt_negative(clusteri)=abs(sum(t_temp(cluster_temp)));
     
    end
    
end
    
%% for positive t value
m=1;
p_temp=p_all(m,:);
t_temp=t_all(m,:);
id_temp=(p_temp<p_value & t_temp>0);
sumt_positive_id=bwconncomp(id_temp);
if isempty(sumt_positive_id.PixelIdxList)
    sumt_positive=[];
    time_positive=[];
else
    sumt_positive=zeros(1,sumt_positive_id.NumObjects);
    time_positive=sumt_positive_id.PixelIdxList;
    for clusteri=1:sumt_positive_id.NumObjects
        cluster_temp=sumt_positive_id.PixelIdxList{clusteri};
        sumt_positive(clusteri)=abs(sum(t_temp(cluster_temp)));
    end
end
%% 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% non distribution %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% negative   
for m=2:bootnum+1
    p_temp=p_all(m,:);
    t_temp=t_all(m,:);
    id_temp=(p_temp<p_value & t_temp<0);
    sumt_negative_id=bwconncomp(id_temp);
    if isempty(sumt_negative_id.PixelIdxList)
        sumt_negative1=0;
        
    else
        sumt_negative1=zeros(1,sumt_negative_id.NumObjects);
       
        for clusteri=1:sumt_negative_id.NumObjects
            cluster_temp=sumt_negative_id.PixelIdxList{clusteri};
            sumt_negative1(clusteri)=abs(sum(t_temp(cluster_temp)));
            
        end
        
    end
    t_max_n(m-1)=max(sumt_negative1);
end

               
   
%prctile(t_max_n,97.5);

%% for positive t value
for m=2:bootnum+1
    p_temp=p_all(m,:);
    t_temp=t_all(m,:);
    id_temp=(p_temp<p_value & t_temp>0);
    sumt_negative_id=bwconncomp(id_temp);
    if isempty(sumt_negative_id.PixelIdxList)
        sumt_negative1=0;
        
    else
        sumt_negative1=zeros(1,sumt_negative_id.NumObjects);
       
        for clusteri=1:sumt_negative_id.NumObjects
            cluster_temp=sumt_negative_id.PixelIdxList{clusteri};
            sumt_negative1(clusteri)=abs(sum(t_temp(cluster_temp)));
            
        end
        
    end
    t_max_p(m-1)=max(sumt_negative1);
end
%prctile(t_max_p,97.5)
%%
t_max_n=-t_max_n;
t_max=zeros(1,bootnum);
for i=1:bootnum
	tempv=t_max_n(i)+t_max_p(i);
	if tempv>0
		t_max(i)=t_max_p(i);
	elseif tempv<0
		t_max(i)=t_max_n(i);
	else
		t_max(i)=0;
	end
%%
end
id_positive=(sumt_positive>prctile(t_max,100-p_value./2*100));
id_negative=(sumt_negative>abs(prctile(t_max,p_value./2*100)));
time_negative2=time_negative(id_negative);
time_positive2=time_positive(id_positive);
save ('sig_time_period.mat','time_negative2','time_positive2');
z_n=(-sumt_negative-mean(t_max))./std(t_max);
z_p=(sumt_positive-mean(t_max))./std(t_max);
%prctile(t_max,97.5)
%%  提取positive 和 negative中最大的
