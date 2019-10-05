function [H_all_t, H_rand_t, H_trial_t]=entropy_fix_average(t_s, sub_col, trial_col, group_var, fix_pos_col, fixDur_col, sr, validNum, pw, ph, scale,sigma,SizeWH)

data_ent=table2array(t_s);
G = fspecial('gaussian', [SizeWH SizeWH], sigma);
%[ySize2,xSize2]=size(imresize(ones(ySize,xSize),scale,'nearest'));
heat_map1=[];
heat_map2=[];
ent_data_all=[];
name=t_s.Properties.VariableNames([sub_col trial_col group_var]);

h_waitbar=waitbar(0,'请稍等');
num=0;
for sub=  min(data_ent(:,sub_col)):max(data_ent(:,sub_col))
	num=num+1;
    subdata2=data_ent( data_ent(:, sub_col)==sub, :);
    if isempty(subdata2)
        continue;
    end
    triali=unique(subdata2(:,trial_col));
    for j=1:length(triali)
        subdata=(subdata2(subdata2(:,trial_col)==triali(j),:));
        gazedata=round(subdata(:,fix_pos_col));
        if fixDur_col~=0
            gazedata=[gazedata subdata(:,fixDur_col)];
        end
        index=(gazedata(:,1)<=0 | gazedata(:,2)<=0 | gazedata(:,1)>pw | gazedata(:,2)>ph);
        sample_invalid=sum(index); %无效采样点数据
        gazedata(index,:)=[];
        %         %去掉不看脸的数据,你也可以关注整个屏幕的数据
        %         idnoface=(subdata(:,16)==5|subdata(:,16)==0); %
        %         subdata(idnoface,:)=[];
        
        %num_gaze=size(gazedata,1);
        %heat_map1 = accumarray(gazedata, 1/120)./num_gaze;  %标准化到有效gazed ata
        if fixDur_col==0
            heat_map1 = accumarray(gazedata, 1/sr); %参考的论文中没有标准化
        else
            heat_map1 = accumarray(gazedata(:,1:2), gazedata(:,3)); %参考的论文中没有标准化
        end
        heat_map1=flipud(rot90(heat_map1));
        heat_map1(ph,pw)=0;
        heat_map2 = imfilter(heat_map1,G,'replicate');
        heat_map2=imresize(heat_map2,scale,'nearest');
        ent_data_all=[ent_data_all; [subdata(1, [sub_col trial_col group_var]) heat_map2(:)']];
    end
	waitbar(num/length(unique(data_ent(:,sub_col))));
end
%% TEST
% ent_data_all_t2=array2table(ent_data_all);
% ent_data_all_t2=ent_data_all_t2(:,1:8);
% ent_data_all_t2= numberd_wqd_v2( ent_data_all_t2, [1, 3:(3+length(group_var)-1)], 0);
% 
%% 每个试次自己的熵
hist_trial=bsxfun(@rdivide,ent_data_all(:,(length(name)+1:end)),sum(ent_data_all(:,(length(name)+1:end)),2));
hist_trial(hist_trial==0)=0.0000000000001;  
H_trial=-sum(hist_trial.*log2(hist_trial),2);

H_trial_t=array2table(ent_data_all(:,1:length(name)+1));
name2=name;
name2{length(name2)+1}='entropy';
H_trial_t.Properties.VariableNames=name2;
H_trial_t.entropy=H_trial;
%%
ent_data_all_t=array2table(ent_data_all);
ent_data_all_t= numberd_wqd_v2( ent_data_all_t, [1, 3:(3+length(group_var)-1)], 1);
ent_data_all_t.Properties.VariableNames(1:length(name))=name;
%%
ent_data_all_ave_t= varfun(@nanmean,ent_data_all_t,'GroupingVariables',[1, 3:(3+length(group_var)-1)], 'InputVariables',[length(name)+1:size(ent_data_all,2)],'OutputFormat','table'); %
%a=ent_data_all_t(ent_data_all_t.num<=validNum,:);
ent_data_rand_ave_t= varfun(@nanmean,ent_data_all_t(ent_data_all_t.num<=validNum,:),'GroupingVariables',[1, 3:(3+length(group_var)-1)], 'InputVariables',[length(name)+1:size(ent_data_all,2)],'OutputFormat','table'); %
hist_all=bsxfun(@rdivide,table2array(ent_data_all_ave_t(:,(length(name)+1:end))),sum(table2array(ent_data_all_ave_t(:,(length(name)+1:end))),2));
hist_rand=bsxfun(@rdivide,table2array(ent_data_rand_ave_t(:,(length(name)+1:end))),sum(table2array(ent_data_rand_ave_t(:,(length(name)+1:end))),2));
hist_all(hist_all==0)=0.0000000000001;  
hist_rand(hist_rand==0)=0.0000000000001;  

H_all=-sum(hist_all.*log2(hist_all),2);
H_rand=-sum(hist_rand.*log2(hist_rand),2);

H_all_t=ent_data_all_ave_t(:,1:length(name)+1);
H_all_t.Properties.VariableNames{length(name)+1}='entropy';
H_all_t.entropy=H_all;

H_rand_t=ent_data_rand_ave_t(:,1:length(name)+1);
H_rand_t.Properties.VariableNames{length(name)+1}='entropy';
H_rand_t.entropy=H_rand;

close(h_waitbar);
end

