puts "\n"
puts "###############################################################################"
puts "#                                                                             #"
puts "# CARNOT ENGINES - WITH UNLIMITED RESERVOIRS version 01.06.01                 #"
puts "#_____________________________________________________________________________#"
puts "#                                                                             #"
puts "# Copyright 2011-2014 by Mark Ciotola; available for use under GNU license    #"
puts "#                                                                             #"
puts "# http://www.heatsuite.com                                                    #"
puts "#                                                                             #"
puts "###############################################################################"
puts "\n"

      ###############################################################################
      #                                                                             #
      # Created on 14 June 2014. Last revised on 24 November 2014                   #
      #_____________________________________________________________________________#
      #                                                                             #
      # Developed with Ruby 1.8.7; updated to Ruby 2.1.1                            #
      #                                                                             #
      ###############################################################################

puts "\n"
puts "A Carnot heat engine bridges reservoirs of differing temperatures to transform"
puts "heat flow into work. Heat energy is consumed from the hot reservoir. Part of"
puts "that energy become work, while the remainder is exhausted as waste heat."
puts "\n"
puts "The work produced is utilized to produce additional Carnot heat engines. Each"
puts "engine has a build cost. So the quantity of engines will increase, and hence"
puts "will consumption."
puts "\n"
puts "Since a Carnot engine produces no net entropy, the entropy removed from the"
puts "hot reservoir must match the entropy added to the cold reservoir."
puts "\n"



# Include libraries
  include Math

  prompt = "> "


# Set Parameters

  hottemp =  500.0    # in K
  coldtemp =  300.0   # in K
  engineconsumption = 100.0  # in J/s
  enginereprocost = 1000.0   # in J


# Initialize Variables

  time = 0           # in s
  culprod = 0.0      # in s
  engqty = 1.0
  efficiency = 1.0 - (coldtemp/hottemp)
  efficiencydisplay = 100*(1.0 - (coldtemp/hottemp))

  puts "\n"
  puts "Paramater values\n"
  puts "\n"
  puts sprintf "  Hot temp: \t\t\t %8.3f K" , hottemp.to_s
  puts sprintf "  Cold temp: \t\t\t %8.3f K" , coldtemp.to_s
  puts sprintf "  Engine Consumption: \t\t %8.3f J/s " , engineconsumption.to_s
  puts sprintf "  Engine Build Cost: \t\t %8.3f J " , enginereprocost.to_s

  puts "\n\n"

  puts "Initial variable values\n"
  puts "\n"
  puts sprintf "  Time: \t\t\t %8.3f s" , time.to_s
  puts sprintf "  Cumulative Production: \t %8.3f J" , culprod.to_s
  puts sprintf "  Engine Quantity: \t\t %8.3f J" , engqty.to_s
  puts sprintf "  Efficiency: \t\t\t %8.3f %" , efficiencydisplay.to_s
  puts "\n"


# Create output file

  puts "What is the desired name for your output file? [reproducing_engines_output.csv]:"
  print prompt
  dynasty_output_file = STDIN.gets.chomp()

  if dynasty_output_file > ""
    dynasty_output_file = dynasty_output_file
  	else
    dynasty_output_file = "reproducing_engines_output.csv"
  end

  target = File.open(dynasty_output_file, 'w')



# Write to output file

  paramstring1 = "Year" + "," + "EngQty" + "," + "Consmp" + "," + "Prodtn" + "," + "CumlProd"
  target.write(paramstring1)
  target.write("\n")



# Display Simulation Banner

  puts "\n"
  puts "RESULTS: \n"
  puts "\n"
  puts " Time \tEng Qty\tConsmp \tProdtn \tCumlProd\tHot S c \tCld S c \n"
  puts "   s  \t  J    \t   J   \t   J   \t    J   \t  J/K   \t  J/K   \n"
  puts "------\t-------\t-------\t-------\t--------\t--------\t------- \n"


# Calculate and Display Results

# initialize counters

  i = 0
  j = 30


  # set up loop

  while i < j
    
    totalengineconsumption = engineconsumption * engqty
  
    engineproduction = (totalengineconsumption * efficiency)
    
    culprod = culprod + engineproduction
  
    hotentropychange = - totalengineconsumption / hottemp
  
    coldentropychange = (totalengineconsumption - engineproduction) / coldtemp

    engqty = engqty + (engineproduction / enginereprocost)


  # Set variable short names for display

    t = i  # time
    ht = hottemp
    ct = coldtemp
    ec = totalengineconsumption
    eff = efficiency
    ep = engineproduction
    cp = culprod
    hs = hotentropychange
    cs = coldentropychange
    eq = engqty


  # Display results

    mystring = ("%4d\t%6.2f\t%7.2f\t%7.2f\t%8.3f\t%7.3f\t\t%5.3f")
    puts sprintf mystring, t.to_s, engqty.to_s, ec.to_s, ep.to_s, cp.to_s, hs.to_s, cs.to_s


  # Write results to output file
  
    periodstring = t.to_s+","+eq.to_s+","+ec.to_s+","+ep.to_s+","+cp.to_s
    target.write(periodstring)
    target.write("\n")

  # Update counter
  
    i = i + 1
    
    
   end


# Close output file

  target.close()

# Completion message and end matter

  puts "\nSimulation is completed. \n\n"

  puts "\n"
  puts "================================== Label Key ==================================\n\n"
  puts "  Abbreviation: \t\t Unit:"
  puts "\n"
  puts "       Eng Qty \t\t\t Quantity of engines"
  puts "       Consmp \t\t\t Consumption of energy from hot reservoir, in J"
  puts "       Prodtn \t\t\t Production, in J"
  puts "       CumlProd \t\t Cumulative Production, in J"
  puts "       Hot S c \t\t\t Entropy removed from hot reservoir, in J/K"
  puts "       Cld S c \t\t\t Entropy removed from cold reservoir, in J/K"
  puts "\n\n"


  puts "\n"
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

