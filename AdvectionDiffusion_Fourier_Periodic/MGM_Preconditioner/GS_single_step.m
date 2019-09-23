function [z_new] = GS_single_step(jc, kc, jp, kp, jm, km, vel_x, vel_y, z_new, b, hx, hy, mu)
% Singel step of GS smoother

                vw = 0.5*(vel_x(kc,jc)+vel_x(kc,jm));
                ve = 0.5*(vel_x(kc,jc)+vel_x(kc,jp));
                vn = 0.5*(vel_y(kc,jc)+vel_y(km,jc));
                vs = 0.5*(vel_y(kc,jc)+vel_y(kp,jc));
                vw_sp = 0.5*abs(sign(vw)+1);
                vw_sm = 0.5*abs(sign(vw)-1);
                ve_sp = 0.5*abs(sign(ve)+1);
                ve_sm = 0.5*abs(sign(ve)-1);
                vs_sp = 0.5*abs(sign(vs)+1);
                vs_sm = 0.5*abs(sign(vs)-1);
                vn_sp = 0.5*abs(sign(vn)+1);
                vn_sm = 0.5*abs(sign(vn)-1);
                                
                lhs = (vel_x(kc,jc)*ve_sp/hx-vel_x(kc,jc)*vw_sm/hx+vel_y(kc,jc)*vs_sp/hy-vel_y(kc,jc)*vn_sm/hy);
                lhs = lhs + 2*mu*(1.0/hx/hx+1.0/hy/hy);
                adv = -(vel_x(kc,jc)*ve_sm*z_new(kc,jp)/hx-vel_x(kc,jc)*vw_sp*z_new(kc,jm)/hx+vel_y(kc,jc)*vs_sm*z_new(kp,jc)/hy-vel_y(kc,jc)*vn_sp*z_new(km,jc)/hy );
                z_new(kc,jc) = (adv+mu*(z_new(kc,jm)/hx/hx + z_new(kc,jp)/hx/hx + z_new(km,jc)/hy/hy + z_new(kp,jc)/hy/hy) + b(kc,jc))/lhs;
   
end

