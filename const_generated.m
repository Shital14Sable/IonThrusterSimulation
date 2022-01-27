function qi_const = const_generated(qi)
   
   if qi == 1
       qi_const = 1;
   elseif qi == 10
       qi_const = qi/3;
   elseif qi == 100
       qi_const = qi/9;
   end
   
end