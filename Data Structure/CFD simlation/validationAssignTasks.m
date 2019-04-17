  points=[];
 %% 1
 for z= 0.05:0.05:0.15
     for y=5:5:50
         for x=-95:10 :-40 
             points=[points; 1 x y z];
         end
     end
 end
 %% 2
   for z= 0.05:0.05:0.15
     for y=5:5:50
         for x= -95:10:95
             points=[points; 2 x y z];
         end
     end
  end
 %% 3
   for z= 0.05:0.05:0.15
    y=0;
         for x=  5:5:50
             points=[points; 3 x y z];
         end
   end
  %% 4
   %% 3
   for z= 0.05:0.05:0.15
    y=0;
         for x=  5:5:50
             points=[points; 4 x y z];
         end
  end
  
  
  
  
  
  
  