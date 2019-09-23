function fc = restrictor( r )
%
% function uc = injf2c( u )
%
% Transfers a fine grid to a coarse grid by injection
%
% Input
%   u    fine-grid function
%
% Returns
%   uc   coarse-grid function

[nx,ny] = size( r );
nxm=(nx-1)/2+1;
nym=(ny-1)/2+1;
%[nxm,nym] = size( f );
dh=1/(nx-1);
dhm=1/(nxm-1);
[X,Y] = meshgrid(0:dh:1);
[XI,YI] = meshgrid(0:dhm:1);

fc=interp2(X,Y,r,XI,YI,'linear');


