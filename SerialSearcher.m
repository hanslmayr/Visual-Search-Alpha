% Simulate a serial searcher that scans an image for a target location
% considering each location one at a time; The search algorithm takes as
% input a saliency map and considers all locations above a certain
% threshold

function [RT]=SerialSearcher(salmap,target,stepsize,threshold,plot)

idx=find(salmap);% Find all non-zero entries
if length(idx) ~= 1
    
    saldist=sortrows(salmap(idx));
    ctidx=floor(length(saldist)*threshold);
    cutoff=saldist(ctidx);
    idx2=find(salmap<=cutoff);
    salmap(idx2)=0;
    if plot == 1
        figure;imagesc(salmap);colormap hot;
    end
    idx4srch=find(salmap);
    idx4srch=idx4srch(randperm(length(idx4srch)));
    s=0;
    Tfound=0;
    while Tfound==0
        s=s+1;
        tmp=idx4srch(s);
        if tmp == target
            Tfound=1;
        else
        end     
    end

    RT=s*stepsize;
else
    RT=stepsize;
end