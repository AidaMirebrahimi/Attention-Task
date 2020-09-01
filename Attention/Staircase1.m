%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%....WRITEN BY THE SAVAGE TODDLERS....%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [correctdata, angledata, finalangle ]=Staircase1(s1nBlocks)
Screen('Preference', 'SkipSyncTests', 1);
KbName('UnifyKeyNames');
Key1=KbName('upArrow'); Key2=KbName('downArrow');
spaceKey = KbName('space'); escKey = KbName('ESCAPE');
corrkey = [38, 40]; % up and dowm arrow
white = [255 255 255]; black = [ 0 0 0];
Beep1 = MakeBeep(400, 0.05);
Beep2 = MakeBeep(800, 0.05);
crosslength=10;
crosscolor=[39 39 39];
crosswidth=3;
crosslines=[-crosslength,0; crosslength,0; 0,-crosslength; 0,crosslength];
crosslines=crosslines';
r1=500;
r2=650;
w1=2*pi/180;
w2=6*pi/180; 
w3=10*pi/180;
w4=14*pi/180;
ci=1;
u=0;
q=0;
a=1;
angle=16;
nParameters=2;
nTrialperblock=2^(nParameters+1);
final=generatedata(s1nBlocks,nParameters);
screens=Screen('Screens');
screenNumber=max(screens);
[mainwin, screenrect] = Screen('OpenWindow',screenNumber,[125 125 125] );
topPriortyLevel=MaxPriority(mainwin);
xCenter=screenrect(3)/2;
yCenter=screenrect(4)/2;
%   Experimental instructions, wait for a spacebar response to start
Screen('TextSize', mainwin, 24);
Screen('DrawText',mainwin,['Training set 3: Report the missing part of the Arc. Press spacebar to start the experiment.'] ,xCenter-550,yCenter -20,black);
Screen('Flip',mainwin );
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
    fangle1=360-2*angle;
    fangle2=angle-180;
    Screen('drawlines',mainwin,crosslines,crosswidth,crosscolor,[xCenter,yCenter]);
    Screen('Flip', mainwin);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    x1=round(sqrt(r2^2/(w1^2+1)))+xCenter;
    y1=round(w1*(x1-xCenter)+yCenter);
    x2=round(sqrt(r2^2/(w2^2+1)))+xCenter;
    y2=round(w2*(x2-xCenter)+yCenter);
    x3=round(sqrt(r2^2/(w2^2+1)))+xCenter;
    y3=round(w3*(x3-xCenter)+yCenter);
    x4=round(sqrt(r2^2/(w2^2+1)))+xCenter;
    y4=round(w4*(x4-xCenter)+yCenter);
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
    end
    itt=final(a,nParameters+3);
    WaitSecs(itt);
    targetside=randi(2,1,1);
    switch targetside
    case 1       %R 
    x=xCenter+r1;
    y=yCenter;
    case 2  %L
        x=xCenter-r1;
        y=yCenter;
        x1=2*xCenter-x1;
        x2=2*xCenter-x2;
        x3=2*xCenter-x3;
        x4=2*xCenter-x4;
    end
        switch final(a,4) %N/F
            case 0  
                xtarget=x1;
                ytarget=y1;
             case 1  
                xtarget=x2;
                ytarget=y2;
             case 2  
                xtarget=x3;
                ytarget=y3;
            case 3  
                xtarget=x4;
                ytarget=y4;
        end
         topbottom=randi(2,1,1);
         switch topbottom
            case 1 %top
                targetnum=1;
            case 2  %botoom
                targetnum=2;
         end 
         updown=randi(2,1,1);
         switch updown   %U,D
             case 1
                 ytarget=2*yCenter-ytarget;
         end
                for i=1:9
                    if i<5
                        WaitSecs(0.3);
                        Snd('Play', Beep1);
                    end
                    if i==1
                        switch final(a,3) %rhythem
                        case 0 
                            Screen('drawlines',mainwin,crosslines,crosswidth,[0 0 255],[xCenter,yCenter]);
                            Screen('Flip', mainwin);
                        case 1
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
                            Screen('FrameArc',mainwin,black,[(xtarget-10)*screenrect(3)/1920,(ytarget-10)*screenrect(4)/1080,(xtarget+10)*screenrect(3)/1920,(ytarget+10)*screenrect(4)/1080],angle,fangle1,4);
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
    % now record  response
        timeStart = GetSecs;keyIsDown=0; rt=0;keypressed=-1;       
        while GetSecs-timeStart<2
            [keyIsDown, secs, keyCode] = KbCheck;
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
            correct=0;
            u=u+1;
        end
        if (keypressed==corrkey(1)&&answer==1)||(keypressed==corrkey(2)&&answer==2)
            correct=correct+1;
        end
        if angle>6
            if correct>5
                angle=angle-2;
            else
                angle=angle+2;
            end
        end
        if angle<8
            if correct<5
                angle=angle+2;
            end
        end
        correctdata(u)=correct;
        angledata(u)=angle;
        if u>1
            if (correctdata(u)>5 && correctdata(u-1)<6) || (correctdata(u)<5 && correctdata(u-1)>6) || (ci==s1nBlocks)
                angla(ci)=angle;
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
    if correctdata(u-1)>5
        finalangle=angle+2;
    else
        finalangle=angle;
    end
else
    finalangle=mean(angla);
end
finalangle=finalangle+2;
end