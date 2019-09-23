function u = prolongator(uc)
% function u = ctof( uc )
%
% Transfers a coarse grid to a fine grid (bilinear interpolation)
%
% Input
%   uc    coarse-grid function
%
% Returns
%   u     fine-grid function
%

[nx,ny] = size( uc );
%[nxm,nym] = size( u );
nxm=(nx-1)*2+1;
nym=(ny-1)*2+1;
dh=1/(nx-1);
dhm=1/(nxm-1);
[X,Y] = meshgrid(0:dh:1);
[XI,YI] = meshgrid(0:dhm:1);

u=interp2(X,Y,uc,XI,YI,'linear');