function [pos_cellX, pos_cellY] = data_sorting(poscellX, poscellY)
    poscellX = round(poscellX);
    [~, ia, ~] = unique(poscellX,'stable');
    pos_cellX = zeros(1, size(ia,1));
    pos_cellY = zeros(1,size(ia,1));

    for i = 1:size(ia,1)
        pos_cellX(i) = poscellX(i);
        pos_cellY(i) = poscellY(i);
    end
end
