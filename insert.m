% 网格内插前
x=20:0.5:25;
y=5:0.1:6.4;
x_new=repmat(x,15,1);
x_new=x_new'
y_new=repmat(y',1,11);
y_new=y_new'
z=p3;
surf(x_new,y_new,z)

% 网格内插后
F = griddedInterpolant(x_new,y_new,z)
X = linspace(min(x_new(:)),max(x_new(:)),501);
Y = linspace(min(y_new(:)),max(y_new(:)),141);
[X,Y] = meshgrid(X,Y)
Z = F(X,Y)
figure
surf(X,Y,Z)