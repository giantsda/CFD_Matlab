flow_time=80.51

i=0;
while (i<600)
    i
    if (flow_time < 0.03)
        time_step = 0.005;
    else if (flow_time < 0.5)
            time_step = 0.01;
        else if (flow_time < 8)
                time_step = 0.02;
            else if (flow_time < 14)
                    time_step = 0.03;
                else
                    time_step = 0.042;
                end
            end
        end
    end
    
    flow_time=flow_time+time_step;
    i=i+1;
    
end
flow_time