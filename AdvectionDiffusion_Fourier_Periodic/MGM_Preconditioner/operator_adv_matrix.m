function [ A ] = operator_adv_matrix(Nx, Ny, mu)
%   Definition of multilevel operator function
    hx=2.*pi/Nx;
    hy=2.*pi/Ny;
    [ vel_x, vel_y ] = velocity_field(Nx, Ny); 
    
    A=zeros(Nx*Ny, Nx*Ny);
    
    for j=1:Nx
        for k=1:Ny

            [jp, kp] = periodic_indexing(Nx, Ny, j+1, k+1);
            [jm, km] = periodic_indexing(Nx, Ny, j-1, k-1);

            I = II(Nx, Ny, j, k);
            Ijp = II(Nx, Ny, jp, k);
            Ijm = II(Nx, Ny, jm, k);
            Ikp = II(Nx, Ny, j, kp);
            Ikm = II(Nx, Ny, j, km);
            
            vw = 0.5*(vel_x(k,j)+vel_x(k,jm));
            ve = 0.5*(vel_x(k,j)+vel_x(k,jp));
            vn = 0.5*(vel_y(k,j)+vel_y(km,j));
            vs = 0.5*(vel_y(k,j)+vel_y(kp,j));     
            
            vw_sp = 0.5*abs(sign(vw)+1);
            vw_sm = 0.5*abs(sign(vw)-1);
            ve_sp = 0.5*abs(sign(ve)+1);
            ve_sm = 0.5*abs(sign(ve)-1);
            vs_sp = 0.5*abs(sign(vs)+1);
            vs_sm = 0.5*abs(sign(vs)-1);
            vn_sp = 0.5*abs(sign(vn)+1);
            vn_sm = 0.5*abs(sign(vn)-1);      
              
            s = 1;
            A(I,I)   = s*(vel_x(k,j)*(ve_sp - vw_sm )/hx + vel_y(k,j)*(vs_sp - vn_sm )/hy);
            A(I,Ijp) = s*(vel_x(k,j)*ve_sm/hx);
            A(I,Ijm) = s*(-vel_x(k,j)*vw_sp/hx);
            A(I,Ikp) = s*(vel_y(k,j)*vs_sm/hy);
            A(I,Ikm) = s*(-vel_y(k,j)*vn_sp/hy);            
            
            
            A(I,I) = A(I,I) + mu*((-2)/(hx^2)+(-2)/(hy^2));
            A(I,Ijp) = A(I,Ijp) + mu/(hx^2);
            A(I,Ijm) = A(I,Ijm) + mu/(hx^2);
            A(I,Ikp) = A(I,Ikp) + mu/(hy^2);
            A(I,Ikm) = A(I,Ikm) + mu/(hy^2);
                        
            
        end
    end

end

