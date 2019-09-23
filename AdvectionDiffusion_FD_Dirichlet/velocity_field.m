function [ vel_x, vel_y ] = velocity_field( Nx, Ny )


    vel_x=zeros(Nx,Ny);
    vel_y=zeros(Nx,Ny);
    for j=2:Nx-1
        for k=2:Ny-1
            x=((j-1)-(Nx-1)/2)/(Nx-1);
            y=((k-1)-(Ny-1)/2)/(Ny-1);
            r=5*sqrt(x*x+y*y);
            vel_x(j,k)= y*(cos(x/(r+1.0e-12))-sin(y/(r+1.0e-12)))/(power(r,2)+1.0e-5)*10;
            vel_y(j,k)=-x*(sin(x/(r+1.0e-12))+cos(y/(r+1.0e-12)))/(power(r,2)+1.0e-5)*10;
        end
    end
    
    for j=1:Nx
       for k=1:Ny

       %vel_x(j,k)=sqrt(2)/2;
       %vel_y(j,k)=sqrt(2)/2;
       end
    end

end

