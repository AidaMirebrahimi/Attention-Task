function [x,y,X,Y]=location(xc,yc,theta0,theta,r1,r2,quad)
theta0=deg2rad(theta0);
theta=deg2rad(theta);
x=xc+(r1/sqrt(1+tan(theta0)^2));
y=yc+sqrt(r1^2-(x-xc)^2);
h=(-r1*cos(theta))+sqrt((r1^2)*(cos(theta)^2)+(r2^2)-(r1^2));
X1=- (h^2 - r2^2 - x^2 + xc^2 - y^2 + yc^2)/(2*(x - xc)) - ((y - yc)*(x*((h^2 + 2*h*r2 + r2^2 - x^2 + 2*x*xc - xc^2 - y^2 + 2*y*yc - yc^2)*(- h^2 + 2*h*r2 - r2^2 + x^2 - 2*x*xc + xc^2 + y^2 - 2*y*yc + yc^2))^(1/2) - xc*((h^2 + 2*h*r2 + r2^2 - x^2 + 2*x*xc - xc^2 - y^2 + 2*y*yc - yc^2)*(- h^2 + 2*h*r2 - r2^2 + x^2 - 2*x*xc + xc^2 + y^2 - 2*y*yc + yc^2))^(1/2) - h^2*y + h^2*yc + r2^2*y - r2^2*yc + x^2*y + x^2*yc + xc^2*y + xc^2*yc - y*yc^2 - y^2*yc + y^3 + yc^3 - 2*x*xc*y - 2*x*xc*yc))/(2*(x - xc)*(x^2 - 2*x*xc + xc^2 + y^2 - 2*y*yc + yc^2));
X2=- (h^2 - r2^2 - x^2 + xc^2 - y^2 + yc^2)/(2*(x - xc)) - ((y - yc)*(xc*((h^2 + 2*h*r2 + r2^2 - x^2 + 2*x*xc - xc^2 - y^2 + 2*y*yc - yc^2)*(- h^2 + 2*h*r2 - r2^2 + x^2 - 2*x*xc + xc^2 + y^2 - 2*y*yc + yc^2))^(1/2) - x*((h^2 + 2*h*r2 + r2^2 - x^2 + 2*x*xc - xc^2 - y^2 + 2*y*yc - yc^2)*(- h^2 + 2*h*r2 - r2^2 + x^2 - 2*x*xc + xc^2 + y^2 - 2*y*yc + yc^2))^(1/2) - h^2*y + h^2*yc + r2^2*y - r2^2*yc + x^2*y + x^2*yc + xc^2*y + xc^2*yc - y*yc^2 - y^2*yc + y^3 + yc^3 - 2*x*xc*y - 2*x*xc*yc))/(2*(x - xc)*(x^2 - 2*x*xc + xc^2 + y^2 - 2*y*yc + yc^2));
Y1=(x*((h^2 + 2*h*r2 + r2^2 - x^2 + 2*x*xc - xc^2 - y^2 + 2*y*yc - yc^2)*(- h^2 + 2*h*r2 - r2^2 + x^2 - 2*x*xc + xc^2 + y^2 - 2*y*yc + yc^2))^(1/2) - xc*((h^2 + 2*h*r2 + r2^2 - x^2 + 2*x*xc - xc^2 - y^2 + 2*y*yc - yc^2)*(- h^2 + 2*h*r2 - r2^2 + x^2 - 2*x*xc + xc^2 + y^2 - 2*y*yc + yc^2))^(1/2) - h^2*y + h^2*yc + r2^2*y - r2^2*yc + x^2*y + x^2*yc + xc^2*y + xc^2*yc - y*yc^2 - y^2*yc + y^3 + yc^3 - 2*x*xc*y - 2*x*xc*yc)/(2*(x^2 - 2*x*xc + xc^2 + y^2 - 2*y*yc + yc^2));
Y2=(xc*((h^2 + 2*h*r2 + r2^2 - x^2 + 2*x*xc - xc^2 - y^2 + 2*y*yc - yc^2)*(- h^2 + 2*h*r2 - r2^2 + x^2 - 2*x*xc + xc^2 + y^2 - 2*y*yc + yc^2))^(1/2) - x*((h^2 + 2*h*r2 + r2^2 - x^2 + 2*x*xc - xc^2 - y^2 + 2*y*yc - yc^2)*(- h^2 + 2*h*r2 - r2^2 + x^2 - 2*x*xc + xc^2 + y^2 - 2*y*yc + yc^2))^(1/2) - h^2*y + h^2*yc + r2^2*y - r2^2*yc + x^2*y + x^2*yc + xc^2*y + xc^2*yc - y*yc^2 - y^2*yc + y^3 + yc^3 - 2*x*xc*y - 2*x*xc*yc)/(2*(x^2 - 2*x*xc + xc^2 + y^2 - 2*y*yc + yc^2));
if theta<0
    X=X2;
    Y=Y2;
else
    X=X1;
    Y=Y1;
end
x=round(x);
y=round(y);
X=round(X);
Y=round(Y);
if quad==1
    y=2*yc-y;
    Y=2*yc-Y;
elseif quad==2
    x=2*xc-x;
    X=2*xc-X;
    y=2*yc-y;
    Y=2*yc-Y; 
elseif quad==3
    x=2*xc-x;
    X=2*xc-X;
end
end