function [ H ] = HOG(I, cell_x, cell_y, B)
% Inputs
% • I: m-by-n grayscale image.
% • cell_x: Positive integer holding the width of a HOG cell.
% • cell_y: Positive integer holding the height of a HOG cell.
% • B: Positive integer holding the number of HOG bins.
% Outputs
% • H: (floor(m/cell_y)-1)-by-(floor(n/cell_x)-1) cell-array with entries corresponding to HOG
% blocks. Each entry holds a B-element row vector representing the oriented gradient
% histogram of the respective block.

img = im2double(I);
[m, n] = size(img);

H = cell(floor(m/cell_y)-1 , floor(n/cell_x)-1 );

Ix = imfilter(double(img) , double([1 , 0 , -1]));  
Iy = imfilter(double(img) , double([-1 , 0 , 1]')); 

phi = atan2(Iy, Ix);
r = sqrt(Ix.^2 + Iy.^2);

for i = 1 : size(H,1)
    for j = 1 : size(H,2)
        
        angle = phi((i-1) * cell_y + 1 : (i+1) * cell_y, ... 
            (j-1) * cell_x + 1 : (j+1) * cell_x);
        magnitude = r((i-1) * cell_y + 1 : (i+1) * cell_y, ...
            (j-1) * cell_x + 1 : (j+1) * cell_x);
        
        
        bElem = zeros(1, B);
        for b = 1 : B
            bElem(b) = sum(magnitude(angle >  (2*pi*(b-1)/B - pi) & ...
                angle <= (2*pi* b   /B - pi)));
        end
        H{i, j} = bElem;
    end
end

H = normr(H);

end

