function [ u1 ] = vec2array( v, u)
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here

    [nx,ny] = size( u );
    u1=zeros(nx,ny);
    for j=1:nx
        for k=1:ny
            u1(j,k) = v((j-1)*ny+k);
        end
    end    

end

