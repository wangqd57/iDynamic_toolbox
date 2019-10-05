%%
t_s=readtable('gazeData.csv');
%%
sub_col=1;
trial_col=6;
group_var=[2 9];
fix_pos_col=[3 4];
fixDur_col=0;
sr=120;
validNum=8;

pw=1920;  %screen size
ph=1080;
viewDist=60;
ScrWidth=47.6;
ScrHeight=26.1;

% scale parameter
ySize = 1080;
xSize = 1920;
%scale=150/mean([xSize,ySize]);
scale=0.2;

widthDeg = round(2*180*atan(ScrWidth/(2*viewDist))/pi);
deg2pix  = round(pw/widthDeg);

sigma=round(2*deg2pix./(sqrt(8*log(2)))); %°ë¾àÈ«¿íÎª2¡ã
G = fspecial('gaussian', [sigma*4 sigma*4], sigma);
data_ent=table2array(t_s);