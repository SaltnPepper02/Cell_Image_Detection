clear

%read image into original_img
original_img = imread("StackNinja1.bmp");

%brighten the original image
brightenimg = imlocalbrighten(original_img);

%take the greeness of the brighten image
greeny = greeness(brightenimg);

%filter image using laplacian filtering
filterimg = locallapfilt(greeny, 0.6, 0.5);

%binarize the image using 'adaptive method'
threshold_image = imbinarize(filterimg, 'adaptive', 'Sensitivity', 0.85);

%change the image from logical to uint8
uint8img = uint8(threshold_image)*255;

%set the structural element
se = strel("disk", 2);

%erode and dilate image
erode_img = imerode(uint8img, se);
dilate_img = imdilate(erode_img, se);

%mark all the connected white cells
label = bwlabel(dilate_img);

%count the number of labels
num_labels = max(label(:));

%color the image with random color and set the surronding background to
%black
colour_img = label2rgb(label, rand(num_labels,3), "k");

%display original image, binary image and randomly colored image
figure;
subplot (3,1,1);
imshow(original_img);
title("original image");

subplot (3,1,2);
imshow(dilate_img);
title("binarized image");

subplot (3,1,3);
imshow(colour_img);
title("random coloured image");

%function to extract green
function greeny = greeness(img)

%extract the different chanels of the image
   R = img(:,:,1);
   G = img(:,:,2);
   B = img(:,:,3);

%calculate the greeness using the formula G- (R+B) / 2
   greeny = (G - (R+B)/2.0);

end


