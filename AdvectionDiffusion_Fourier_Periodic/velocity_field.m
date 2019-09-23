function [ vel_x, vel_y ] = velocity_field( Nx, Ny )


    vel_x=zeros(Ny,Nx);
    vel_y=zeros(Ny,Nx);
    for j=2:Nx-1
        for k=2:Ny-1
            x=((j-1)-(Nx-1)/2)/(Nx-1);
            y=((k-1)-(Ny-1)/2)/(Ny-1);
            r=8*sqrt(x*x+y*y);
            vel_x(k,j)= y*(cos(x/(r+1.0e-12))-sin(y/(r+1.0e-12)))/(power(r,2)+1.0e-12);
            vel_y(k,j)=-x*(sin(x/(r+1.0e-12))+cos(y/(r+1.0e-12)))/(power(r,2)+1.0e-12);
        end
    end
    

    %vel_x = ones(Nx,1)*cos(2*pi*[1:Ny]./Ny);
    %vel_y = sin(2*pi*[1:Nx]./Nx)'*sin(2*pi*[1:Nx]./Nx);

    vel_x_E = Ph2R(vel_x);
    vel_y_E = Ph2R(vel_y);
    
    vel_x = R2Ph(vel_x_E);
    vel_y = R2Ph(vel_y_E);

end

