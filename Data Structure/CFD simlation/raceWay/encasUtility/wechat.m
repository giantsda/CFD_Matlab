pass=hexToBinaryVector('94');

path='E:\desktop\temp\pass\WeChat Files\languagebook\Data\';
files=dir([path '*.dat']);
for  f=1:length(files)
    fid = fopen([path files(f).name]);
    fseek(fid,0, 1); % go to end
    position = ftell( fid); % total byte
    fseek(fid,0, -1); % go to start
    t=fread(fid,position,'*uint8'); % read all
    hex=char(dec2hex(t));
    fclose(fid);
    bin=hexToBinaryVector(hex);
    binRe=bin;
    for i=1:length(bin)
        binRe(i,:)=xor(bin(i,:),pass);
    end
    res=bi2de(binRe,'left-msb');
    fid = fopen([path files(f).name '.png'],'w');
    fwrite(fid,res);
    fclose(fid);
    fprintf('writting %s \n', [path files(f).name '.png']);
end

 