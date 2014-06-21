
###############################################################################
#                                                                             #
# CARNOT ENGINES - WITH EXHAUSTIBLE RESERVOIRS version 01.03                  #
#_____________________________________________________________________________#
#                                                                             #
# Copyright 2011, 2013 by Mark Ciotola; available for use under GNU license   #
# Created on 14 June 2014. Last revised on 17 June 2014                       #
#_____________________________________________________________________________#
#                                                                             #
# Developed with Ruby 1.8.7; updated to Ruby 1.9.2 & 2.?                      #
# Takes the following parameters: temperature of reservoirs?                  #
#                                                                             #
###############################################################################

# OMIT HOLISTICS ENTROPY CALC FOR EACH RESERVOIR, JUST DO DIFFERENCES;
# THIS IS ONLY APPROXIMATELY LINEAR.


# Choose Parameters

  hotenergyinit =  100000.0 #J

  coldenergyinit =  30000.0 #J

  coldspecificheat = 1.0

  hotspecificheat = 2.0

  hotvolume = 1000.0 #m^2

  coldvolume = 1000.0 #m^2

  engineconsumption = 300.0 #J/s  ; 300.0 provides a long tail; 500.0 is short; 1000.0 is even shorter
  # not much production at low engine consumptions compare to repro costs.

  # 100.0 J cost versus 200.0 J consumption -> result is no repro so no growth, and very slow exhaustion = 66 periods
  # 100.0 J cost versus 300.0 J consumption -> result is tiny repro so little growth, and slow exhaustion = 35 periods

  enginereprocost = 100.0 # J (or is the real cost J/K?


  hotenergy = hotenergyinit #J

  coldenergy = coldenergyinit #J


# Initialize Variables

  time = 0

  culprod = 0.0

  engqty = 1

  hottemp = hotenergy/(hotvolume * hotspecificheat) #K

  coldtemp = coldenergy/(coldvolume * coldspecificheat) #K

puts "\n\n"

puts "Initial Temps\n"

puts sprintf "  Hot temp (in K): \t\t %7.3f " , hottemp.to_s
puts sprintf "  Cold temp (in K): \t\t %7.3f " , coldtemp.to_s
puts sprintf "  Engine Repro Costs (in J): \t\t %7.3f " , enginereprocost.to_s

puts "\n\n"

# Display Simulation Banner

puts "\n\n"
puts "RESULTS: \n\n"

puts "PERIOD\tT hot\tT cold \tCONSMP\tE hot \tE cold\tEFFIC\tPRODTN\t CumlProd\tHot S c\tCold S c\t Eng Qty"
puts "------\t------\t------\t------\t------\t------\t-----\t------\t --------\t-------\t--------\t--------\n"

# Calculate and Display Results


    
while coldtemp < hottemp
    
    efficiency = 1 - (coldtemp/hottemp)
    
    totalengineconsumption = engineconsumption * engqty
  
    engineproduction = (totalengineconsumption * efficiency)
  
    hotenergy = hotenergy - totalengineconsumption
  
    coldenergy = coldenergy + totalengineconsumption
  
    culprod = culprod + engineproduction
  
  hotentropychange = - totalengineconsumption / hottemp
  
  coldentropychange = (totalengineconsumption - engineproduction) / coldtemp
 

  if engineproduction > 100
      
      engqty = engineproduction / enginereprocost # engqty + 1 # or make growth proportional to productions
    
  end

  
  # Add reproduction
  

# Display Variable Shorts

t = time
ht = hottemp
ct = coldtemp
he = hotenergy
ce = coldenergy
ec = totalengineconsumption
eff = efficiency
ep = engineproduction
cp = culprod
hs = hotentropychange
cs = coldentropychange


mystring = ("%d\t%5.2f\t%6.3f\t%6.0f\t%5.0f\t%5.0f\t%5.3f\t%6.2f\t%9.2f\t%6.2f\t%6.2f\t%6.2f  ")
puts sprintf mystring, t.to_s, ht.to_s, ct.to_s, ec.to_s, he.to_s, ce.to_s, eff.to_s, ep.to_s, cp.to_s, hs.to_s, cs.to_s, engqty.to_s

hottemp = hotenergy/(hotvolume * hotspecificheat) #K

coldtemp = coldenergy/(coldvolume * coldspecificheat) #K

    time = time + 1
    
   end




puts "\n\n"



puts "\n\n"

puts "================================== Units Key ==================================\n\n"
puts "  Abbreviation: \t\t Unit:"
puts "\n"
puts "       J \t\t\t Joules, a unit of energy"
puts "       K \t\t\t Kelvin, a unit of temperature"
puts "       m \t\t\t meters, a unit of length"
puts "       s \t\t\t seconds, a unit of time"
puts "\n\n"


puts "================================== References =================================\n\n"
puts "Daniel V. Schroeder, 2000, \"An Introduction to Thermal Physics.\""
puts "\n\n"

