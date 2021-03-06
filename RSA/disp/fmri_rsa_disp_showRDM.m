function fmri_rsa_disp_showRDM(rdm,fIDX,whichQuadrant,labelType,images)
%% fmri_rsa_disp_showRDM(rdm,fIDX,whichQuadrant,labelType,images)
%
% Timo Flesch, 2018,
% Human Information Processing Lab,
% Experimental Psychology Department
% University of Oxford

  if ~exist('whichQuadrant','var')
    whichQuadrant = 'all';
  end
  if ~exist('labelType','var')
    labelType = 'imgs';
  end

  if ~exist('fIDX','var')
      fIDX = 1000;
  end
  figure(fIDX);

  switch labelType
  case 'imgs'
    if ~exist('images','var')
      images = load('rdmLabels.mat');
      labels = images.imStruct;
    end
  case 'text'
    ii = 1;
    labels = cell(50,1);
    for ctx =1:2
      for b = 1:5
        for l=1:5
         labels{ii} = ['C' num2str(ctx) 'B' num2str(b) 'L' num2str(l)];
         ii = ii+1;
        end
      end
    end
  end

  switch whichQuadrant
  case 'all'
    quadIdces = [1:length(rdm);1:length(rdm)];
    imIdces = [1:length(rdm)];
  case 'taskNorth'
    quadIdces = [1:floor(length(rdm)/2);1:floor(length(rdm)/2)];
    imIdces = [ceil(length(rdm)/2)+1:length(rdm)];
  case 'taskSouth'
    quadIdces = [ceil(length(rdm)/2)+1:length(rdm);26:length(rdm)];
    imIdces = [1:floor(length(rdm)/2)];
  end
  numEl = length(imIdces);

  image(scale01(rankTransform_equalsStayEqual(rdm(quadIdces(1,:),quadIdces(2,:)))),'CDataMapping','scaled','AlphaData',1);
  colormap('jet');
  switch labelType
  case 'imgs'
    labels.images = labels.images(imIdces);
    addImageSequenceToAxes(gca,labels);
    axis off;
  case 'text'
    disp('lol')
    labels = labels(quadIdces(1,:));
    set(gca,'XTick',1:numEl);
    set(gca,'YTick',1:numEl);
    set(gca,'XTickLabel',labels);
    set(gca,'YTickLabel',labels);
    set(gca,'XTickLabelRotation',50);
  case 'none'
    axis off;
  end

  box off;
  axis square;
  set(gcf,'Color','w')
  cb = colorbar();
  ylabel(cb,'dissimilarity')
  colormap('jet');
end
