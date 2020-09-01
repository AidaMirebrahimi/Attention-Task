%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%....WRITEN BY THE SAVAGE TODDLERS....%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function final=generatedata2(nBlocks,nParameter)
nParameters = 5;
d_var = nParameter;
nParameters=nParameters-1;
nTrialperblock=2^(nParameters-1)*5;
nTrialperblock1=nTrialperblock*2;
final=[];
block=ones(nBlocks*nTrialperblock1,1);
m=1;
h=1;
for j=1:nBlocks
    trialno=[];
    c = dec2bin(0:(nTrialperblock/5*2)-1);
    c1= dec2bin(0:(nTrialperblock/5)-1);
    s = str2double(num2cell(c));
    s1 = str2double(num2cell(c1));
    rcondit1 = [ones(nTrialperblock/5*2,1),s];
    rcondit2 = rcondit1;
    for i=1:length(rcondit2)
        if rcondit2(i,2)==0
            rcondit2(i,2)=2;
        elseif rcondit2(i,2)==1 
            rcondit2(i,2)=3;
        end
    end
    rh=[zeros(nTrialperblock/5,1)+4,s1];
    rcondit3 = [ones(nTrialperblock/5,1),rh];
    rcondition = [rcondit1;rcondit2;rcondit3];
    arcondition=rcondition;
    for i=1:length(rcondition)
        if rcondition(i,1)==1
            arcondition(i,1)=0;
        end
    end
    for k = 1:length(rcondition)
        trialno=[trialno;k];
    end
    rcondition=[trialno,rcondition];
    arcondition=[trialno,arcondition];
    rcondition = rcondition(randperm(size(rcondition,1)),:);
    arcondition = arcondition(randperm(size(arcondition,1)),:);
    a=randi(2,1);
    if a == 2
        condition=[rcondition;arcondition];
    else
        condition=[arcondition;rcondition];
    end
    condition=[zeros(length(condition),1)+j,condition];
    final=cat(1,final,condition);
end
% for i=1:nBlocks*nTrialperblock
%     if i<nTrialperblock*m
%         block(i,1)=m;
%     else
%         m=m+1;
%         block(i,1)=m;
%     end
% end
% final=cat(2,block,final);
for i= 1:nBlocks*nTrialperblock1
    iti(i) =1+(2-1)*rand(1,1);
end
iti=iti.';
final=cat(2,final,iti);
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
for i=1:10
    px=Shuffle(n);
    p=cat(1,p,px);
end
p=p/1000;
p(nBlocks*nTrialperblock1+1:length(p),:)=[];
for i=1:nBlocks*nTrialperblock1
  if final(i,3)==1
      final(i,nParameters+5)=0.233;
      final(i,nParameters+6)=0.3;
      final(i,nParameters+7)=0.3;
      final(i,nParameters+8)=0.3;
  else
      final(i,nParameters+5)=p(h,1);
      final(i,nParameters+6)=p(h,2);
      final(i,nParameters+7)=p(h,3);
      final(i,nParameters+8)=p(h,4);
      h=h+1;
  end
end
ar=ones(nBlocks*nTrialperblock1,1);
ar=ar*0.3;
final=cat(2,final,ar);
final(:,nParameters+10:nParameters+16)=NaN;
end