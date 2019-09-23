function [ v_out ] = C2R( x_hat )
% complex array to real vector of imaginary values    
    xE=imag(x_hat);
    [Nx,Ny]=size(xE);
    v1=xE(1,2:Nx/2)';
    v=zeros(Nx*(Ny/2-1),1);
    k=0;
    for j=2:Ny/2
        from=round((Nx)*k+1);
        to=round(Nx*(k+1));
        vll=xE(j,:)';
        v(from:to,1)=vll(1:end,1);
        k=k+1;
    end
    v2=xE(Ny/2+1,2:Nx/2)';
    v_out=v1;
    v_out=[v_out;v];
    v_out=[v_out; v2];
end

