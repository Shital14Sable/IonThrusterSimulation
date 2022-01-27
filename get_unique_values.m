function [A, d1] = get_unique_values(In_A)
    [C,m1,~] = unique(In_A,'first');
    [~,d1] =sort(m1);
    A = C(d1);
end
