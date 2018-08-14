fid=fopen('C:\CFD_second_HHD\HOOD\08082018\15\data1\default.xml','r')

for i=1:34
    tline = fgets(fid);
end

i=1
while 1
    i
    i=i+1;
    tline = fgets(fid);
    if(tline(end-11:end)=='Base64/LE">')
        res = base64decode(tline);
    end
end
fclose(fid)







