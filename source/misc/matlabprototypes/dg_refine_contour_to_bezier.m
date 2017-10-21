function [Xout, Yout] = dg_refine_contour_to_bezier(X, Y, X_blue, Y_blue, X_red, Y_red, starting_factor, factor_factor)
% output will be: knot, control point1, controlpoint2, knot, cp1, cp2,
% knot, cp1, cp2...
N = length(X);
Xout = [];
Yout = [];

% working copies
Xwk = [X X(2)];
Ywk = [Y Y(2)];

Xpt = [X_blue X_red];
Ypt = [Y_blue Y_red];

for i=1:N-1
    % analizing segment between knot i, i+1 and i+2
    factor = starting_factor;
    while factor > 0.001 % we set a threshold
        P1 = [Xwk(i) Ywk(i)] .* factor + [Xwk(i+1) Ywk(i+1)] .* (1-factor);
        P2 = [Xwk(i+1) Ywk(i+1)] .* (1-factor) + [Xwk(i+2) Ywk(i+2)] .* factor;
        X_triangle = [P1(1) Xwk(i+1) P2(1) P1(1)];
        Y_triangle = [P1(2) Ywk(i+1) P2(2) P1(2)];
%        plot(X_triangle, Y_triangle, 'k');
        I = inpolygon(Xpt, Ypt, X_triangle, Y_triangle);
        if sum(I) == 0
            break;
        end
        factor = factor * factor_factor;
    end
    
    % append knots and control points
    if i > 1
        P = [Xout(length(Xout)) Yout(length(Xout))];
        C1 = P .* 0.66 + P1 .* 0.34;
        C2 = P .* 0.34 + P1 .* 0.66;
        Xout = [Xout C1(1) C2(1)];
        Yout = [Yout C1(2) C2(2)];
    end
    
    Xout = [Xout P1(1) Xwk(i+1) Xwk(i+1) P2(1)];
    Yout = [Yout P1(2) Ywk(i+1) Ywk(i+1) P2(2)];

end

Xout = [Xout(1:end-1) Xout(1)];
Yout = [Yout(1:end-1) Yout(1)];
