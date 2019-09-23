function [ r ] = residual( z,b,mu )
% calculates residual

    [Nx,Ny]=size(b);
    r=zeros(Nx,Ny);
    Az=operator_adv(0,z,mu);
    for j=2:Nx-1
        for k=2:Ny-1
            r(j,k)=Az(j,k)-b(j,k);
        end
    end

end

