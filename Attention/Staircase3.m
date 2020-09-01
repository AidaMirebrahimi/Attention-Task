%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%....WRITEN BY THE SAVAGE TODDLERS....%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [thdistance, cdistance, sidedata]=Staircase3(s1nBlocks,finalangle)
Screen('Preference', 'SkipSyncTests', 1);
KbName('UnifyKeyNames');
Key1=KbName('upArrow'); Key2=KbName('downArrow');
spaceKey = KbName('space'); escKey = KbName('ESCAPE');
corrkey = [38, 40]; % up and dowm arrow
white = [255 255 255]; black = [ 0 0 0];grey = [125 125 125];
Beep1 = MakeBeep(400, 0.05);
Beep2 = MakeBeep(800, 0.05);
crosslength=10;
crosscolor=[39 39 39];
crosswidth=3;
crosslines=[-crosslength,0; crosslength,0; 0,-crosslength; 0,crosslength];
crosslines=crosslines';
k=0;
w=14;
r1=444;%distance between cue and fix
r2=500;%distance between target and fix
fangle1=360-2*finalangle;
fangle2=finalangle-180;
ci=1;
u=0;
q=0;
a=1;
quad=1;
angle=16;
nParameters=2;
correct=0;
nTrialperblock=2^(nParameters+1);
final=generatedata(s1nBlocks,nParameters);
screens=Screen('Screens');
screenNumber=max(screens);
[mainwin, screenrect] = Screen('OpenWindow',screenNumber,[125 125 125] );
topPriortyLevel=MaxPriority(mainwin);
xCenter=screenrect(3)/2;
yCenter=screenrect(4)/2;
theta1=30;
theta2=60;
%   Experimental instructions, wait for a spacebar response to start
Screen('TextSize', mainwin, 24);
Screen('DrawText',mainwin,['Training set 2: Press spacebar to start the experiment.'] ,xCenter-550,yCenter -20,black);
Screen('Flip',mainwin );
wdis=tan(deg2rad(2));
xt1=round(sqrt(r2^2/(wdis^2+1)))+xCenter;
yt1=round(wdis*(xt1-xCenter)+yCenter);
keyIsDown=0;
while 1
    [keyIsDown, ~, keyCode] = KbCheck;
    if keyIsDown
        if keyCode(spaceKey)
            break ;
        elseif keyCode(escKey)
            ShowCursor;
            Screen('CloseAll');
            return;
        end
    end
end
WaitSecs(0.3); 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
for a=1:nTrialperblock*s1nBlocks
    [xc1,yc1,x1,y1]=location(xCenter,yCenter,theta1,w,r1,r2,quad); %30 deg cue/up
    [~,~,x2,y2]=location(xCenter,yCenter,theta1,-w,r1,r2,quad);%30 deg cue/down
    [xc2,yc2,x3,y3]=location(xCenter,yCenter,theta2,w,r1,r2,quad);%60 deg cue/up
    [~,~,x4,y4]=location(xCenter,yCenter,theta2,-w,r1,r2,quad);%60 deg cue/down
    if mod(a,4)==1
        Screen('DrawText',mainwin,'The block starts in 5 seconds' ,xCenter-(250*screenrect(3)/1920),yCenter -(20*screenrect(4)/1080),black);
        Screen('Flip', mainwin);
        WaitSecs(1);
        for tim=0:4
            at=5-tim;
            x=num2str(at);
            Screen('DrawText',mainwin,x ,xCenter,yCenter,black);
            Screen('Flip', mainwin);
            WaitSecs(1);
        end
        Screen('FillRect', mainwin, grey);
    end
    itt=final(a,nParameters+3);
    WaitSecs(itt);
    cueside=randi(2,1,1);
    switch cueside   %cue place
        case 1
            x=xc1;
            y=yc1;
            ctype=0;
        case 2 
            x=xc2;
            y=yc2;
            ctype=1;
    end
    topbottom=randi(2,1,1);
    switch topbottom
        case 1 %top
            targetnum=1;
        case 2  %botoom
            targetnum=2;
    end 
    updown=randi(2,1,1);
    switch updown %up/down
        case 1
            if ctype == 0
                xtarget=x1;
                ytarget=y1;
            else
                xtarget=x3;
                ytarget=y3;
            end
        case 2
            if ctype == 0
                xtarget=x2;
                ytarget=y2;
            else
                xtarget=x4;
                ytarget=y4;
            end
    end
    for i=1:9
        if i<5
            WaitSecs(0.3);
            Snd('Play', Beep1);
        end
        if i==1
            switch final(a,3) %rhythem
                case 1 
                    Screen('drawlines',mainwin,crosslines,crosswidth,[0 0 255],[xCenter,yCenter]);
                    Screen('Flip', mainwin);
                case 0
                    Screen('drawlines',mainwin,crosslines,crosswidth,[255 0 0],[xCenter,yCenter]);
                    Screen('Flip', mainwin);
            end
        end
        if i==2
            Screen('drawlines',mainwin,crosslines,crosswidth,[0 0 0],[xCenter,yCenter]);
            Screen('Flip', mainwin);
        end
        timest=GetSecs;
        if i==5
            WaitSecs(final(a,nParameters+4));
            final(a,nParameters+9)=GetSecs-timest;
            Snd('Play', Beep1);
        elseif i==6
            WaitSecs(final(a,nParameters+5));
            final(a,nParameters+10)=GetSecs-timest;
            Snd('Play', Beep1);
        elseif i==7
            WaitSecs(final(a,nParameters+6));
            final(a,nParameters+11)=GetSecs-timest;
            Snd('Play', Beep1);
        elseif i==8
            WaitSecs(final(a,nParameters+7));
            final(a,nParameters+12)=GetSecs-timest;
            Snd('Play', Beep1);
        elseif i==9
            WaitSecs(0.3);
            final(a,nParameters+13)=GetSecs-timest;
            Snd('Play', Beep1);
        end
        if i==4  %cue
            Screen('FillOval', mainwin,black,[(x-10)*screenrect(3)/1920,(y-10)*screenrect(4)/1080,(x+10)*screenrect(3)/1920,(y+10)*screenrect(4)/1080]);
            Screen('drawlines',mainwin,crosslines,crosswidth,[0 0 0],[xCenter,yCenter]);
            Screen('Flip', mainwin);
            WaitSecs(0.067);
        end
        if i==7
            Screen('drawlines',mainwin,crosslines,crosswidth,crosscolor,[xCenter,yCenter]);
            Screen('Flip', mainwin);
        end
        if i==9
            if targetnum==1       %uptarget
                Screen('FrameArc',mainwin,black,[(xtarget-10)*screenrect(3)/1920,(ytarget-10)*screenrect(4)/1080,(xtarget+10)*screenrect(3)/1920,(ytarget+10)*screenrect(4)/1080],finalangle,fangle1,4);
                Screen('drawlines',mainwin,crosslines,crosswidth,crosscolor,[xCenter,yCenter]);
                Screen('Flip', mainwin);
                WaitSecs(0.067);
                Screen('drawlines',mainwin,crosslines,crosswidth,crosscolor,[xCenter,yCenter]);
                Screen('Flip', mainwin);
                answer=1;
            end
            if targetnum==2       %downtarget
                Screen('FrameArc',mainwin,black,[(xtarget-10)*screenrect(3)/1920,(ytarget-10)*screenrect(4)/1080,(xtarget+10)*screenrect(3)/1920,(ytarget+10)*screenrect(4)/1080],fangle2,fangle1,4);
                Screen('drawlines',mainwin,crosslines,crosswidth,crosscolor,[xCenter,yCenter]);
                Screen('Flip', mainwin);
                WaitSecs(0.067);
                Screen('drawlines',mainwin,crosslines,crosswidth,crosscolor,[xCenter,yCenter]);
                Screen('Flip', mainwin);
                answer=2;
            end
        end
    end          
    Screen('drawlines',mainwin,crosslines,crosswidth,crosscolor,[xCenter,yCenter]);
    timeStart = GetSecs;keyIsDown=0; rt=0;keypressed=-1;       
    while GetSecs-timeStart<2
        [keyIsDown, ~, keyCode] = KbCheck;
        FlushEvents('keyDown');
        if keyIsDown
            nKeys = sum(keyCode);
            if nKeys==1
                if keyCode(Key1)||keyCode(Key2)
                    keypressed=find(keyCode);
                    if keypressed==corrkey(1)
                        final(a,nParameters+14)=0;
                    elseif keypressed==corrkey(2)
                        final(a,nParameters+14)=1;
                    end
                    rt = 1000.*(GetSecs-timeStart);
                    final(a,nParameters+15)=rt;
                    break;
                elseif keyCode(escKey)
                    Screen('CloseAll');
                end
                keyIsDown=0; keyCode=0;
            end
        end
    end
    if mod(a,8)==1
        u=u+1;
        if w<90
            if correct>5
                w=w+4;
            else
                w=w-4;
            end
        end
        if w>90
            if correct<5
                w=w-4;
            end
        end
        correct=0;
    end
    if (keypressed==corrkey(1)&&answer==1)||(keypressed==corrkey(2)&&answer==2)
        correct=correct+1;
    end        
    cdistance(u)=correct;
    sidedata(u)=w;
    if u>1
        if (cdistance(u)>5 && cdistance(u-1)<6) || (cdistance(u)<5 && cdistance(u-1)>6) || (ci==s1nBlocks)
            angla(ci)=w;
            ci=ci+1;
            q=q+1;
        else
            q=0;
        end
    end
    if q>4
        break;
    end
end
Screen('CloseAll');
if q>4
    if cdistance(u-1)>5
        thdistance=w+2;
    else
        thdistance=w;
    end
else
    final=mean(angla);
end
thdistance=w+4;
end