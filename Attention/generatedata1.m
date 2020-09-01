%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%....WRITEN BY THE SAVAGE TODDLERS....%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function final=generatedata1(nBlocks,nParameters)
nTrialperblock=2^(nParameters+1);
final=[];
block=ones(nBlocks*nTrialperblock,1);
m=1;
h=1;
for i=1:nBlocks
    c = dec2bin(0:(nTrialperblock/4)-1);
    s = num2cell(c);
    s=str2double(s);
    rh=ones(nTrialperblock/4,1);
    rs=[rh,s];
    cr = dec2bin(0:(nTrialperblock/8)-1);
    sr = num2cell(cr);
    sr=str2double(sr);
    rrh=ones(nTrialperblock/8,1);
    rrt=zeros(nTrialperblock/8,1)+2;
    rrs=cat(2,rrt,sr);
    rrs=cat(2,rrh,rrs);
    rs=[rs;rrs];
    arh=ones(nTrialperblock/4,1);
    ars=cat(2,arh,s);
    asr = num2cell(cr);
    asr=str2double(asr);
    arrh=ones(nTrialperblock/8,1);
    arrt=zeros(nTrialperblock/8,1)+2;
    arrs=cat(2,arrt,asr);
    arrs=cat(2,arrh,arrs);
    ars=[ars;arrs];
    block=ones();
    for i=2:nParameters+1
        for j=1:nTrialperblock/4
            rcondition(j,i)=rs(j,i-1);
        end
    end
    for k=1:nTrialperblock/4
        rcondition(k,1)=k;
    end
    for i=2:nParameters+1
        for j=1:nTrialperblock/4
            rcondition2(j,i)=rs(j,i-1);
        end
    end
    for i=1:nTrialperblock/4
        if rcondition2(i,3)==0
            rcondition2(i,3)=2;
        end
        if rcondition2(i,3)==1
            rcondition2(i,3)=3;
        end
    end
    for k=1:nTrialperblock/4
        rcondition2(k,1)=k+nTrialperblock/4;
    end
    rcondition3=cat(1,rcondition,rcondition2);
    q=randperm(nTrialperblock/2);
    for i=1:nParameters+1
        for j=1:nTrialperblock/2
            n=q(j);
            rcondit(j,i)=rcondition3(n,i);
        end
    end
    for i=2:nParameters+1
        for j=1:nTrialperblock/4
            arcondition(j,i)=ars(j,i-1);
        end
    end
    for k=1:nTrialperblock/4
        arcondition(k,1)=k+nTrialperblock/2;
    end
    for i=2:nParameters+1
        for j=1:nTrialperblock/4
            arcondition2(j,i)=ars(j,i-1);
        end
    end
    for i=1:nTrialperblock/4
        if arcondition2(i,3)==0
            arcondition2(i,3)=2;
        end
        if arcondition2(i,3)==1
            arcondition2(i,3)=3;
        end
    end
    %%%%%
    for k=1:nTrialperblock/4
        arcondition2(k,1)=k+nTrialperblock*3/4;
    end
    arcondition3=cat(1,arcondition,arcondition2);
    q=randperm(nTrialperblock/2);
    for i=1:nParameters+1
        for j=1:nTrialperblock/2
            n=q(j);
            arcondit(j,i)=arcondition3(n,i);
        end
    end
    ax=randperm(2);
    if ax(1)==1
        condit=cat(1,rcondit,arcondit);
    else
        condit=cat(1,arcondit,rcondit);
    end
     final=cat(1,final,condit);
end
for i=1:nBlocks*nTrialperblock
    if i<nTrialperblock*m
        block(i,1)=m;
    else
        m=m+1;
        block(i,1)=m;
    end
end
final=cat(2,block,final);
for i= 1:nBlocks*nTrialperblock
    iti(i) =1+(2-1)*rand(1,1);
end
iti=iti.';
final=cat( 2,final,iti);
x=4;
a=[100 100 100 900];
n=a;
t=1000;
i=100;
while a(x-3)<900
    if a(x)>0
       a(x)=a(x)-100;
        a(x-1)=a(x-1)+100;
        if a(x)>0 && a(x)<400
            n=cat(1,n,a);
        end
    elseif a(x-1)==t
       a(x-2)=a(x-2)+100;
        a(x-1)=100;
        a(x)=1200-a(x-1)-a(x-2)-a(x-3);
        t=t-100; 
        if a(x)>0 && a(x)<400
            n=cat(1,n,a);
        end
    else
        t=1000-i;
        a(x-3)=a(x-3)+100;
        a(x-2)=100;
        a(x-1)=100;
        a(x)=1200-a(x-1)-a(x-2)-a(x-3);                                                                                                  
        if a(x)>0 && a(x)<400
            n=cat(1,n,a);
        end
        i=i+100;
    end
end
n(1,:)=[];
p=[];
for i=1:5
    px=Shuffle(n);
    p=cat(1,p,px);
end
p=p/1000;
p(nBlocks*nTrialperblock/2+1:length(p),:)=[];
for i=1:nBlocks*nTrialperblock
  if final(i,3)==1
      final(i,nParameters+4)=0.233;
      final(i,nParameters+5)=0.3;
      final(i,nParameters+6)=0.3;
      final(i,nParameters+7)=0.3;
  else
      final(i,nParameters+4)=p(h,1);
      final(i,nParameters+5)=p(h,2);
      final(i,nParameters+6)=p(h,3);
      final(i,nParameters+7)=p(h,4);
      h=h+1;
  end
end
ar=ones(nBlocks*nTrialperblock,1);
ar=ar*0.3;
final=cat(2,final,ar);
final(:,nParameters+8:nParameters+15)=NaN;
end