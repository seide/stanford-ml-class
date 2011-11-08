function [b,err]=linear_regression_grad_descent (x,y,b0,alpha)
plot_on=1;
b=b0;
err = Inf;
i=1;
finish=false;
err(i)=(1/2*size(x,2)) * sum((b(i,:)*x - y).^2);

m=size(x,2);
minx=min(x(1,:));
maxx=max(x(1,:));
while ~finish
    i=i+1;
    for k=1:size(b,2)
        tb(k) = b(i-1,k) - (1/m)*alpha*sum((b(i-1,k)*x(k,:)-y)*x(k,:)'); 
        %tb(k)=b(k) - (1/m)*alpha*sum((b(k)*x(k,:)-y)*x(k,:)');
    end
    
    b(i,:)=tb;
    
    err(i) = (1/(2*m)) * sum((b(i,:)*x - y).^2);
%    err(i) = (1/(2*m)) * sum((b*x - y).^2);
    
    if  i > 1 && (abs(err(i) - err(i-1)) < 1e-5 || err(i) > err(i-1)) 
        finish=true;
    end
    %if i > 1000
    %    finish=true;
    %end
if size(x,1) == 2 && plot_on
    subplot(1,2,1);
    plot(x(1,:),y,'.');
    hold on;
    plot([minx maxx],[b(i,2)+minx*b(i,1) b(i,2)+maxx*b(i,1)],'r-')
    %plot([minx maxx],[b(2)+minx*b(1) b(2)+maxx*b(1)],'r-')
    
    subplot(1,2,2)
end
if plot_on
    plot(err(end-min(i-1,50):end));
    if ~finish 
        pause(.1);clf;
    end
end    
    
end
if size(x,1) == 2 && plot_on

    subplot(1,2,1);
    br=regress(y',x');
    plot([minx maxx],[br(2)+minx*br(1) br(2)+maxx*br(1)],'g-o')
end
end