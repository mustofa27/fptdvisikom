%get face
get_face = detectFaces('input_images/baby.jpg');
figure(2)
imshow(get_face);

%extract features
face_gray = rgb2gray(get_face);
features_face = lbp(face_gray, true);

figure(3)
bar(features_face,'grouped')
title('Squared Error of LBP Histograms')
xlabel('LBP Histogram Bins')
