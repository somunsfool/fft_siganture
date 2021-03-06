%find the peak data 
function [p fr]=peak_hold(filename,start,group,subgroup,fft_size)
    if(nargin<5)
        filename='USRP_01/mpsk_wo_demod.dat';
        start=0*8;  %every 8 bytes represent one complex data
        group=1000;
        subgroup=10;
        fft_size=4096;   %fft size
    end
    len=group*fft_size;
    data=view_data(filename,start,len);
    fr=reshape(data,fft_size,group);
    fr=fr';     %now the power data have been tranform into group*fft matrix
    for i=1:1:subgroup
        for j=1:1:fft_size
            p(i,j)=max(fr((i-1)*group/subgroup+1:(i-1)*group/subgroup+group/subgroup,j));
        end
    end

    for i=1:1:subgroup  %display the peak data
        figure(i);
        plot(p(i,:));
        hold on;
    end
%   plot(p(1,:));
end