%%% To Detect the Text from Natutal Images
%function textext();
clc;
clear all;
close all;
%% read the image file
text_image =imread('download.jpg');
Igray= rgb2gray(text_image);
Ib = im2bw(Igray,0.6);
figure
subplot(1,2,1)
imshow(text_image,[]),title('original Image');
subplot(1,2,2)
imshow(Igray),title('Gray scale Image');
set(gcf, 'units','normalized','outerposition',[0 0 1 1]);
%% IMPLEMENTATION OF Edge detection ALGORITHM %%%%%%%%%%%%%%%%%%%%%%%%%
[Gx Gy Gxy]= edge(Ib);
figure
subplot (2,2,1);
imshow(Gx,[]); title ('Vertical detect');
subplot(2,2,2);
imshow(Gy,[]); title ('horizontal detect');
subplot(2,2,3);
imshow(Gxy,[]); title ('edge detection');
set(gcf, 'units','normalized','outerposition',[0 0 1 1]);
%%
% Morphological processing
Gxy8 = uint8(round(Gxy*255));
se=strel('disk',12);
dIM1 = imdilate(Gxy8,se);
figure;
imshow(dIM1);
title ('dilated image'); 
se2=strel('disk',17);
Iop = imopen(dIM1,se2);
figure;
imshow(Iop);
title ('opened image');
final = immultiply(Iop ,Ib);
figure;
imshow(final);
title( 'final');
%%
% character segmentation and regonition 
text = ocr(final);
textext=text.Text;
myicon = text_image;
h=msgbox(sprintf('TEXT EXTRACTED IS :: %s',textext),'TEXT EXTRACTED','custom',myicon);
%end
%% TEXT TO SPEECH USING WINDOWS SPEECH RECOGINATION
caUserInput = char(textext); % Convert from cell to string.
NET.addAssembly('System.Speech');
obj = System.Speech.Synthesis.SpeechSynthesizer;
obj.Volume = 100;
Speak(obj, caUserInput);
%%