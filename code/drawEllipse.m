function p = drawEllipse(c1, c2, r1, r2)

t=-pi:0.01:pi;
x=c1+r1*cos(t);
y=c2+r2*sin(t);
p = plot(x,y);