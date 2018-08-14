function [file_number] = get_file_number (folder_path, file_name)
file_number= dir(folder_path);
a=size(file_number);
file_number=a(1)-3;
end
