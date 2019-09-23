function [ z_new ] = smoother_Jac(k,z_old,b,n1)
%UNTITLED11 Summary of this function goes here
%   Detailed explanation goes here
    z_new=z_old;
    [nx,ny]=size(z_old);
    h=1/nx;
    h2 = h*h;
    for l=1:n1
        for j=2:ny-1
            for i=2:nx-1
                z_new(i,j) = (z_old(i-1,j) + z_old(i+1,j) + z_old(i,j-1) + z_old(i,j+1) - h2*b(i,j))/4;
            end
        end
        z_old=z_new;
    end
end

