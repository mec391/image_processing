close all
clear all


I = imread('low_contrast_bear.jpg');
P = I;



%process(do 3 times for R G and B):

%H Process 
%Find number of pixels that exist for each value of 0 - 255
% Normalize (x / 76800)
%add prev value and mult by 7

%S Process
% Use example from class but scaled to 256 bits
%Follows Same Process as H

%M Process
%for loops and if statements for new vector

R = I(1:240,:,1);
G = I(1:240,:,2);
B = I(1:240,:,3);


%For Red

%H Process
H_array = zeros(256,1);

for counter = 0:1:255 %Store Number of pixels per 0 - 255 in array
for i = 1:1:240
    for j = 1:1:320
        if R(i, j) == counter
            H_array(counter + 1) = H_array(counter + 1) + 1;
        end
    end
end
end

for counter1 = 1:1:256 %Normalize Array
    H_array(counter1) = H_array(counter1) / 76800;
end

sum = zeros(256,1);%cumulative sum and mult by 255, round
sum(1) = H_array(1);
for i = 1:1:256
    if(i == 256)
    H_array(i) = sum(i);
    else
    H_array(i) = sum(i);
    sum(i+1) = sum(i) + H_array(i + 1);
    end
end
for i = 1:1:256
    H_array(i) = round(H_array(i) * 255);
end



%S Process
S_array = zeros(256,1);

%{
for i = 1:1:128
    S_array(i) = 100 + sum;
    sum = sum + 2;
end
sum = 0;
for i = 128:1:256
    S_array(i) = 400 - sum;
    sum = sum + 2;
end
%}


for i = 1:1:256
    S_array(i) = 300;
end


for counter2 = 1:1:256 %Normalize Array
    S_array(counter2) = S_array(counter2) / 76800;
end

sum = zeros(256,1);%cumulative sum and mult by 255, round
sum(1) = S_array(1);
for i = 1:1:256
    if(i == 256)
    S_array(i) = sum(i);
    else
    S_array(i) = sum(i);
    sum(i+1) = sum(i) + S_array(i + 1);
    end
end
for i = 1:1:256
    S_array(i) = round(S_array(i) * 255);
end


%M Process
Zero_array = zeros(256,1);
for i = 1:1:256
    Zero_array(i) = i - 1;
end

M_array = zeros(256,1);



for i = 1:1:256
    if H_array(i) == 0
        M_array(i) = 1;
    else if H_array(i) == S_array(i)
        M_array(i) = Zero_array(i);
        else 
        for j = 2:1:256
            if S_array(j) ~= S_array(j-1)
            if H_array (i) == S_array(j)
               M_array(i) = Zero_array(j);
            end
            end
        end
        end
        if M_array(i) == 0
            M_array(i) = M_array(i - 1);
        end
        
        end
    end


%Map the Red values
for k = 0:1:255
for i = 1:1:240
    for j = 1:1:320
        if I(i,j,1) == k
            I(i,j,1) = M_array(k + 1);
        end
    end
end
end


%Repeat for Green

H_array = zeros(256,1);

for counter = 0:1:255 %Store Number of pixels per 0 - 255 in array
for i = 1:1:240
    for j = 1:1:320
        if G(i, j) == counter
            H_array(counter + 1) = H_array(counter + 1) + 1;
        end
    end
end
end

for counter1 = 1:1:256 %Normalize Array
    H_array(counter1) = H_array(counter1) / 76800;
end

sum = zeros(256,1);%cumulative sum and mult by 255, round
sum(1) = H_array(1);
for i = 1:1:256
    if(i == 256)
    H_array(i) = sum(i);
    else
    H_array(i) = sum(i);
    sum(i+1) = sum(i) + H_array(i + 1);
    end
end
for i = 1:1:256
    H_array(i) = round(H_array(i) * 255);
end



%S Process
S_array = zeros(256,1);

%{
for i = 1:1:128
    S_array(i) = 100 + sum;
    sum = sum + 2;
end
sum = 0;
for i = 128:1:256
    S_array(i) = 400 - sum;
    sum = sum + 2;
end
%}


for i = 1:1:256
    S_array(i) = 300;
end


for counter2 = 1:1:256 %Normalize Array
    S_array(counter2) = S_array(counter2) / 76800;
end

sum = zeros(256,1);%cumulative sum and mult by 255, round
sum(1) = S_array(1);
for i = 1:1:256
    if(i == 256)
    S_array(i) = sum(i);
    else
    S_array(i) = sum(i);
    sum(i+1) = sum(i) + S_array(i + 1);
    end
end
for i = 1:1:256
    S_array(i) = round(S_array(i) * 255);
end


%M Process
Zero_array = zeros(256,1);
for i = 1:1:256
    Zero_array(i) = i - 1;
end

M_array = zeros(256,1);



for i = 1:1:256
    if H_array(i) == 0
        M_array(i) = 1;
    else if H_array(i) == S_array(i)
        M_array(i) = Zero_array(i);
        else 
        for j = 2:1:256
            if S_array(j) ~= S_array(j-1)
            if H_array (i) == S_array(j)
               M_array(i) = Zero_array(j);
            end
            end
        end
        end
        if M_array(i) == 0
            M_array(i) = M_array(i - 1);
        end
        
        end
    end


%Map the Red values
for k = 0:1:255
for i = 1:1:240
    for j = 1:1:320
        if I(i,j,2) == k
            I(i,j,2) = M_array(k + 1);
        end
    end
end
end



%Repeat for B

H_array = zeros(256,1);

for counter = 0:1:255 %Store Number of pixels per 0 - 255 in array
for i = 1:1:240
    for j = 1:1:320
        if B(i, j) == counter
            H_array(counter + 1) = H_array(counter + 1) + 1;
        end
    end
end
end

for counter1 = 1:1:256 %Normalize Array
    H_array(counter1) = H_array(counter1) / 76800;
end

sum = zeros(256,1);%cumulative sum and mult by 255, round
sum(1) = H_array(1);
for i = 1:1:256
    if(i == 256)
    H_array(i) = sum(i);
    else
    H_array(i) = sum(i);
    sum(i+1) = sum(i) + H_array(i + 1);
    end
end
for i = 1:1:256
    H_array(i) = round(H_array(i) * 255);
end



%S Process
S_array = zeros(256,1);

%{
for i = 1:1:128
    S_array(i) = 100 + sum;
    sum = sum + 2;
end
sum = 0;
for i = 128:1:256
    S_array(i) = 400 - sum;
    sum = sum + 2;
end
%}


for i = 1:1:256
    S_array(i) = 300;
end


for counter2 = 1:1:256 %Normalize Array
    S_array(counter2) = S_array(counter2) / 76800;
end

sum = zeros(256,1);%cumulative sum and mult by 255, round
sum(1) = S_array(1);
for i = 1:1:256
    if(i == 256)
    S_array(i) = sum(i);
    else
    S_array(i) = sum(i);
    sum(i+1) = sum(i) + S_array(i + 1);
    end
end
for i = 1:1:256
    S_array(i) = round(S_array(i) * 255);
end


%M Process
Zero_array = zeros(256,1);
for i = 1:1:256
    Zero_array(i) = i - 1;
end

M_array = zeros(256,1);



for i = 1:1:256
    if H_array(i) == 0
        M_array(i) = 1;
    else if H_array(i) == S_array(i)
        M_array(i) = Zero_array(i);
        else 
        for j = 2:1:256
            if S_array(j) ~= S_array(j-1)
            if H_array (i) == S_array(j)
               M_array(i) = Zero_array(j);
            end
            end
        end
        end
        if M_array(i) == 0
            M_array(i) = M_array(i - 1);
        end
        
        end
    end


%Map the Red values
for k = 0:1:255
for i = 1:1:240
    for j = 1:1:320
        if I(i,j,3) == k
            I(i,j,3) = M_array(k + 1);
        end
    end
end
end



figure(1);
imhist(P,256);
imhist(I, 256);

figure(2);
imshowpair(P,I,'montage')
title('My image equalized')
set(gca,'fontsize',14);
axis off


Z = histeq(P);
figure(3)
imshow(Z);
figure(4)
imhist(Z,256);


