% Simulate visual search with two feature dimensions:
% 1: Colour (red / green)
% 2: Orientation (vertical / horizontal)
%
% Generate matrix of neurons (10x10) which cover the display
% Select 16 neurons for distractors;
% Select 1 neuron for target;
%

Setsize=8;
Ntar=1;
ntrls=1;
Nmatrix=zeros(10,10);
TarDim=[1 1];
DistDim=[2 2];
TarFR=10;
DistFR=TarFR/2;
inhibition=TarFR; % A constant inhibition value; the whole matrix will be divided by that number   
Namp=TarFR/2;
for s=1:length(Setsize)
    Ndist=Setsize(s);
    for m=1:length(inhibition)
        for n=1:ntrls
            Nmatrix=rand(10,10).*0;
            Locs=randperm(size(Nmatrix,1)*size(Nmatrix,2));
            Li=Locs(1:Ndist+Ntar);
            for k=1:Ndist
                if k == 1
                    tmp=2;
                else
                    tmp=sum(round(rand(1,2)));% here we flip a coin which can yield three outcomes
                end
                % 0 = none of the target features is present for the distractor
                % 1 or 2 = one of the features is present 
                if tmp == 0
                    Nmatrix(Li(k))=DistFR+rand(1,1)*Namp;
                else
                    Nmatrix(Li(k))=TarFR+rand(1,1)*Namp;
                end
            end
            Nmatrix(Li(end))=(TarFR+rand(1,1)*Namp)+(TarFR+rand(1,1)*Namp);
            % Apply inhibition by subtraction;
            Nmatrix=Nmatrix-inhibition(m);
            % find any below zero entries and set to 0
            isubz=find(Nmatrix<0);
            Nmatrix(isubz)=0;
            % Calculate summed FR for Distractors
            nois=sum(Nmatrix(Li(1:Ndist)));
            sign=sum(Nmatrix(Li(end)));
            SNR(n,m)=sign/nois;

            figure;imagesc(Nmatrix);colormap(hot)
            RT(n,m)=SerialSearcher(Nmatrix,Li(end),250,0.5,1);
        end
    end
    %RT_avg(s,:)=mean(RT,1);
    %plot_wave_wth_shading(RT_avg(s,:),inhibition);
end

%figure;plot(inhibition,RT_avg');legend ss2 ss8 ss16

