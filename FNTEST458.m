close all
clear all

rgb_img = imread('wolpert1.jpg');

figure(1)
imshow(rgb_img);

R = rgb_img(:,:,1);
G = rgb_img(:,:,2);
B = rgb_img(:,:,3);

R = double(R);
G = double(G);
B = double(B);

img_dimension = size(R);

img_rows = img_dimension(1);
img_cols = img_dimension(2);

Y = (R + 2*G + B) / (4); %convert to YUV
U = R - G;
V = B - G;

%Note: v_thresh has little significance to accuracy and may be left out to increase computation
U_thresh = zeros(img_dimension); %apply threshold
V_thresh = zeros(img_dimension);

for i = 1:1:img_rows
	for j = 1:1:img_cols
		if U(i,j) > 10 && U(i,j) < 74
			U_thresh(i,j) = 1;
		else
			U_thresh(i,j) = 0;
		end
	end
end

for i = 1:1:img_rows
	for j = 1:1:img_cols
		if V(i,j) > -40 && V(i,j) < 11
			V_thresh(i,j) = 1;
		else
			V_thresh(i,j) = 0;
		end
	end
end

skin_seg = zeros(img_dimension); %apply segmentation

for i = 1:1:img_rows
	for j = 1:1:img_cols
		if U_thresh(i,j) == 1 && V_thresh(i,j) == 1
			skin_seg(i,j) = 1;
		else
			skin_seg(i,j) = 0;
		end
	end
end

figure(2)
imshow(skin_seg);

%%%%%%%%%%%%%%%%%%%%%%%%%: Morph Filter ->connected components -> area calc -> area filter -> centroid calc
%apply morphological filters
skin_seg1 = imerode(skin_seg,strel('square',3)); %erode/remove small groups of pixels
skin_seg1 = imfill(skin_seg1, 'holes');          %fill holes in the face (if black region exists where entirely surrounded by white, make it white


figure(3)
imshow(skin_seg1);

%label regions and compute their area
[L, n] = bwlabel(skin_seg1); 
face_region = regionprops(L, 'Area');
face_area = [face_region.Area];
%find and show only the regions with at least 26% area of max area
face_idx = find(face_area > (.26)*max(face_area));
face_shown = ismember(L, face_idx);


figure(4)
imshow(face_shown);

%5/1 centroid and box calcuation
s = regionprops(face_shown, 'Centroid');
centroids = cat(1, s.Centroid); %cat puts all the s.Centroid values into amatrix

%store edge values of face for box, only calculates 1 centroid and box for
%now
ii = round(centroids(1));
jj = round(centroids(2));
while face_shown(jj, ii) == 1
    jj = jj + 1;
end
border_bottom = jj;
jj = round(centroids(2));
while face_shown(jj, ii) == 1
    jj = jj - 1;
end
border_top = jj;
jj = round(centroids(2));
while face_shown(jj,ii) == 1
    ii = ii + 1;
end
border_right = ii;
ii = round(centroids(1));
while face_shown(jj,ii) == 1
    ii = ii - 1;
end
border_left = ii;
ii = round(centroids(1));

%find left border and right
for i = jj:-1:border_top
    rgb_img(i, border_left, 1) = 255;
    rgb_img(i, border_left, 2) = 0;
    rgb_img(i, border_left, 3) = 0;
    
    rgb_img(i, border_right, 1) = 255;
    rgb_img(i, border_right, 2) = 0;
    rgb_img(i, border_right, 3) = 0;
end
for i = jj:1:border_bottom
    rgb_img(i, border_left, 1) = 255;
    rgb_img(i, border_left, 2) = 0;
    rgb_img(i, border_left, 3) = 0;
    
    rgb_img(i, border_right, 1) = 255;
    rgb_img(i, border_right, 2) = 0;
    rgb_img(i, border_right, 3) = 0;
end

%find bottom border and top
for i = ii:-1:border_left
    rgb_img(border_bottom, i, 1) =255;
    rgb_img(border_bottom, i, 2) = 0;
    rgb_img(border_bottom, i, 3) = 0;
    
    rgb_img(border_top, i, 1) = 255;
    rgb_img(border_top, i, 2) = 0;
    rgb_img(border_top, i, 3) = 0;
end
for i = ii:1:border_right
    rgb_img(border_bottom, i, 1) = 255;
    rgb_img(border_bottom, i, 2) = 0;
    rgb_img(border_bottom, i, 3) = 0;
    
    rgb_img(border_top, i, 1) = 255;
    rgb_img(border_top, i, 2) = 0;
    rgb_img(border_top, i, 3) = 0;
end

k =1;
z =1;

for i = border_top:1:border_bottom
    k = k + 1;
    for j = border_left:1:border_right
        morales0(k,z,1) = rgb_img(i,j,1);
        morales0(k,z,2) = rgb_img(i,j,2);
        morales0(k,z,3) = rgb_img(i,j,3);
        z = z + 1;
    end
    z = 1;
end

morales0 = imresize(morales0, [50 50]);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%figure(1)
%imshow(rgb_img);
%figure(2)
%imshow(skin_seg);
%figure(3)
%imshow(face_shown);
figure(5)
imshow(morales0);
figure(6)
imshow(rgb_img)
%feed into NN for training


