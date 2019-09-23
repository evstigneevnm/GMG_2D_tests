function [A, iP] = get_spectra(Nx, Ny, mu)
% analysis of the matrix spectrum
    %P = Form_Matrix_precond(Nx, Ny, mu);
    iP = Form_Matrix_i_precond(Nx, Ny, mu);
    A = Form_Matrix(Ny, Nx, mu);
    lA = eig(A);
    lP = eig(iP);
    %iPA=P\A;
    iPA = iP*A;
    iA = inv(A);
    liA = eig(iA);
    liPA = eig(iPA);
    figure(2);
    plot(real(liPA),imag(liPA), '*');
    grid on;
    hold on;
    plot(real(1+exp(1i.*[1:300]/300*2*pi)), imag(exp(1i.*[1:300]/300*2*pi)),'-');
    axis equal;
    hold off;
    title('Preconditioned matrix');
    movegui('northeast');
    figure(3);
    %plot(real(lA), imag(lA),'o', real(lP),imag(lP),'*');
    plot(real(lA), imag(lA),'o');
    grid on;
    title('Original matrix');
    movegui('northwest');
    figure(1);
    clf;
    title('Matrix inverse and preconditioner');
    hold on;
    plot(real(liA), imag(liA), '.');
    plot(real(lP), imag(lP), 'o');
    grid on;
        plot(real(1+exp(1i.*[1:300]/300*2*pi)), imag(exp(1i.*[1:300]/300*2*pi)),'-');
    hold off;    
    movegui('north');
    
end
