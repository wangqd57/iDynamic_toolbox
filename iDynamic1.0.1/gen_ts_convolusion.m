%% by Qiandong Wang 2019.2.26 at PKU

function [t_data_1,t_data_]=gen_ts_convolusion(t_s,sr,e_time,samp_num,AOI,AOI_colnum,trial_colnum,Group_Var)
kernel_qd = [repmat(1,1,samp_num)];

data=table2array(t_s);
data(data(:,AOI_colnum)~=AOI,AOI_colnum)=0;
data(:,AOI_colnum)=data(:,AOI_colnum)./AOI;
convolution_result_fft=conv(data(:,AOI_colnum),kernel_qd,'same');
data(:,AOI_colnum)=convolution_result_fft;

[ t_data_11 ] = spread( data,[Group_Var trial_colnum], AOI_colnum, sr.*e_time);
name=t_s.Properties.VariableNames([Group_Var trial_colnum]);
t_data_1=array2table(t_data_11);
t_data_1.Properties.VariableNames(1:length(name))=name;


t_data_1=[t_data_1(:,1:length(name)) t_data_1(:,length(kernel_qd)/2+length(name):sr.*e_time-length(kernel_qd)/2+length(name))];
  
t_data_ = varfun(@nanmean,t_data_1,'GroupingVariables',[1:length(Group_Var)], 'InputVariables',[length(name)+1:size(t_data_1,2)],'OutputFormat','table'); %
end


%%%%这里没啥用
 %加了condition_all这个变量，用来标注所有实验条件
                                %1是ASD_angry，2是ASD_happy,3是TD_angry,4是TD_happy