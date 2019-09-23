function [z1, z2] = sbx(g1, g2, x_min, x_max)
    
    par1 = g1;
    par2 = g2;
    yl = x_min;
    yu = x_max;
    rnd = rand();
    mu = 20;
    % chech whether variable is selected or not
    if rnd <= 0.5
        if abs(par1-par2)>0.000001
            if par2 > par1
                y2 = par2;
                y1 = par1;
            else
                y2 = par1;
                y1 = par2;
            end
            % find beta
            if (y1-yl)>(yu-y2)
                beta = 1+(2*(yu-y2)/(y2-yl));
            else
                beta = 1+(2*(y1-yl)/(y2-y1));
            end
            % find alpha
            expp = mu + 1;
            beta = 1.0/beta;
            alpha = 2.0 - power(beta, expp);
            if alpha <0
                error('ERROR');
            end
            rnd = rand();
            if rnd <=1.0/alpha
                alpha = alpha*rnd;
                expp = 1.0/(mu+1.0);
                betaq = power(alpha, expp);
            else
                alpha = alpha*rnd;
                alpha = 1.0/(2.0-alpha);
                expp = 1/(mu+1.0);
                if alpha < 0.0
                    error('ERROR');
                end
                betaq = power(alpha, expp);
            end
            chld1 = 0.5*((y1+y2)-betaq*(y2-y1));
            chld2 = 0.5*((y1+y2)+betaq*(y2-y1));
        else
            betaq = 1.0;
            y1 = par1;
            y2 = par2;
            chld1 = 0.5*((y1+y2)-betaq*(y2-y1));
            chld2 = 0.5*((y1+y2)+betaq*(y2-y1));
        end
        if chld1 < yl
            chld1 = yl;
        end
        if chld1 > yu
            chld1 = yu;
        end
        if chld2 < yl
            chld2 = yl;
        end
        if chld2 > yu
            chld2 = yu;
        end
    else
        chld1 = par1;
        chld2 = par2;
    end

    z1 = chld1;
    z2 = chld2; 

end