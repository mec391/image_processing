close all
clear all

rgb_img = imread('morales.jpg');
morales = custom_detect(rgb_img);
morales = double(morales);

rgb_img1 = imread('morales0.jpg');
morales1 = custom_detect(rgb_img1);
morales1 = double(morales1);

rgb_img2 = imread('wolpert.jpg');
wolpert = custom_detect(rgb_img2);
wolpert = double(wolpert);

rgb_img3 = imread('wolpert1.jpg');
wolpert1 = custom_detect(rgb_img3);
wolpert1 =double(wolpert1);
%run morales, morales_1, wolpert, wolpert_1 into NN for training
%concatenate vectors
NN_in(:,1) = morales;
NN_in(:,2) = morales1;
NN_in(:,3) = wolpert;
NN_in(:,4) = wolpert1;
NN_desired(:,1) = [1 0];
NN_desired(:,2) = [1,0];
NN_desired(:,3) = [0,1];
NN_desired(:,4) = [0,1];


net = patternnet(10);
net = train(net,NN_in,NN_desired);
q = view(net);


rgb_img5 = imread('morales0.jpg');
elaraby = custom_detect(rgb_img5);
elaraby = double(elaraby); 
output=sim(net,elaraby)
percent_morales = round(output(1) * 100);
percent_wolpert = round(output(2) * 100);
caption = sprintf('You are %d percent Dr. Morales and %d percent Dr. Wolpert', percent_morales, percent_wolpert);
	title(caption, 'FontSize', 14);
