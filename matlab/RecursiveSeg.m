%%% Place this file in and run it from the ncut code directory

function SegLabel = RecursiveSeg(I,nbSegments);

levels = ceil(log(nbSegments)/log(2));
[W,imageEdges] = ICgraph(I);

%%Filter out the zero
mask=find(I > 0);
LocalW=W(mask,mask); 
[NcutDiscrete,NcutEigenvectors,NcutEigenvalues] = ncutW(LocalW,2);
nsegs=2;

%% generate segmentation label map
[nr,nc,nb] = size(I);

SegLabel = zeros(nr,nc);
SegLabel(mask) = 1;

%%label the new seg with the new label
SegLabel(mask(find(NcutDiscrete(:,2)==1))) = 2;


nextLabel = nsegs + 1;

%% Subdivide...
nsegs = max(max(SegLabel));
LevelDiscrete = zeros(nr*nc,nsegs);
for j=1:nsegs;
    LevelDiscrete(find(SegLabel==j),j)=1;
end;

LocalDiscrete = [];
for i=2:levels;
    display(sprintf('level %d',i));
    %% extract the subgraph
    for j=1:nsegs;
        display(sprintf('label %d -> %d', j,nextLabel));    
        %% get the idx
        idx = find(LevelDiscrete(:,j)==1);
        LocalW= W(idx,idx);
        
        if (size(idx,1) > 1 );
            [LocalDiscrete,LocalEigenvectors,LocalEigenvalues] = ncutW(LocalW,2);
        
            %%label the new seg with the new label
            SegLabel(idx(find(LocalDiscrete(:,2)==1))) = nextLabel;
        end
                
        nextLabel = nextLabel+1;
    end;

    nsegs = max(max(SegLabel));
    LevelDiscrete = zeros(nr*nc,nsegs);
    for j=1:nsegs;
        LevelDiscrete(find(SegLabel==j),j)=1;
    end;
end;
