hor_coefficients = [];
vert_coefficients = [];
diagonal_coefficients = [];
approx_coefficients = [];
myDir = uigetdir; %gets directory
myFiles = dir(fullfile(myDir,'*.dcm')); %gets all wav files in struct
for k = 1:808 %ad = 383, cn = 424(training dataset)
  baseFileName = myFiles(k).name;
  fullFileName = fullfile(myDir, baseFileName);
  input = dicomread(fullFileName); %Reads in MRI image
  
  if size(input) ~= [256 256]
      k = k - 1;
  else 
  %imshow(input, 'DisplayRange', []);
    dwtmode('per');
    [C,S] = wavedec2(input, 4, 'db4');
 %  [cA,cH, cV, cD] = dwt2(y, 'db5')
     
%    hor_coefficients(end+1)=cH(1);
%    vert_coefficients(end+1) = cV(1);
%    diagonal_coefficients(end+1) = cD(1);
%    approx_coefficients(end+1) = cA(1);
    A = appcoef2(C,S,'db4',4);
% [H1,V1,D1] = detcoef2('all',C,S,1);
% [H2,V2,D2] = detcoef2('all',C,S,2);
% [H3,V3,D3] = detcoef2('all',C,S,3);
    [H4,V4,D4] = detcoef2('all',C,S,4);
    D4_1D = reshape(D4,[1, 256]); % used to be D4 or H4
    size_level = size(D4_1D);
    disp('new term');
    if k == 1
        writematrix(D4_1D, 'D4_train.csv')
    else
        writematrix(D4_1D, 'D4_train.csv', 'WriteMode', 'append')
    end
  end     
%perform dwt within here and store coefficients within array for later use
end

myDir = uigetdir; %gets directory
myFiles = dir(fullfile(myDir,'*.dcm')); %gets all wav files in struct
for k = 1:101 %length(myFiles)  ad = 102, cn = 101 for testing
  baseFileName = myFiles(k).name;
  fullFileName = fullfile(myDir, baseFileName);
  input = dicomread(fullFileName);
  size(input)
  
  if size(input) ~= [256 256]
      k = k - 1;
  else 
  
  %imshow(input, 'DisplayRange', []);
    dwtmode('per');
    [C,S] = wavedec2(input, 4, 'db4');
 %  [cA,cH, cV, cD] = dwt2(y, 'db5')
     
%    hor_coefficients(end+1)=cH(1);
%    vert_coefficients(end+1) = cV(1);
%    diagonal_coefficients(end+1) = cD(1);
%    approx_coefficients(end+1) = cA(1);
    A = appcoef2(C,S,'db4',4);
% [H1,V1,D1] = detcoef2('all',C,S,1);
% [H2,V2,D2] = detcoef2('all',C,S,2);
% [H3,V3,D3] = detcoef2('all',C,S,3);

    [H4,V4,D4] = detcoef2('all',C,S,4);
    D4_1D = reshape(H4,[1, 256]);
    size_level = size(D4_1D);
    disp('new term');
   

    writematrix(D4_1D, 'D4_test.csv', 'WriteMode', 'append')
  end
     
%perform dwt within here and store coefficients within array for later use
end
