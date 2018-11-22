%Clean up Everything before executing the code
clear all
close all
clc

i=imread('image2.jpg');
i = rgb2gray(i);
i = imadjust(i);
i = medfilt2(i, [3 3]);
i=im2bw(i,0.1);
i = imfill(i,'holes');
%clean up
bw = bwareaopen(i,300);
%fill holes
bw = imfill(bw,'holes');
%Label diff objects in the image 
L = bwlabel(bw);
%Find the required parameters
stats=  regionprops(L, 'Centroid','BoundingBox','Orientation');
dt  = regionprops(L, 'area');
cv = regionprops(L, 'perimeter');
dim = size(stats);
BW_filled = imfill(bw,'holes');
boundaries = bwboundaries(BW_filled);
%Initialize array
t = double.empty;
ci = double.empty;
sq = double.empty;
e = double.empty;
d = double.empty;
r = double.empty;
%Find Euclidean Distance from Centroid to each point in Boundary
for k=1:dim(1)
    b= boundaries{k};
    dim = size(b);
    for i=1:dim(1)
distance{k}(1,i) = sqrt ( ( b(i,2) - stats(k).Centroid(1))^2 + ( b(i,1) - stats(k).Centroid(2) )^2 );
    end 
    a = max(distance{k});
    b = min(distance{k});
    c = dt(k).Area;
    diff = a-b;
    square = c/(4*b^2);
    rect = c/(4*b*(a^2-b^2)^0.5);
    triangle = (c*3^0.5)/((a+b)^2);
    elip = c/(a*b*pi);
    rhombus = (c*( a^2 - b^2 )^0.5) / (2*a^2*b);
    if diff < 10
ci = [ci [stats(k).Centroid(1),stats(k).Centroid(2),stats(k).Orientation]];
    elseif (square < 1.05 ) & (square > 0.95 )
sq = [sq [stats(k).Centroid(1),stats(k).Centroid(2),stats(k).Orientation]];
    elseif (elip < 1.05 ) & (elip > 0.95 )
e = [e [stats(k).Centroid(1),stats(k).Centroid(2),stats(k).Orientation]];
    elseif (rhombus < 1.05 ) & (rhombus > 0.95 )
		d = [d [stats(k).Centroid(1),stats(k).Centroid(2),stats(k).Orientation]];
    elseif ((rect <1.05) & (rect >0.95))
        if(abs(rect-1)<abs(elip-1))
r = [r [stats(k).Centroid(1),stats(k).Centroid(2),stats(k).Orientation]];
        end
    elseif  (triangle < 1.05 ) & (triangle > 0.95 )
     	t = [t [stats(k).Centroid(1),stats(k).Centroid(2),stats(k).Orientation]];
    end
end
