clear;
close all;

[n1,fs] = audioread('record.wav');

x=n1(:,1)';

%
low=load('low.mat');
[blow,alow]=sos2tf(low.SOS,low.G);
[hl,wl] = freqz(blow,alow,128); 
ylow=filter(blow,alow, x);
%}

%
midl=load('midl.mat');
[bmidl,amidl]=sos2tf(midl.SOS,midl.G);
[hml,wml] = freqz(bmidl,amidl,128); 
ymidl=filter(bmidl,amidl, x);
%}

%
midh=load('midh.mat');
[bmidh,amidh]=sos2tf(midh.SOS,midh.G);
[hmh,wmh] = freqz(bmidh,amidh,128); 
ymidh=filter(bmidh,amidh, x);
%}

%
high=load('high.mat');
[bhigh,ahigh]=sos2tf(high.SOS,high.G);
[hh,wh] = freqz(bhigh,ahigh,128); 
yhigh=filter(bhigh,ahigh, x);
%}
y=ylow*1+ymidl*1+ymidh*1+yhigh*5;

  
%------------------------------------------
figure;
subplot(411); plot(x);axis('tight');title('原訊號');
subplot(412); specgram(x);
subplot(413); plot(y);axis('tight');title('組合後');
subplot(414); specgram(y);
audiowrite('outputmusic3.wav',y/max(abs(y)),fs); %輸出

%
figure;
subplot(811); plot(ylow);axis('tight');title('低通');
subplot(812); specgram(ylow);
audiowrite('musiclow.wav',ylow/max(abs(ylow)),fs); %輸出
%}

%
subplot(813); plot(ymidl);axis('tight');title('中低通');
subplot(814); specgram(ymidl);
audiowrite('musicmidl.wav',ymidl/max(abs(ymidl)),fs); %輸出
%}

%
subplot(815); plot(ymidh);axis('tight');title('中高通');
subplot(816); specgram(ymidh);
audiowrite('musicmidh.wav',ymidh/max(abs(ymidh)),fs); %輸出
%}
%
subplot(817); plot(yhigh);axis('tight');title('高通');
subplot(818); specgram(yhigh);
audiowrite('musichigh.wav',yhigh/max(abs(yhigh)),fs); %輸出
%}
figure;
subplot(411);plot(wl/pi*22050,20*log10(abs(hl)),'-');
title('lowpass');
subplot(412);plot(wml/pi*22050,20*log10(abs(hml)),'-');
title('midl');
subplot(413);plot(wmh/pi*22050,20*log10(abs(hmh)),'-');
title('midh');
subplot(414);plot(wh/pi*22050,20*log10(abs(hh)),'-');
title('highpass');

