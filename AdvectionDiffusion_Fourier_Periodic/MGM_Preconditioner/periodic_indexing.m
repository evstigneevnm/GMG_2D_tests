function [j,k] = periodic_indexing(Nx,Ny,jp,kp)
% Implements periodic indexing


        j=jp;
        k=kp;
        if(jp<1)
            j=Nx+jp;
        end
        if(jp>Nx)
            j=jp-Nx;
        end
        if(kp<1)
            k=Ny+kp;
        end
        if(kp>Ny)
            k=kp-Ny;
        end 
        
end

