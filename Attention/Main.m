%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%....WRITEN BY THE SAVAGE TODDLERS....%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  
Screen('Preference', 'SkipSyncTests', 1);% skip the sync test of psychtoolbox
%define up, down, space and escape keys
KbName('UnifyKeyNames');
Key1=KbName('upArrow'); Key2=KbName('downArrow');
spaceKey = KbName('space'); escKey = KbName('ESCAPE');
prompt = {'Subject name:', 'Subject''s number:', 'age', 'gender', 'group'};%open login prompt to get subject info
defaults = {'AZ', '1z', '18', 'M', 'pilot' };%define defult answers
answer = inputdlg(prompt, 'TST', 2, defaults);%run the input dialog
[output, subid, subage, gender, group] = deal(answer{:});%save answers
nBlocks = '5';
snBlocks = '10';
quad = '1';
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
corrkey = [38, 40]; %define up and down key as correct keys
white = [255 255 255]; black = [ 0 0 0]; grey = [125 125 125]; %color coldes
nParameters=5;%number of effective parameters
nTrialsPerBlock =2^(nParameters-1)*5; %find number of trials i each block
%fixation crossline info
quad=str2num(quad);
crosslength=10; 
crosscolor=0;
crosswidth=3;
crosslines=[-crosslength,0; crosslength,0; 0,-crosslength; 0,crosslength];
crosslines=crosslines';
% beep conditions
Beep1frequency=400;
Beep2frequency=800;
Beepduration=0.05;
Beep1 = MakeBeep(Beep1frequency, Beepduration);%make beep1
Beep2 = MakeBeep(Beep2frequency, Beepduration);%make beep 2
theta1=30;
theta2=60;
r1=444;%distance between cue and fix
r2=500;%distance between target and fix
final=generatedata2(str2num(nBlocks),nParameters);  %generate condition matrix
% [correctangle, angledata, finalangle ]=Staircase1(str2num(snBlocks)); %run the curve size staircase
finalangle = 14;
[correctdistance, distancedata, finaldistance ]=Staircase3(str2num(snBlocks), finalangle); %run the curve size staircase
%generate the starting point and the angle of the curve
w=[2,correctdistance/4,correctdistance*2/4,correctdistance*3/4,correctdistance];
fangle1=360-2*finalangle; 
fangle2=finalangle-180;
%%%%%%%%%%%%%%.............PSYCHTOO LBOX STARTS........%%%%%%%%%%%%%%%%%%%%%%%%%
screens=Screen('Screens'); %Find the code of laptop monitor
screenNumber=max(screens); % Set Laptop Monitor as Default Screen
[mainwin, screenrect] = Screen('OpenWindow',screenNumber,grey ); %Open a grey Screen
topPriortyLevel=MaxPriority(mainwin); %Give the screen the max priorty in CPU
%Find the screen middle point
xCenter=screenrect(3)/2;
yCenter=screenrect(4)/2;
[xc1,yc1,~,~]=location(xCenter,yCenter,theta1,w(1),r1,r2,quad);
[xc2,yc2,~,~]=location(xCenter,yCenter,theta1,w(1),r1,r2,quad);
for i=1:5
    [~,~,x1(i),y1(i)]=location(xCenter,yCenter,theta1,w(i),r1,r2,quad); %30 deg cue/up
    [~,~,x2(i),y2(i)]=location(xCenter,yCenter,theta1,-w(i),r1,r2,quad);%30 deg cue/down
    [~,~,x3(i),y3(i)]=location(xCenter,yCenter,theta2,w(i),r1,r2,quad);%60 deg cue/up
    [~,~,x4(i),y4(i)]=location(xCenter,yCenter,theta2,-w(i),r1,r2,quad);%60 deg cue/down
end
%tell subject to press the space to start
Screen('TextSize', mainwin, 24);
Screen('DrawText',mainwin,['Report the missing part of the Arc. Press spacebar to start the experiment.'] ,xCenter-550*screenrect(3)/1920,yCenter-20*screenrect(4)/1080,black);
Screen('Flip',mainwin );
%wait until subject response
keyIsDown=0;
while 1
    [keyIsDown, secs, keyCode] = KbCheck;
    if keyIsDown
        if keyCode(spaceKey) 
            break ; %countinue the test if subject pressed the space key
        elseif keyCode(escKey)
            ShowCursor;
            Screen('CloseAll'); %close the screen and end the task if subject pressed the escap key
            return;
        end
    end
end
WaitSecs(0.3); %Wait 300 ms 
%%%%%%%%%%parameters
for a = 1:str2num(nBlocks)*nTrialsPerBlock
    switch a
        case 160
            Screen('DrawText',mainwin,'Take rest for 3 minutes' ,xCenter-250*screenrect(3)/1920,yCenter -20*screenrect(4)/1080,black);
            Screen('Flip', mainwin);
            WaitSecs(180);
            Snd('Play', Beep2);
        case 320
            Screen('DrawText',mainwin,'Take rest for 3 minutes' ,xCenter-250*screenrect(3)/1920,yCenter -20*screenrect(4)/1080,black);
            Screen('Flip', mainwin);
            WaitSecs(180);
            Snd('Play', Beep2);
        case 480
            Screen('DrawText',mainwin,'Take rest for 3 minutes' ,xCenter-250*screenrect(3)/1920,yCenter -20*screenrect(4)/1080,black);
            Screen('Flip', mainwin); 
            WaitSecs(180);
            Snd('Play', Beep2);
        case 640
            Screen('DrawText',mainwin,'Take rest for 3 minutes' ,xCenter-250*screenrect(3)/1920,yCenter -20*screenrect(4)/1080,black);
            Screen('Flip', mainwin);
            WaitSecs(180);
            Snd('Play', Beep2);
        case 800
            Screen('DrawText',mainwin,'Take rest for 3 minutes' ,xCenter-250*screenrect(3)/1920,yCenter -20*screenrect(4)/1080,black);
            Screen('Flip', mainwin);
            WaitSecs(180);
            Snd('Play', Beep2);
    end
%     Screen('Flip', mainwin);
    if mod(a,32)==1
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
    switch final(a,nParameters)   %cue place
        case 0
            x=xc1;
            y=yc1;
            ctype=0;
        case 1 
            x=xc2;
            y=yc2;
            ctype=1;
    end
    switch final(a,nParameters+1) %T/B
        case 0 %top
            targetnum=1;
        case 1  %botoom
            targetnum=2;
    end
    switch final(a,nParameters+2) %up/down
        case 0
            if ctype == 0
                xtarget=x1(final(a,nParameters-1)+1);
                ytarget=y1(final(a,nParameters-1)+1);
            else
                xtarget=x3(final(a,nParameters-1)+1);
                ytarget=y3(final(a,nParameters-1)+1);
            end
        case 1
            if ctype == 0
                xtarget=x2(final(a,nParameters-1)+1);
                ytarget=y2(final(a,nParameters-1)+1);
            else
                xtarget=x4(final(a,nParameters-1)+1);
                ytarget=y4(final(a,nParameters-1)+1);
            end
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
            WaitSecs(final(a,nParameters+8));
            final(a,nParameters+13)=GetSecs-timest;
            Snd('Play', Beep1);
        end
        if i==4  %cue
            Screen('FillOval', mainwin,black,[(x-10)*screenrect(3)/1920,(y-10)*screenrect(4)/1080,(x+10)*screenrect(3)/1920,(y+10)*screenrect(4)/1080]);
            Screen('drawlines',mainwin,crosslines,crosswidth,[0 0 0],[xCenter,yCenter]);
            Screen('Flip', mainwin);
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
    % now record  response
    timeStart = GetSecs;keyIsDown=0; correct=0; rt=0;keypressed=-1; keyCode=0;      
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
end
Screen('FillRect', mainwin, grey);
Screen('DrawText',mainwin,['You have finished the experiment. Thanks for you coopration... Press any key to exit'] ,xCenter-650*screenrect(3)/1920,yCenter-20*screenrect(4)/1080,black);
Screen('Flip',mainwin );
keyIsDown=0;
while 1
    [keyIsDown, secs, keyCode] = KbCheck;
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
Screen('CloseAll');
backupfinal=final;    %get backup of data
% data analysis
% [answered, correct, accuracy, RT, IES]=dataanalyze(final);
% [rhythmic, arhythmic]=rhythem(final);
% [ranswered, rcorrect, raccuracy, rRT, rIES]=dataanalyze(rhythmic);
% [aranswered, arcorrect, araccuracy, arRT, arIES]=dataanalyze(arhythmic);
% [d1, d2, d3, d4, d5]=distancemat(final);
% [d1answered, d1correct, d1accuracy, d1RT, d1IES]=dataanalyze(d1);
% [d2answered, d2correct, d2accuracy, d2RT, d2IES]=dataanalyze(d2);
% [d3answered, d3correct, d3accuracy, d3RT, d3IES]=dataanalyze(d3);
% [d4answered, d4correct, d4accuracy, d4RT, d4IES]=dataanalyze(d4);
% [d5answered, d5correct, d5accuracy, d5RT, d5IES]=dataanalyze(d5);
% [rd1, ard1]=rhythem(d1);
% [rd2, ard2]=rhythem(d2);
% [rd3, ard3]=rhythem(d3);
% [rd4, ard4]=rhythem(d4);
% [rd5, ard5]=rhythem(d5);
% [rd1answered, rd1correct, rd1accuracy, rd1RT, rd1IES]=dataanalyze(rd1);
% [rd2answered, rd2correct, rd2accuracy, rd2RT, rd2IES]=dataanalyze(rd2);
% [rd3answered, rd3correct, rd3accuracy, rd3RT, rd3IES]=dataanalyze(rd3);
% [rd4answered, rd4correct, rd4accuracy, rd4RT, rd4IES]=dataanalyze(rd4);
% [rd5answered, rd5correct, rd5accuracy, rd5RT, rd5IES]=dataanalyze(rd5);
% %plot data
% w1=w(length(w):-1:1);
% xplot=[-(deg2rad(w1)),deg2rad(w)];
% yplot=[1/d5IES, 1/d4IES, 1/d3IES, 1/d2IES, 1/d1IES, 1/d1IES, 1/d2IES, 1/d3IES, 1/d4IES, 1/d5IES]*100;
% yrplot=[1/rd5IES 1/rd4IES 1/rd3IES 1/rd2IES 1/rd1IES 1/rd1IES 1/rd2IES 1/rd3IES 1/rd4IES 1/rd5IES]*100;
% % plotPsychCurvel(xplot,yplot,'b--');
% % plotPsychCurvel(xplot,yrplot,'r--');
% %put all data on a table
finaltable=array2table(final,'VariableNames',...
    {'BlockNO','TrialNO','Rhythem','Distance','Top_Bottom','Left_Right','ITI','Wait1','Wait2','Wait3','Wait4','Wait5','RWait1','RWait2','RWait3','RWait4','RWait5','SubjectResponse','RT'});
%print final result
directory=['C:\TEST DATA' subid group];
mkdir(directory); 
cd(directory);
fullname=['Subject' subid 'fulldata.mat'];
save(fullname);
tablename=['Subject' subid 'tabledata.mat'];
save(tablename,'finaltable');
% if accuracy>0.75
%     fprintf('\n accuracy is fine \n');
%     
% else
%     fprintf('\n accuracy is not fine \n');
% end
% if rIES<arIES
%     fprintf('rhythmic is better than arhythmic \n');
% else
%     fprintf('rhythmic is not better than arhythmic \n');
% end
% if d1IES<d2IES && d2IES<d3IES && d3IES<d4IES &&d4IES<d5IES
%         fprintf('near is better than far \n');
% else
%     fprintf('near is not better than far \n');
% end