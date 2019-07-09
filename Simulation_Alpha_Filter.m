% Simulate visual search with two feature dimensions:
% 1: Colour (red / green)
% 2: Orientation (vertical / horizontal)
%
% Generate matrix of neurons (10x10) which cover the display
% Select 16 neurons for distractors;
% Select 1 neuron for target;
%

Setsize=[2 8 16];% Define number of distractors for simulation
Ntar=1;% number of targets
ntrls=1000; % how many trials should be simulated?
Nmatrix=zeros(10,10); %That's our retinotopic map; one neuron per location
TarFR=10;% firing rate for neurons coding for target relevant dimension
DistFR=TarFR/2;% firing rate for neurons coding target irrelevant (i.e. distractor) dimension
inhibition=0:1:TarFR*2; % A constant inhibition value; the whole matrix will be divided by that number   
Namp=TarFR/2;% set noise level; this is not strictly needed but renders the simulation more realistic
for s=1:length(Setsize)
    Ndist=Setsize(s);
    for m=1:length(inhibition)
        for n=1:ntrls
            Nmatrix=rand(10,10).*0;% offers a possibility to also inject some noise for neurons that don't see a stimulus; but we keep that to 0 for now;
            Locs=randperm(size(Nmatrix,1)*size(Nmatrix,2));
            Li=Locs(1:Ndist+Ntar);% random variable to place stimuli in the map;
            for k=1:Ndist
                if k == 1
                    tmp=2;% first item will always be a distractor coding a target relevant feature; this is need for the script not to crash for low set sizes;
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
            % Note that this value is applied to both, TARGET AND DISTRACTORS so the inhibition mechanism is super simple and does have no knowledge about the target;
            Nmatrix=Nmatrix-inhibition(m);
            % find any below zero entries and set to 0
            isubz=find(Nmatrix<0);
            Nmatrix(isubz)=0;
            % Calculate summed FR for Distractors
            nois=sum(Nmatrix(Li(1:Ndist)));
            sign=sum(Nmatrix(Li(end)));
            SNR(n,m)=sign/nois;% Here we calculate SNR but that is not needed, but you may want to inspect it;

            %figure;imagesc(Nmatrix);colormap(hot)% You can use this to plot the maps of some trials but remember to put a stop in the loop otherwise it will run forever!
            RT(n,m)=SerialSearcher(Nmatrix,Li(end),250,0.5,0);% Submit map to serial searcher; (see funtion)
        end
    end
    RT_avg(s,:)=mean(RT,1);
    %plot_wave_wth_shading(RT_avg(s,:),inhibition);
end
% Plot the results
figure;plot(inhibition,RT_avg');legend ss2 ss8 ss16

