function [out, l, r] = trimSilence(in, thres)
    l = 100;
    while var(in(l-10:l))<thres
        l=l+1;
    end
    r = size(in, 1)-100;
    while var(in(r:r+10))<thres
        r=r-1;
    end
    out = in(l:r);
end