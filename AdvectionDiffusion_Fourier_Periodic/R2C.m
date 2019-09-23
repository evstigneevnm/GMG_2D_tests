function [ x_hat ] = R2C( xV )
% Real vactor to complex array

    [Nr,~]=size(xV);
    Nx=sqrt(2*(Nr+2));
    Ny=Nx;
    xE=zeros(Nx,Ny);
    

    xE(1,2:Nx/2)=xV(1:Nx/2-1);
    xE(1,(Nx/2+2):Nx)=-xV(Nx/2-1:-1:1);

    shift=Nx/2-1;
    to=0;
    k=0;
    for j=2:Ny/2
        from=round((Nx)*k+1)+shift;
        to=round(Nx*(k+1))+shift;
        vll=xV(from:to,1)';
        xE(j,:)=vll;        
        k=k+1;
    end
    
    xE(Ny/2+1,2:Nx/2)=xV(to+1:to+Nx/2-1);
    xE(Ny/2+1,(Nx/2+2):Nx)=-xV(to+Nx/2-1:-1:to+1);
    
    xE(Ny/2+2:Ny,1)=-xE(Ny/2:-1:2,1);  
    
    xE(Ny/2+2:Ny,2:Nx/2)=-xE(Ny/2:-1:2,Nx:-1:Nx/2+2);
    xE(Ny/2+2:Ny,Nx/2+2:Nx)=-xE(Ny/2:-1:2,Nx/2:-1:2);
    
    xE(Ny/2+2:Ny,Nx/2+1)=-xE(Ny/2:-1:2,Nx/2+1);
    
    x_hat=1i.*xE;
    

end

