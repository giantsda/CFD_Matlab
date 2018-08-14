function mail2me
filename='E:\desktop\temp\2\default.xml'; % the path of xml file
file_exist=exist(filename);  % if exist, returen 2, if not, return 0.
if file_exist==2
    text_exist=' The file is exist! ';
    file_size= dir(filename);
    file_size=file_size.bytes/1000000; % the size in MB
    text_size=[' The size of the file is ' num2str(file_size) 'MB! '];
else
    text_exist='The file is lost!!!';
end
%%
time=clock;
time=datestr(time);
subject = ['Hello from MATLAB    ' time];
ha='This is the update of the xml file. ';
text_time=['The time is:   ' time];
content = [ha text_exist text_size text_time];
mail = 'xsshenchen1991@gmail.com';
psswd = 'balisong';
%%
host = 'smtp.gmail.com';
port  = '465';
emailto =mail;
setpref( 'Internet','E_mail', mail );
setpref( 'Internet', 'SMTP_Server', host );
setpref( 'Internet', 'SMTP_Username', mail );
setpref( 'Internet', 'SMTP_Password', psswd );
props = java.lang.System.getProperties;
props.setProperty( 'mail.smtp.user', mail );
props.setProperty( 'mail.smtp.host', host );
props.setProperty( 'mail.smtp.port', port );
props.setProperty( 'mail.smtp.starttls.enable', 'true' );
props.setProperty( 'mail.smtp.debug', 'true' );
props.setProperty( 'mail.smtp.auth', 'true' );
props.setProperty( 'mail.smtp.socketFactory.port', port );
props.setProperty( 'mail.smtp.socketFactory.class', 'javax.net.ssl.SSLSocketFactory' );
props.setProperty( 'mail.smtp.socketFactory.fallback', 'false' );
sendmail( emailto , subject, content);
sendmail( 'xsshenchen1991@163.com' , subject, content);
end