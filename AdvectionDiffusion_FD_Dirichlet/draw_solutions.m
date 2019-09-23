fig_1 = 1;

grid = 7;
Rey_min = 2;
Rey_max = 4;
Solution_number = 'a1';

for Rey = Rey_min:Rey_max
    figure(fig_1);
    Nx = DATA{grid, Rey}{2};
    Ny = DATA{grid, Rey}{3};
    [X,Y] = meshgrid(0:1/Nx:1);
    Rey_val = DATA{grid, Rey}{4};
    mesh(X,Y, DATA{7,Rey}{7});
    set(findall(gcf,'-property','FontSize'),'FontSize',16)
    xlabel('x', 'FontSize', 16);
    ylabel('y', 'FontSize', 16);
    zlabel('u', 'FontSize', 16);
    str1 = sprintf('R=%i', Rey_val);
    title(str1);
    fig_1 = fig_1 + 1;
    file_name = sprintf('Figures/%s_%i.eps',Solution_number, Rey_val);
    saveas(gcf, file_name,'epsc');

end