load wind
xmin = min(x(:));
xmax = max(x(:));
ymin = min(y(:));
ymax = max(y(:));
zmin = min(z(:));
zmax = max(z(:));

wind_speed = sqrt(u.^2 + v.^2 + w.^2);
hsurfaces = slice(x,y,z,wind_speed,[xmin,100,xmax],ymax,zmin);
set(hsurfaces,'FaceColor','interp','EdgeColor','none')
colormap jet

[sx,sy,sz] = meshgrid(xmin+10,ymin+3,zmin+1);

Queue = [sx sy sz];
tempx = sx;
tempy = sy;
tempz = sz;
dsepy = 10;

%Queue = [Queue;[tempx,tempy,tempz]];
i = 1; j = 1 ;

hlines = streamline(x,y,z,u,v,w,sx,sy,sz);
set(hlines,'LineWidth',0.5,'Color','r') ;

dsepz = 1;

while tempy <= ymax
    while tempz <= zmax    
        hlines = streamline(x,y,z,u,v,w,Queue(i,1),Queue(i,2),Queue(i,3));
        i = i + 1;
        set(hlines,'LineWidth',0.5,'Color','r');
        
        Queue = [Queue;[tempx,tempy,tempz]];
        tempz = tempz +dsepz;
        
    end
    tempy = tempy + dsepy;
    tempz = sz;
    i = 1;
    Queue = [sx, tempy, sz];
      
end
 
 
view(3)
daspect([2,2,1])
axis tight
% For different dsep distance
figure(2);
hsurfaces = slice(x,y,z,wind_speed,[xmin,100,xmax],ymax,zmin);
set(hsurfaces,'FaceColor','interp','EdgeColor','none')
colormap jet
%hold on;
dsepy = 2;
dsepz = 0.2;
while tempy <= ymax
    while tempz <= zmax 
        figure(2);
        hlines = streamline(x,y,z,u,v,w,Queue(i,1),Queue(i,2),Queue(i,3));
        hold on;
        i = i + 1;
        %figure(2);
        set(hlines,'LineWidth',0.5,'Color','r');
        hold on;
        Queue = [Queue;[tempx,tempy,tempz]];
        tempz = tempz +dsepz;
        
    end
    tempy = tempy + dsepy;
    tempz = sz;
    i = 1;
    Queue = [sx, tempy, sz];
      
end
 
view(3)
daspect([2,2,1])
axis tight