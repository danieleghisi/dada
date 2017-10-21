function [Xout, Yout] = dg_plot_bezier_contour(X, Y)
N = length(X);
t = linspace(0,1,101);

for i=1:3:N-2
%for i=1:3:4
    pt1 = [X(i) Y(i)]';
    pt2 = [X(i+1) Y(i+1)]';
    pt3 = [X(i+2) Y(i+2)]';
    pt4 = [X(i+3) Y(i+3)]';
    pts = kron((1-t).^3,pt1) + kron(3*(1-t).^2.*t,pt2) + kron(3*(1-t).*t.^2,pt3) + kron(t.^3,pt4);

    hold on
    plot(pts(1,:),pts(2,:), 'b-', 'LineWidth',2);
end


%plot(X, Y, 'k*');