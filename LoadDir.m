function [ images, labels, height, width] = LoadDir( path, hogflag, cellflag, cell_x, cell_y, B )
% input:
% path
% method flag: 1-svm 2-HOG 3-
%

narginchk(3,6);
nargoutchk(2,4);

files = dir(path);
n = length(files) - 2;

[height, width] = size(imread(strcat (path , files(3).name)));
if hogflag
    if cellflag
        images = cell(n, (floor(height/cell_y)-1), (floor(width/cell_y)-1));
    else
        images = ones(n, B*(floor(height/cell_y)-1)*(floor(width/cell_x)-1) );
    end
else
    images = ones(n, height*width);
end

labels = ones(n,1)*(-1);

for i=3:length(files)
    img = imread(strcat(path , files(i).name));
    if hogflag
        if cellflag
            images(i-2, :, :) = HOG(img, cell_x, cell_y, B);
        else
            H = HOG(img, cell_x, cell_y, B);
            Hmat = cell2mat(H);
            images(i-2,:) = Hmat(:);
        end
    else
        images(i-2,:) = img(:)';
    end
    
    if (strfind( files(i).name , 'P'))
        labels(i-2) = 1;
    end
end


if hogflag && cellflag
    
end