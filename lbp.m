%fungsi lbp rotatation
function y = lbp(I,isRotationInvariant)
if isRotationInvariant == true
    y = extractLBPFeatures(I,'Upright',false);
else
    y = extractLBPFeatures(I,'Upright',true);
end
end