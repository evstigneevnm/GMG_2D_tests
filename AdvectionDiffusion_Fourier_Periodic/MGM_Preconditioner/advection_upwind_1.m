function [ adv_u ] = advection_upwind_1(vel_x, vel_y,  u, j, k, hx, hy )
%defines upwind advection for variable field 'vel'
    
    [Nx,Ny]=size(u);
    [jp,kp] = periodic_indexing(Nx,Ny,j+1,k+1);
    [jm,km] = periodic_indexing(Nx,Ny,j-1,k-1);
    
    vw = 0.5*(vel_x(k,j)+vel_x(k,jm));
    ve = 0.5*(vel_x(k,j)+vel_x(k,jp));
    vn = 0.5*(vel_y(k,j)+vel_y(km,j));
    vs = 0.5*(vel_y(k,j)+vel_y(kp,j));
%    
%    vw_sp = 0.5*(vw+abs(vw));
%    vw_sm = 0.5*(vw-abs(vw));
%    ve_sp = 0.5*(ve+abs(ve));
%    ve_sm = 0.5*(ve-abs(ve));
%    vs_sp = 0.5*(vs+abs(vs));
%    vs_sm = 0.5*(vs-abs(vs));
%    vn_sp = 0.5*(vn+abs(vn));
%    vn_sm = 0.5*(vn-abs(vn));    

    vw_sp = 0.5*abs(sign(vw)+1);
    vw_sm = 0.5*abs(sign(vw)-1);
    ve_sp = 0.5*abs(sign(ve)+1);
    ve_sm = 0.5*abs(sign(ve)-1);
    vs_sp = 0.5*abs(sign(vs)+1);
    vs_sm = 0.5*abs(sign(vs)-1);
    vn_sp = 0.5*abs(sign(vn)+1);
    vn_sm = 0.5*abs(sign(vn)-1);      

    ue = ve_sp*u(k,j)+ve_sm*u(k,jp);
    uw = vw_sp*u(k,jm)+vw_sm*u(k,j);
    us = vs_sp*u(k,j)+vs_sm*u(kp,j);
    un = vn_sp*u(km,j)+vn_sm*u(k,j);
    
    adv_u = vel_x(k,j)*(ue-uw)/hx + vel_y(k,j)*(us-un)/hy;
    %adv_u = (ue-uw)/hx + (us-un)/hy;

    
end

