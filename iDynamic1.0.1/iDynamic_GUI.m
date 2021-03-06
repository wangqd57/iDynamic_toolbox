function iDynamic_GUI(action)
% Author: 王乾东Qiandong Wang 2019.04.21始
global handle %filesset22 datadir EEG

if nargin<1,
    action='start';
end;

%% start initial GUI parameter
if strcmp(action,'start'),
    %     clf reset;
    close all
    handle=[];
    %%% plot handles
    handle.fig1=figure('units','normalize','position',[0.1  0.1 0.8 0.8]);
    
    %% 
    handle.title1=uicontrol('Parent',handle.fig1,...
        'Units','normalized',...
        'Style','Text',...
        'BackgroundColor','white',...
        'ForegroundColor','black',...
        'Position',[0.33 0.92 0.4 0.06],...
        'Fontsize',25,'Fontweight','bold',...
        'String','iDynamic Ver 1.0.1');
    %% temporal course ana
    handle.panel_temporal = uipanel('Parent',handle.fig1,...
        'Units','normalized',...
        'backgroundcolor',[0.8 0.8 0.8],...
        'Title','时程分析',...
        'Position',[0.01    0.6    0.3    0.3],...
        'Fontsize',14,'Fontweight','bold');
    
    % sample rate para
    handle.panel_temporal_text_sr =uicontrol('Parent',handle.panel_temporal,...
        'Units','normalized',...
        'Style','Text',...
        'BackgroundColor','green',...
        'ForegroundColor','black',...
        'Position',[0.02 0.95 0.20 0.1],...
        'Fontsize',12,'Fontweight','bold',...
        'String','sr'); 
    handle.panel_temporal_edit_sr=uicontrol('Parent',handle.panel_temporal,...
        'Units','normalized',...
        'Style','Edit',...
        'BackgroundColor','white',...
        'ForegroundColor','black',...
        'Fontsize',12,'Fontweight','bold',...
        'Position',[0.02 0.84 0.20 0.1],...
        'String','120'); 
     
    % trial duration/s
     handle.panel_temporal_text_td =uicontrol('Parent',handle.panel_temporal,...
        'Units','normalized',...
        'Style','Text',...
        'BackgroundColor','green',...
        'ForegroundColor','black',...
        'Position',[0.24 0.95 0.20 0.1],...
        'Fontsize',12,'Fontweight','bold',...
        'String','trial_dur'); 
    handle.panel_temporal_edit_td=uicontrol('Parent',handle.panel_temporal,...
        'Units','normalized',...
        'Style','Edit',...
        'BackgroundColor','white',...
        'ForegroundColor','black',...
        'Fontsize',12,'Fontweight','bold',...
        'Position',[0.24 0.84 0.20 0.1],...
        'String','2'); 
    
    % sample number
     handle.panel_temporal_text_sn =uicontrol('Parent',handle.panel_temporal,...
        'Units','normalized',...
        'Style','Text',...
        'BackgroundColor','green',...
        'ForegroundColor','black',...
        'Position',[0.46 0.95 0.20 0.1],...
        'Fontsize',12,'Fontweight','bold',...
        'String','samp_num'); 
    handle.panel_temporal_edit_sn =uicontrol('Parent',handle.panel_temporal,...
        'Units','normalized',...
        'Style','Edit',...
        'BackgroundColor','white',...
        'ForegroundColor','black',...
        'Fontsize',12,'Fontweight','bold',...
        'Position',[0.46 0.84 0.20 0.1],...
        'String','30'); 
    
    % AOI
    handle.panel_temporal_text_aoi =uicontrol('Parent',handle.panel_temporal,...
        'Units','normalized',...
        'Style','Text',...
        'BackgroundColor','green',...
        'ForegroundColor','black',...
        'Position',[0.02 0.71 0.20 0.1],...
        'Fontsize',12,'Fontweight','bold',...
        'String','AOI'); 
    handle.panel_temporal_edit_aoi=uicontrol('Parent',handle.panel_temporal,...
        'Units','normalized',...
        'Style','Edit',...
        'BackgroundColor','white',...
        'ForegroundColor','black',...
        'Fontsize',12,'Fontweight','bold',...
        'Position',[0.02 0.60 0.20 0.1],...
        'String','2'); 
    
    % AOI column number
    handle.panel_temporal_text_acn =uicontrol('Parent',handle.panel_temporal,...
        'Units','normalized',...
        'Style','Text',...
        'BackgroundColor','green',...
        'ForegroundColor','black',...
        'Position',[0.24 0.71 0.20 0.1],...
        'Fontsize',12,'Fontweight','bold',...
        'String','AOI_col'); 
    handle.panel_temporal_edit_acn=uicontrol('Parent',handle.panel_temporal,...
        'Units','normalized',...
        'Style','Edit',...
        'BackgroundColor','white',...
        'ForegroundColor','black',...
        'Fontsize',12,'Fontweight','bold',...
        'Position',[0.24 0.60 0.20 0.1],...
        'String','16'); 
    
    % trial column number
    handle.panel_temporal_text_tcn =uicontrol('Parent',handle.panel_temporal,...
        'Units','normalized',...
        'Style','Text',...
        'BackgroundColor','green',...
        'ForegroundColor','black',...
        'Position',[0.46 0.71 0.20 0.1],...
        'Fontsize',12,'Fontweight','bold',...
        'String','trial_col'); 
    handle.panel_temporal_edit_tcn=uicontrol('Parent',handle.panel_temporal,...
        'Units','normalized',...
        'Style','Edit',...
        'BackgroundColor','white',...
        'ForegroundColor','black',...
        'Fontsize',12,'Fontweight','bold',...
        'Position',[0.46 0.60 0.20 0.1],...
        'String','6'); 
    
    % group var
    handle.panel_temporal_text_gv =uicontrol('Parent',handle.panel_temporal,...
        'Units','normalized',...
        'Style','Text',...
        'BackgroundColor','green',...
        'ForegroundColor','black',...
        'Position',[0.68 0.95 0.28 0.1],...
        'Fontsize',12,'Fontweight','bold',...
        'String','Group_Var'); 
    handle.panel_temporal_edit_gv=uicontrol('Parent',handle.panel_temporal,...
        'Units','normalized',...
        'Style','Edit',...
        'BackgroundColor','white',...
        'ForegroundColor','black',...
        'Fontsize',12,'Fontweight','bold',...
        'Position',[0.68 0.84 0.28 0.1],...
        'String','2 1 9'); 
    
    handle.panel_temporal_button_cal =  uicontrol('Parent',handle.panel_temporal,...
        'Units','normalized',...
        'Style','Pushbutton',...
        'BackgroundColor','blue',...
        'Position',[0.68 0.6 0.3 0.2],...
        'Callback','iDynamic_GUI(''moving_window'')',...
        'enable','on',...
        'Fontsize',14,'Fontweight','bold',...
        'String','1滑动平均');
  
    %% stastic
     % number of cond row
    handle.panel_temporal_text_n1 =uicontrol('Parent',handle.panel_temporal,...
        'Units','normalized',...
        'Style','Text',...
        'BackgroundColor','green',...
        'ForegroundColor','black',...
        'Position',[0.02 0.38 0.26 0.12],...
        'Fontsize',12,'Fontweight','bold',...
        'String','CondRow'); 
    handle.panel_temporal_edit_n1=uicontrol('Parent',handle.panel_temporal,...
        'Units','normalized',...
        'Style','Edit',...
        'BackgroundColor','white',...
        'ForegroundColor','black',...
        'Fontsize',12,'Fontweight','bold',...
        'Position',[0.28 0.38 0.1 0.12],...
        'String','10'); 
   
% number of time col
    handle.panel_temporal_text_n2 =uicontrol('Parent',handle.panel_temporal,...
        'Units','normalized',...
        'Style','Text',...
        'BackgroundColor','green',...
        'ForegroundColor','black',...
        'Position',[0.39 0.38 0.26 0.12],...
        'Fontsize',12,'Fontweight','bold',...
        'String','TempCol'); 
    handle.panel_temporal_edit_n2=uicontrol('Parent',handle.panel_temporal,...
        'Units','normalized',...
        'Style','Edit',...
        'BackgroundColor','white',...
        'ForegroundColor','black',...
        'Fontsize',12,'Fontweight','bold',...
        'Position',[0.65 0.38 0.1 0.12],...
        'String','5');     
  
% boot number
    handle.panel_temporal_text_bootnum =uicontrol('Parent',handle.panel_temporal,...
        'Units','normalized',...
        'Style','Text',...
        'BackgroundColor','green',...
        'ForegroundColor','black',...
        'Position',[0.02 0.22 0.24 0.12],...
        'Fontsize',12,'Fontweight','bold',...
        'String','BootNum'); 
    handle.panel_temporal_edit_bootnum=uicontrol('Parent',handle.panel_temporal,...
        'Units','normalized',...
        'Style','Edit',...
        'BackgroundColor','white',...
        'ForegroundColor','black',...
        'Fontsize',12,'Fontweight','bold',...
        'Position',[0.25 0.22 0.13 0.12],...
        'String','1000'); 
    
    % p_value
    handle.panel_temporal_text_p_value =uicontrol('Parent',handle.panel_temporal,...
        'Units','normalized',...
        'Style','Text',...
        'BackgroundColor','green',...
        'ForegroundColor','black',...
        'Position',[0.39 0.22 0.24 0.12],...
        'Fontsize',12,'Fontweight','bold',...
        'String','p_value'); 
    handle.panel_temporal_edit_p_value=uicontrol('Parent',handle.panel_temporal,...
        'Units','normalized',...
        'Style','Edit',...
        'BackgroundColor','white',...
        'ForegroundColor','black',...
        'Fontsize',12,'Fontweight','bold',...
        'Position',[0.63 0.22 0.12 0.12],...
        'String','0.05');
    
    % stat type
    handle.panel_temporal_text_stastype =uicontrol('Parent',handle.panel_temporal,...
        'Units','normalized',...
        'Style','Text',...
        'BackgroundColor','green',...
        'ForegroundColor','black',...
        'Position',[0.76 0.37 0.24 0.12],...
        'Fontsize',12,'Fontweight','bold',...
        'String','统计方法'); 
    handle.panel_temporal_popupmenu_stastype=uicontrol('Parent',handle.panel_temporal,...
        'Units','normalized','Position',[0.76 0.2 0.25 0.17],...
        'Style','Popupmenu',...
        'BackgroundColor',[1 1 1],...
        'String',{'indep_t','paired_t', 'indep_perm','paired_perm'},...
        'enable','on',...
        'Fontsize',7,'Fontweight','bold',...
        'value',1);%,...
       % 'Callback','iDynamic_GUI(''stastype'')');
    
     handle.panel_temporal_button_stat =  uicontrol('Parent',handle.panel_temporal,...
        'Units','normalized',...
        'Style','Pushbutton',...
        'BackgroundColor','blue',...
        'Position',[0.02 0.02 0.3 0.19],...
        'Callback','iDynamic_GUI(''temporal_stat'')',...
        'enable','on',...
        'Fontsize',14,'Fontweight','bold',...
        'String','2统计检验');
    
    % plot
    handle.panel_temporal_button_plot =  uicontrol('Parent',handle.panel_temporal,...
        'Units','normalized',...
        'Style','Pushbutton',...
        'BackgroundColor','blue',...
        'Position',[0.78 0.02 0.20 0.19],...
        'Callback','iDynamic_GUI(''temporal_plot'')',...
        'enable','on',...
        'Fontsize',14,'Fontweight','bold',...
        'String','3画图');
    % number of time col
    handle.panel_temporal_text_tempcol =uicontrol('Parent',handle.panel_temporal,...
        'Units','normalized',...
        'Style','Text',...
        'BackgroundColor','green',...
        'ForegroundColor','black',...
        'Position',[0.5 0.1 0.2 0.10],...
        'Fontsize',10,'Fontweight','bold',...
        'String','TempCol'); 
    handle.panel_temporal_edit_tempcol=uicontrol('Parent',handle.panel_temporal,...
        'Units','normalized',...
        'Style','Edit',...
        'BackgroundColor','white',...
        'ForegroundColor','black',...
        'Fontsize',10,'Fontweight','bold',...
        'Position',[0.70 0.1 0.08 0.1],...
        'String','5');
     % group var
     handle.panel_temporal_text_CondCol =uicontrol('Parent',handle.panel_temporal,...
        'Units','normalized',...
        'Style','Text',...
        'BackgroundColor','green',...
        'ForegroundColor','black',...
        'Position',[0.5 0.002 0.2 0.10],...
        'Fontsize',10,'Fontweight','bold',...
        'String','CondCol'); 
    handle.panel_temporal_edit_CondCol=uicontrol('Parent',handle.panel_temporal,...
        'Units','normalized',...
        'Style','Edit',...
        'BackgroundColor','white',...
        'ForegroundColor','black',...
        'Fontsize',10,'Fontweight','bold',...
        'Position',[0.70 0.002 0.08 0.1],...
        'String','1');  
    
%% Prac_tool 1: visual ang
    handle.panel_pt1 = uipanel('Parent',handle.fig1,...
        'Units','normalized',...
        'backgroundcolor',[0.8 0.8 0.8],...
        'Title','实用工具1：视角和推荐高斯sigma',...
        'Position',[0.32    0.75    0.3    0.15],...
        'Fontsize',14,'Fontweight','bold');
    
    % ScrW_pix
    handle.panel_pt1_text_pw =uicontrol('Parent',handle.panel_pt1,...
        'Units','normalized',...
        'Style','Text',...
        'BackgroundColor','green',...
        'ForegroundColor','black',...
        'Position',[0.02 0.8 0.20 0.25],...
        'Fontsize',10,'Fontweight','bold',...
        'String','ScrW_pix'); 
    handle.panel_pt1_edit_pw=uicontrol('Parent',handle.panel_pt1,...
        'Units','normalized',...
        'Style','Edit',...
        'BackgroundColor','white',...
        'ForegroundColor','black',...
        'Fontsize',10,'Fontweight','bold',...
         'Callback','iDynamic_GUI(''deg2pix'')',...
        'Position',[0.02 0.58 0.20 0.25],...
        'String','1920'); 
    % ScrH_pix
    handle.panel_pt1_text_ph =uicontrol('Parent',handle.panel_pt1,...
        'Units','normalized',...
        'Style','Text',...
        'BackgroundColor','green',...
        'ForegroundColor','black',...
        'Position',[0.24 0.8 0.20 0.25],...
        'Fontsize',10,'Fontweight','bold',...
        'String','ScrH_pix'); 
    handle.panel_pt1_edit_ph=uicontrol('Parent',handle.panel_pt1,...
        'Units','normalized',...
        'Style','Edit',...
        'BackgroundColor','white',...
        'ForegroundColor','black',...
        'Fontsize',10,'Fontweight','bold',...
        'Position',[0.24 0.58 0.20 0.25],...
        'String','1080'); 
    
     % ScrW_cm
    handle.panel_pt1_text_ScrWidth =uicontrol('Parent',handle.panel_pt1,...
        'Units','normalized',...
        'Style','Text',...
        'BackgroundColor','green',...
        'ForegroundColor','black',...
        'Position',[0.46 0.8 0.20 0.25],...
        'Fontsize',10,'Fontweight','bold',...
        'String','ScrW_cm'); 
    handle.panel_pt1_edit_ScrWidth=uicontrol('Parent',handle.panel_pt1,...
        'Units','normalized',...
        'Style','Edit',...
        'BackgroundColor','white',...
        'ForegroundColor','black',...
        'Fontsize',10,'Fontweight','bold',...
        'Callback','iDynamic_GUI(''deg2pix'')',...
        'Position',[0.46 0.58 0.20 0.25],...
        'String','47.6'); 
    
 % ScrH_cm
    handle.panel_pt1_text_ScrHeight =uicontrol('Parent',handle.panel_pt1,...
        'Units','normalized',...
        'Style','Text',...
        'BackgroundColor','green',...
        'ForegroundColor','black',...
        'Position',[0.68 0.8 0.20 0.25],...
        'Fontsize',10,'Fontweight','bold',...
        'String','ScrH_cm'); 
    handle.panel_pt1_edit_ScrHeight=uicontrol('Parent',handle.panel_pt1,...
        'Units','normalized',...
        'Style','Edit',...
        'BackgroundColor','white',...
        'ForegroundColor','black',...
        'Fontsize',10,'Fontweight','bold',...
        'Position',[0.68 0.58 0.20 0.25],...
        'String','26.1');    
    
    % viewDist
    handle.panel_pt1_text_viewDist =uicontrol('Parent',handle.panel_pt1,...
        'Units','normalized',...
        'Style','Text',...
        'BackgroundColor','green',...
        'ForegroundColor','black',...
        'Position',[0.02 0.22 0.20 0.25],...
        'Fontsize',10,'Fontweight','bold',...
        'String','View_Dist'); 
    handle.panel_pt1_edit_viewDist=uicontrol('Parent',handle.panel_pt1,...
        'Units','normalized',...
        'Style','Edit',...
        'BackgroundColor','white',...
        'ForegroundColor','black',...
        'Fontsize',10,'Fontweight','bold',...
        'Position',[0.02 0.0 0.20 0.25],...
        'Callback','iDynamic_GUI(''deg2pix'')',...
        'String','60');    
    
    % deg2pix
    handle.panel_pt1_text_deg2pix =uicontrol('Parent',handle.panel_pt1,...
        'Units','normalized',...
        'Style','Text',...
        'BackgroundColor','blue',...
        'ForegroundColor','black',...
        'Position',[0.46 0.22 0.20 0.25],...
        'Fontsize',10,'Fontweight','bold',...
        'String','deg2pix'); 
    %now calculate how many pixels correspond to 1 deg visual angle
    ScrWidth=str2num(get(handle.panel_pt1_edit_ScrWidth, 'String'));
    viewDist=str2num(get(handle.panel_pt1_edit_viewDist, 'String'));
    pw=str2num(get(handle.panel_pt1_edit_pw, 'String'));
    widthDeg = round(2*180*atan(ScrWidth/(2*viewDist))/pi);
    deg2pix  = round(pw/widthDeg);
    handle.panel_pt1_edit_deg2pix=uicontrol('Parent',handle.panel_pt1,...
        'Units','normalized',...
        'Style','Edit',...
        'BackgroundColor','white',...
        'ForegroundColor','black',...
        'Fontsize',10,'Fontweight','bold',...
        'Position',[0.46 0.0 0.20 0.25],...
        'String',num2str(deg2pix));    
    
    % sigma
    handle.panel_pt1_text_sigma =uicontrol('Parent',handle.panel_pt1,...
        'Units','normalized',...
        'Style','Text',...
        'BackgroundColor','blue',...
        'ForegroundColor','black',...
        'Position',[0.68 0.22 0.20 0.25],...
        'Fontsize',10,'Fontweight','bold',...
        'String','sigma'); 
    sigma=round(2*deg2pix./(sqrt(8*log(2)))); %半距全宽为2°
    handle.panel_pt1_edit_sigma=uicontrol('Parent',handle.panel_pt1,...
        'Units','normalized',...
        'Style','Edit',...
        'BackgroundColor','white',...
        'ForegroundColor','black',...
        'Fontsize',10,'Fontweight','bold',...
        'Position',[0.68 0.0 0.20 0.25],...
        'String',num2str(sigma));    
    
  %% Prac_tool 2: 2D Gauss
    handle.panel_pt2 = uipanel('Parent',handle.fig1,...
        'Units','normalized',...
        'backgroundcolor',[0.8 0.8 0.8],...
        'Title','实用工具2：2D高斯',...
        'Position',[0.32    0.60    0.3    0.13],...
        'Fontsize',14,'Fontweight','bold');
    
    % sigma
    handle.panel_pt2_text_sigma =uicontrol('Parent',handle.panel_pt2,...
        'Units','normalized',...
        'Style','Text',...
        'BackgroundColor','green',...
        'ForegroundColor','black',...
        'Position',[0.02 0.5 0.20 0.35],...
        'Fontsize',10,'Fontweight','bold',...
        'String','sigma'); 
    handle.panel_pt2_edit_sigma=uicontrol('Parent',handle.panel_pt2,...
        'Units','normalized',...
        'Style','Edit',...
        'BackgroundColor','white',...
        'ForegroundColor','black',...
        'Fontsize',10,'Fontweight','bold',...
        'Position',[0.02 0.24 0.20 0.35],...
        'String','38');   
    % gauss szie
    handle.panel_pt2_text_SizeWH =uicontrol('Parent',handle.panel_pt2,...
        'Units','normalized',...
        'Style','Text',...
        'BackgroundColor','green',...
        'ForegroundColor','black',...
        'Position',[0.24 0.5 0.20 0.35],...
        'Fontsize',10,'Fontweight','bold',...
        'String','SizeWH'); 
    handle.panel_pt2_edit_SizeWH=uicontrol('Parent',handle.panel_pt2,...
        'Units','normalized',...
        'Style','Edit',...
        'BackgroundColor','white',...
        'ForegroundColor','black',...
        'Fontsize',10,'Fontweight','bold',...
        'Position',[0.24 0.24 0.20 0.35],...
        'String','228');   
    handle.panel_pt2_button_caussplot =  uicontrol('Parent',handle.panel_pt2,...
        'Units','normalized',...
        'Style','Pushbutton',...
        'BackgroundColor','blue',...
        'Position',[0.68 0.24 0.2 0.7],...
        'Callback','iDynamic_GUI(''caussplot'')',...
        'enable','on',...
        'Fontsize',14,'Fontweight','bold',...
        'String','高斯图');
    
     %% eyemovement entropy
    handle.panel_fixEnt = uipanel('Parent',handle.fig1,...
        'Units','normalized',...
        'backgroundcolor',[0.8 0.8 0.8],...
        'Title','眼动注视熵',...
        'Position',[0.6288    0.6    0.36    0.3],...
        'Fontsize',14,'Fontweight','bold');
    
    % stim xysize
    handle.panel_fixEnt_text_xsize =uicontrol('Parent',handle.panel_fixEnt,...
        'Units','normalized',...
        'Style','Text',...
        'BackgroundColor','green',...
        'ForegroundColor','black',...
        'Position',[0.02 0.85 0.16 0.15],...
        'Fontsize',10,'Fontweight','bold',...
        'String','xSize'); 
    handle.panel_fixEnt_edit_xsize=uicontrol('Parent',handle.panel_fixEnt,...
        'Units','normalized',...
        'Style','Edit',...
        'BackgroundColor','white',...
        'ForegroundColor','black',...
        'Fontsize',10,'Fontweight','bold',...
        'enable','off',...
        'Position',[0.02 0.8 0.16 0.1],...
        'String','1920'); 
    handle.panel_fixEnt_text_ysize =uicontrol('Parent',handle.panel_fixEnt,...
        'Units','normalized',...
        'Style','Text',...
        'BackgroundColor','green',...
        'ForegroundColor','black',...
        'Position',[0.19 0.85 0.16 0.15],...
        'Fontsize',10,'Fontweight','bold',...
        'String','ySize'); 
    handle.panel_fixEnt_edit_ysize=uicontrol('Parent',handle.panel_fixEnt,...
        'Units','normalized',...
        'Style','Edit',...
        'BackgroundColor','white',...
        'ForegroundColor','black',...
        'Fontsize',10,'Fontweight','bold',...
        'enable','off',...
        'Position',[0.19 0.8 0.16 0.1],...
        'String','1080'); 
    
    % scale factor
    handle.panel_fixEnt_text_scale =uicontrol('Parent',handle.panel_fixEnt,...
        'Units','normalized',...
        'Style','Text',...
        'BackgroundColor','green',...
        'ForegroundColor','black',...
        'Position',[0.36 0.85 0.16 0.15],...
        'Fontsize',10,'Fontweight','bold',...
        'String','Scale');
    handle.panel_fixEnt_edit_scale=uicontrol('Parent',handle.panel_fixEnt,...
        'Units','normalized',...
        'Style','Edit',...
        'BackgroundColor','white',...
        'ForegroundColor','black',...
        'Fontsize',10,'Fontweight','bold',...
        'Position',[0.36 0.8 0.16 0.1],...
        'String','0.2');
    
 % max tial number
    handle.panel_fixEnt_text_validNum =uicontrol('Parent',handle.panel_fixEnt,...
        'Units','normalized',...
        'Style','Text',...
        'BackgroundColor','green',...
        'ForegroundColor','black',...
        'Position',[0.53 0.85 0.16 0.15],...
        'Fontsize',10,'Fontweight','bold',...
        'String','validNum');
    handle.panel_fixEnt_edit_validNum=uicontrol('Parent',handle.panel_fixEnt,...
        'Units','normalized',...
        'Style','Edit',...
        'BackgroundColor','white',...
        'ForegroundColor','black',...
        'Fontsize',10,'Fontweight','bold',...
        'Position',[0.53 0.8 0.16 0.1],...
        'String','8');    
    
    % sub col
    handle.panel_fixEnt_text_subCol =uicontrol('Parent',handle.panel_fixEnt,...
        'Units','normalized',...
        'Style','Text',...
        'BackgroundColor','green',...
        'ForegroundColor','black',...
        'Position',[0.7 0.85 0.16 0.15],...
        'Fontsize',10,'Fontweight','bold',...
        'String','subCol');
    handle.panel_fixEnt_edit_subCol=uicontrol('Parent',handle.panel_fixEnt,...
        'Units','normalized',...
        'Style','Edit',...
        'BackgroundColor','white',...
        'ForegroundColor','black',...
        'Fontsize',10,'Fontweight','bold',...
        'Position',[0.7 0.8 0.16 0.1],...
        'String','1');    
    
     % trial col
    handle.panel_fixEnt_text_trialCol =uicontrol('Parent',handle.panel_fixEnt,...
        'Units','normalized',...
        'Style','Text',...
        'BackgroundColor','green',...
        'ForegroundColor','black',...
        'Position',[0.02 0.62 0.16 0.15],...
        'Fontsize',10,'Fontweight','bold',...
        'String','trialCol');
    handle.panel_fixEnt_edit_trialCol=uicontrol('Parent',handle.panel_fixEnt,...
        'Units','normalized',...
        'Style','Edit',...
        'BackgroundColor','white',...
        'ForegroundColor','black',...
        'Fontsize',10,'Fontweight','bold',...
        'Position',[0.02 0.56 0.16 0.1],...
        'String','6');   
    
    
    % group var
    handle.panel_fixEnt_text_groupVar =uicontrol('Parent',handle.panel_fixEnt,...
        'Units','normalized',...
        'Style','Text',...
        'BackgroundColor','green',...
        'ForegroundColor','black',...
        'Position',[0.19 0.62 0.16 0.15],...
        'Fontsize',10,'Fontweight','bold',...
        'String','groupVar');
    handle.panel_fixEnt_edit_groupVar=uicontrol('Parent',handle.panel_fixEnt,...
        'Units','normalized',...
        'Style','Edit',...
        'BackgroundColor','white',...
        'ForegroundColor','black',...
        'Fontsize',10,'Fontweight','bold',...
        'Position',[0.19 0.56 0.16 0.1],...
        'String','2 9');    
    
     % xy pos
    handle.panel_fixEnt_text_fixPosCol =uicontrol('Parent',handle.panel_fixEnt,...
        'Units','normalized',...
        'Style','Text',...
        'BackgroundColor','green',...
        'ForegroundColor','black',...
        'Position',[0.36 0.62 0.16 0.15],...
        'Fontsize',10,'Fontweight','bold',...
        'String','xyPos');
    handle.panel_fixEnt_edit_fixPosCol=uicontrol('Parent',handle.panel_fixEnt,...
        'Units','normalized',...
        'Style','Edit',...
        'BackgroundColor','white',...
        'ForegroundColor','black',...
        'Fontsize',10,'Fontweight','bold',...
        'Position',[0.36 0.56 0.16 0.1],...
        'String','3 4');    
    
     % fixDur_col
    handle.panel_fixEnt_text_fixDurCol =uicontrol('Parent',handle.panel_fixEnt,...
        'Units','normalized',...
        'Style','Text',...
        'BackgroundColor','green',...
        'ForegroundColor','black',...
        'Position',[0.53 0.62 0.16 0.15],...
        'Fontsize',10,'Fontweight','bold',...
        'String','fixDurCol');
    handle.panel_fixEnt_edit_fixDurCol=uicontrol('Parent',handle.panel_fixEnt,...
        'Units','normalized',...
        'Style','Edit',...
        'BackgroundColor','white',...
        'ForegroundColor','black',...
        'Fontsize',10,'Fontweight','bold',...
        'Position',[0.53 0.56 0.16 0.1],...
        'String','0');   
    
    % sample rate
    handle.panel_fixEnt_text_sr =uicontrol('Parent',handle.panel_fixEnt,...
        'Units','normalized',...
        'Style','Text',...
        'BackgroundColor','green',...
        'ForegroundColor','black',...
        'Position',[0.7 0.62 0.16 0.15],...
        'Fontsize',10,'Fontweight','bold',...
        'String','sr');
    handle.panel_fixEnt_edit_sr=uicontrol('Parent',handle.panel_fixEnt,...
        'Units','normalized',...
        'Style','Edit',...
        'BackgroundColor','white',...
        'ForegroundColor','black',...
        'Fontsize',10,'Fontweight','bold',...
        'Position',[0.7 0.56 0.16 0.1],...
        'String','120');    
    
     handle.panel_fixEnt_button_aveEnt =  uicontrol('Parent',handle.panel_fixEnt,...
        'Units','normalized',...
        'Style','Pushbutton',...
        'BackgroundColor','blue',...
        'Position',[0.865 0.60 0.13 0.56],...
        'Callback','iDynamic_GUI(''aveEnt'')',...
        'enable','on',...
        'Fontsize',10,'Fontweight','bold',...
        'String','aveEnt'); 
    
%% call back   panel_temporal_edit_td
elseif strcmp(action,'moving_window'),   %  choose data file, and calculate temporal course based on moving window method
    [filename, pathname] = uigetfile({'*.csv'},'Select the CSV-file');  
    t_s=readtable([pathname filename]);
    sr=get(handle.panel_temporal_edit_sr, 'String');
    sr=str2num(sr);
    trial_dur=str2num(get(handle.panel_temporal_edit_td, 'String'));
    samp_num=str2num(get(handle.panel_temporal_edit_sn, 'String'));
    AOI=str2num(get(handle.panel_temporal_edit_aoi, 'String'));
    AOI_colnum=str2num(get(handle.panel_temporal_edit_acn, 'String'));
    trial_colnum=str2num(get(handle.panel_temporal_edit_tcn, 'String'));
    Group_Var=str2num(get(handle.panel_temporal_edit_gv, 'String'));
    [t_data1,t_data2] = gen_ts_convolusion(t_s,sr,trial_dur,samp_num,AOI,AOI_colnum,trial_colnum,Group_Var);
    writetable(t_data1, 't_data1.csv');
    writetable(t_data2, 't_data2.csv');
    h=msgbox('计算完成', '');
elseif strcmp(action,'temporal_stat'),  % do stat
    [filename, pathname] = uigetfile({'*.csv'},'Select the CSV-file');
    t_s=readtable([pathname filename]);
    data_wd=table2array(t_s);
    n1=str2num(get(handle.panel_temporal_edit_n1, 'String'));
    n2=str2num(get(handle.panel_temporal_edit_n2, 'String'));
    bootnum=str2num(get(handle.panel_temporal_edit_bootnum, 'String'));
    p_value=str2num(get(handle.panel_temporal_edit_p_value, 'String'));
    if get(handle.panel_temporal_popupmenu_stastype, 'value')==1
        [sumt_negative, time_negative,t_max_n,sumt_positive, time_positive,t_max_p, t_max, z_n,z_p,time_positive2,time_negative2]= cluster_2test_final(data_wd,n1,n2,bootnum,p_value);
    elseif  get(handle.panel_temporal_popupmenu_stastype, 'value')==2
        [sumt_negative, time_negative,t_max_n,sumt_positive, time_positive,t_max_p, t_max, z_n,z_p,time_negative2,time_positive2]= cluster_paired_ttest_final(data_wd,n1,n2,bootnum,p_value);
    elseif  get(handle.panel_temporal_popupmenu_stastype, 'value')==3
        [sumt, sig_time,max_z,time_pn2]= cluster_2test_final_perm(data_wd,n1,n2,bootnum,p_value);
    elseif  get(handle.panel_temporal_popupmenu_stastype, 'value')==4
        [sumt, sig_time,max_z,time_pn2]= cluster_pairedtest_final_perm(data_wd,n1,n2,bootnum,p_value);
    end
    h=msgbox('计算完成', '');
elseif strcmp(action,'temporal_plot'),  % plot temporal course and significant time period
    [filename, pathname] = uigetfile({'*.csv'},'Select the CSV-file');
    t_data=readtable([pathname filename]);
    [filename, pathname] = uigetfile({'*.mat'},'Select the mat-file (significant time period)');
    load([pathname filename]);
    if exist('time_pn2')
        time_positive2=time_pn2;
        time_negative2=[];
    end
    n2=str2num(get(handle.panel_temporal_edit_tempcol, 'String'));
    t_data_cell=mat2cell(table2array(t_data(:,n2:end)),ones(size(t_data(:,n2:end),1),1),size(t_data(:,n2:end),2));
    figure()
    x=1:size(t_data(:,n2:end),2);
    n1=str2num(get(handle.panel_temporal_edit_CondCol, 'String'));
    g(1,1)=gramm('x',x,'y',t_data_cell,'color',table2array(t_data(:,n1)));
    g(1,1).stat_summary('type','sem');
    g(1,1).set_title('Temporal course analysis');
    %figure('Position',[100 100 1200 800]);
    g.set_names('x','Time bin','y','Sample Number');
    g.set_color_options('map','brewer_dark');
    g.draw();
    h2=msgbox('请点击你要画显著时间区域的图并按空格键', '');
    pause()
    close (h2)
    alp=0.15; %透明度
    for i= 1:size(time_negative2,2)
        x=[time_negative2{i}(1),time_negative2{i}(end),time_negative2{i}(end),time_negative2{i}(1)]; %x轴的位置
        y=[32,32,0,0]; %y轴的位置
        fq=fill(x,y,'y');
        set(fq,'facecolor',[0.5,0.5,0.5],'EdgeColor', 'none','FaceAlpha',alp)
    end
    for i= 1:size(time_positive2,2)
        x=[time_positive2{i}(1),time_positive2{i}(end),time_positive2{i}(end),time_positive2{i}(1)]; %x轴的位置
        y=[32,32,0,0]; %y轴的位置
        fq=fill(x,y,'y');
        set(fq,'facecolor',[0.5,0.5,0.5],'EdgeColor', 'none','FaceAlpha',alp)
    end
 
elseif strcmp(action,'deg2pix'),  % deg2pix
    ScrWidth=str2num(get(handle.panel_pt1_edit_ScrWidth, 'String'));
    viewDist=str2num(get(handle.panel_pt1_edit_viewDist, 'String'));
    pw=str2num(get(handle.panel_pt1_edit_pw, 'String'));
    widthDeg = round(2*180*atan(ScrWidth/(2*viewDist))/pi);
    deg2pix  = round(pw/widthDeg);
    sigma=round(2*deg2pix./(sqrt(8*log(2)))); %半距全宽为2°
    set(handle.panel_pt1_edit_deg2pix, 'String', num2str(deg2pix));
    set(handle.panel_pt1_edit_sigma, 'String', num2str(sigma));
        
elseif strcmp(action,'caussplot'),  % plot 2d causs
    sigma=str2num(get(handle.panel_pt2_edit_sigma, 'String'));
    SizeWH=str2num(get(handle.panel_pt2_edit_SizeWH, 'String'));
    G = fspecial('gaussian', [SizeWH SizeWH], sigma);
    figure()
    imagesc(G)
    axis square
    axis off
    
    
 elseif strcmp(action,'aveEnt'),  % plot 2d causs
    [filename, pathname] = uigetfile({'*.csv'},'Select the CSV-file');
    t_s=readtable([pathname filename]);
    sub_col=str2num(get(handle.panel_fixEnt_edit_subCol, 'String'));
    trial_col=str2num(get(handle.panel_fixEnt_edit_trialCol, 'String'));
    group_var=str2num(get(handle.panel_fixEnt_edit_groupVar, 'String'));
    fix_pos_col=str2num(get(handle.panel_fixEnt_edit_fixPosCol, 'String'));
    fixDur_col=str2num(get(handle.panel_fixEnt_edit_fixDurCol, 'String'));
    sr=str2num(get(handle.panel_fixEnt_edit_sr, 'String'));
    validNum=str2num(get(handle.panel_fixEnt_edit_validNum, 'String'));
    pw=str2num(get(handle.panel_pt1_edit_pw, 'String'));
    ph=str2num(get(handle.panel_pt1_edit_ph, 'String'));
    scale=str2num(get(handle.panel_fixEnt_edit_scale, 'String'));
    sigma=str2num(get(handle.panel_pt2_edit_sigma, 'String'));
    SizeWH=str2num(get(handle.panel_pt2_edit_SizeWH, 'String'));
    [H_all_t, H_rand_t, H_trial_t]=entropy_fix_average(t_s, sub_col, trial_col, group_var, fix_pos_col, fixDur_col, sr, validNum, pw, ph, scale,sigma,SizeWH);
    writetable(H_all_t, 'FixAveEntropy_all.csv');
    writetable(H_rand_t, 'FixAveEntropy_rand.csv');
	writetable(H_trial_t, 'FixEntropy_trial.csv');
    h=msgbox('计算完成', '');
end
