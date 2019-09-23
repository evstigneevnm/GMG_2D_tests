function [ r ] = residual( z, b, mu )
% calculates residual

    [Nx,Ny]=size(b);
    r=zeros(Nx,Ny);
    %Az = AD_linear_operator(z, mu);
    Az = operator_adv(0, z, mu);
    for j=1:Nx
        for k=1:Ny
            r(j,k) = Az(j,k) - b(j,k);
        end
    end

end

