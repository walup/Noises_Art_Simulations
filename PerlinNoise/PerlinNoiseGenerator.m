classdef PerlinNoiseGenerator
   properties
       n;
       p;
       octaves;
       yArr;
       
   end
   
   
   methods
       function obj = PerlinNoiseGenerator(persistance, octaves)
           obj.n = 512;
           obj.yArr = rand(1,obj.n);
           obj.p = persistance;
           obj.octaves = octaves;
       end
       
       function y  = linearInterpolation(obj, x)
          x = mod(x, obj.n);
          index = floor(x) + 1;
          alpha = mod(x,1);
          if(index ~= obj.n)
              y = (1 - alpha)*obj.yArr(index) + alpha*obj.yArr(index + 1);
          else
              y = (1 - alpha)*obj.yArr(index) + alpha*obj.yArr(1);
          end
       end
       
       function per = perlinNoise(obj, t)
          per = 0;
          
          for i = 0:obj.octaves-1
            per = per + (obj.p^i)*obj.linearInterpolation((2^i)*t);
          end
          maxVal = ((1 - (obj.p)^obj.octaves))/(1 - obj.p);
          per = per/maxVal;
       end
       
       %Traslada el ruido Perlin a un intervalo entre a y b
       function per = translatedPerlinNoise(obj, t, a, b)
          per = a + (b - a)*obj.perlinNoise(t); 
       end
       end
      
    
    
    
end