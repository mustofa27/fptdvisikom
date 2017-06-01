%training_smile
for i=1:5
    img_dir = sprintf('training_images/smile/train_smile%d.pgm',i);
    img = imread(img_dir);
    features_face = lbp(img, true);
    for j=1:11
        if j==1
            training_features(i,1) = 1;
        else
            training_features(i,j)= features_face(j-1);
        end
    end
end

%training_non_smile
for i=1:5
    img_dir = sprintf('training_images/non_smile/train_non_smile%d.pgm',i);
    img = imread(img_dir);
    features_face = lbp(img, true);
    for j=1:11
        if j==1
            training_features(5+i,1) = 0;
        else
            training_features(5+i,j)= features_face(j-1);
        end
    end
end

dlmwrite('training_features.txt',training_features,'delimiter',' ');