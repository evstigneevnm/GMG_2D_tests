function [ v_out ] = Ph2R( x_ph )
% physical space array to real vector of imaginary values    
    
    x_hat = fft2(x_ph);
    v_out = C2R( x_hat );

end