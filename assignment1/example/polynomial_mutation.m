function z = polynomial_mutation(g, x_min, x_max)
    y = g;
    yl = x_min;
    yu = x_max;
    mum = 20;
    if y > yu
        if (y-yl)<(yu-yl)
            delta = (y-yl)/(yu-yl);
        else
            delta = (yu-y)/(yu-yl);
        end
        rnd = rand();
        indi = 1.0/(mum+1.0);
        if rnd <= 0.5
            xy = 1.0-delta;
            val = 2*rnd+(1-2*rnd)*(power(xy, mum+1));
            deltaq = power(val, indi)-1.0;
        else
            xy = 1.0 - delta;
            val = 2.0*(1.0-rnd)+2.0*(rnd-0.5)*(power(xy, mum+1));
            deltaq = 1.0 - power(val, indi);
        end
        y = y+deltaq*(yu-yl);
        if y < yl
            y = yl;
        end
        if y > yu
            y = yu;
        end
    else
        xy = rand();
        y = xy*(yu-yl)+yl;
    end
    z = y; 
end