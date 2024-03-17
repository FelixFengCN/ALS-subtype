clc;clear;close all;
% atla_num=246;
% p=0.05;
% nc_index;
% als_index=setdiff(index, [nc_index out_index]);
% EISN=;
% LISN=;
% age;
% sex;
% edu;
% ALSFRS
% speed
% MMSE;
% MOCA
% ECAS
% dNe;
% suvr;
% greyvol;


for i=1:atla_num
    
    id=zeros(73,1);
    id(nc_index)=1;id(LISN)=2;id(EISN)=3;
    %%%%%%%%% suvr %%%%%%%%%%%%%%%
    [anova_suvr_p(i),anova_suvr_table,anova_suvr_stats]=kruskalwallis(suvr(:,i),id,'off');
    [suvr_c,~,~,~,suvr_t(i,:)]=multcompare(anova_suvr_stats);
    suvr_sig(i,:)=suvr_c(:,6);
    suvr_sign(i,1) = median(suvr(nc_index,i))-median(suvr(LISN,i));
    suvr_sign(i,2) = median(suvr(nc_index,i))-median(suvr(EISN,i));
    suvr_sign(i,3) = median(suvr(LISN,i))-median(suvr(EISN,i));
    
    %%%%%%%%% dNe %%%%%%%%%%%%%%%
    [anova_dNe_p(i),anova_dNe_table,anova_dNe_stats]=kruskalwallis(dNe(:,i),id,'off');
    [dNe_c,~,~,~,dNe_t(i,:)]=multcompare(anova_dNe_stats);
    dNe_sig(i,:)=dNe_c(:,6);
    dNe_sign(i,1) = median(dNe(nc_index,i))-median(dNe(LISN,i));
    dNe_sign(i,2) = median(dNe(nc_index,i))-median(dNe(EISN,i));
    dNe_sign(i,3) = median(dNe(LISN,i))-median(dNe(EISN,i));
    
end


FDR_suvr=ones(size(suvr_sig));FDR_dNe=ones(size(dNe_sig));
FDR_fNe=ones(size(fNe_sig));FDR_greyvol=ones(size(greyvol_sig));

anova_suvr_p_FDR=mafdr(anova_suvr_p,'BHFDR', true);
anova_dNe_p_FDR=mafdr(anova_dNe_p,'BHFDR', true);
anova_greyvol_p_FDR=mafdr(anova_greyvol_p,'BHFDR', true);
anova_fNe_p_FDR=mafdr(anova_fNe_p,'BHFDR', true);

anova_fNe_p_FDR=anova_fNe_p;
anova_greyvol_p_FDR=anova_greyvol_p;

for j=1:3
    anova_suvr_p_FDR_sort=sort(anova_suvr_p_FDR);
    A=sum(suvr_sig(anova_suvr_p_FDR<p,j)>anova_suvr_p,2);A(A==0)=1;
    FDR_suvr(anova_suvr_p_FDR<p,j)=anova_suvr_p_FDR_sort(A);
    anova_dNe_p_FDR_sort=sort(anova_dNe_p_FDR);
    B=sum(dNe_sig(anova_dNe_p_FDR<p,j)>anova_dNe_p,2);B(B==0)=1;
    FDR_dNe(anova_dNe_p_FDR<p,j)=anova_dNe_p_FDR_sort(B);
end


















