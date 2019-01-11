function setMuxChannelv2(port, m1,m2,m3)
    %   Uses the specified port to set muxes 1,2,3 to a specificed channel.
    %   Use com3 on windows 10, use just number and uncomment port
    %   adjustment code.
    %   Use -1 or >8 to set MUX off
    if m1 == -1 || (m1 > 15)
        bitor(m1,16); 
    else
        bitand(m1,15);   
    end
    if m2 == -1 || (m2 > 15)
        bitor(m2,16); 
    else
        bitand(m2,15); 
    end
    if m3 == -1 || (m3 > 15)
        bitor(m3,16); 
    else
        bitand(m3,15); 
    end
    
    %m1=bitor(m1,8)
    %convert channel into char encoding, because you have to (I hate MBED)
    m1=char(bitor(m1,80));
    m2=char(bitor(m2,80));
    m3=char(bitor(m3,80));
    
    if m1 == '^' %Can't use ^ (ch14) in cmd line, ^^ sends ^ as char
        m1 = ['^' '^'];
%         disp('adjusted');
    end
%     port=port-1;    %adjust for port notation
%     port=int2str(port); %convert to string for use in command line
    
    

    
    args = ['python ../python/MuxControl.py ',port,' ',m1,' ',m2,' ',m3];
    system(args);