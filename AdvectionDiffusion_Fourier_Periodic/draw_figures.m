fig_1 = 1;
Markers = {'+','o','*','x','v','d','^','s','>','<'};

sz_min = 4;
sz_max = 9;
R_min = 3;
R_max = 4;

for sz_pow = sz_min:sz_max
    
    figure(fig_1);

    Marker_Counter=1;
    for rey_power = R_min:R_max
        Nx = DATA{sz_pow, rey_power}{2};
        Ny = DATA{sz_pow, rey_power}{3};
        Rey = DATA{sz_pow, rey_power}{4};
        res_n = DATA{sz_pow, rey_power}{6};
        %res_n = res_n./res_n(1,1);
        str1 = sprintf('R=%i', Rey);
        str2 = sprintf('%i X %i', Nx, Ny);
        semilogy(res_n, strcat('-',Markers{Marker_Counter}) ,'DisplayName',str1);
        set(findall(gcf,'-property','FontSize'),'FontSize',16)
        xlabel('iterations', 'FontSize', 16);
        ylabel('residual', 'FontSize', 16);
        title(str2);
        hold on;
        Marker_Counter = Marker_Counter + 1;
    end
    hold off;
    grid on;
    legend show;
    file_name = sprintf('Figures/%ix%i.eps', Nx, Ny);
    saveas(gcf, file_name,'epsc');
    fig_1=fig_1+1;
    
end
for rey_power = R_min:R_max
    
    figure(fig_1);
    Marker_Counter=1;
    for sz_pow = sz_min:sz_max
        Nx = DATA{sz_pow, rey_power}{2};
        Ny = DATA{sz_pow, rey_power}{3};
        Rey = DATA{sz_pow, rey_power}{4};
        res_n = DATA{sz_pow, rey_power}{6};
        %res_n = res_n./res_n(1,1);
        str1 = sprintf('R=%i', Rey);
        str2 = sprintf('%i X %i', Nx, Ny);
        semilogy(res_n, strcat('-',Markers{Marker_Counter}) ,'DisplayName',str2);
        title(str1);
        set(findall(gcf,'-property','FontSize'),'FontSize',16)
        xlabel('iterations', 'FontSize', 16);
        ylabel('residual', 'FontSize', 16);
        hold on;
        Marker_Counter = Marker_Counter + 1;
    end
    hold off;
    grid on;
    legend show;
    file_name = sprintf('Figures/R%i.eps', Rey);
    saveas(gcf, file_name,'epsc');
    fig_1=fig_1+1;
    
end

pause;
close all;
