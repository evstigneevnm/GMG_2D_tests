function [ v ] = array2vec( u )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
    [nx,ny] = size( u );
    N=nx*ny;
    v=zeros(N,1);
    for j=1:nx
        for k=1:ny
            v((j-1)*ny+k)=u(j,k);
        end
    end
    

end

