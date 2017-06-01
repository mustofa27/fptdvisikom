%untuk testing perlu dilakukan deteksi wajah terlebih dahulu
for i=1:20
    img_dir = sprintf('testing_images/test%d.pgm',i);    
    %deteksi wajah
    %get_face = detectFaces(img_dir);
    get_face = imread(img_dir);
    figure(i), imshow(get_face);
    %get_face = rgb2gray(get_face);
    features_face = lbp(get_face, true);
    for j=1:11
        if j==1
            training_features(i,1) = 1;
        else
            testing_features(i,j)= features_face(j-1);
        end
    end
end

dlmwrite('testing_features.txt',testing_features,'delimiter',' ');
