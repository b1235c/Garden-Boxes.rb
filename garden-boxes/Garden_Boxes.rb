require 'sqlite3'
puts "Welcome to GardenBox!"
looping = true
while looping
    
    puts "Please tell me the GardenBox length (in feet)"
    length = gets.chomp
    if length =~ /^-?[0-9.]+$/
    else
        puts "Let's try this again?"
        next
    end
    
    puts "Please tell me the width of the GardenBox(in feet)"
    width = gets.chomp
    if width =~ /^-?[0-9.]+$/
    else
        puts "Let's try this again?"
        puts ""
        puts ""
        next
    end

    llength = length.to_f
    wwidth = width.to_f
    area = llength*wwidth

    puts "Great your gardens's area is #{area.round(2)} feet"

    carrots = 1
    corn = Rational(3,16)
    beets = Rational(9,16)

    ccorn = (area*corn).floor
    ccarrots = area.floor
    cbeets = (area*beets).floor

    question = true
    while question
        puts "Tell me which you would like to plant? Carrots, Corn, Beets"
        response = gets.chomp.downcase

        if response == "carrots"
            puts "I reckon you can fit #{ccarrots} carrots on that plot of land there."
            question = false
            amount = ccarrots
        elsif response == "corn" 
            puts "Or about #{ccorn} corn plants."
            question = false
            amount = ccorn
        elsif response == "beets"
            puts "Alternatively, you can have #{cbeets} beets growing." 
            question = false
            amount = cbeets
        else 
            next
        end
    end
    

    


        begin
            
            db = SQLite3::Database.open "test.db"
            db.execute "CREATE TABLE IF NOT EXISTS Plants2(Id INTEGER PRIMARY KEY, 
                Vegetables TEXT, Area INTEGER)"

            db.execute "INSERT INTO Plants2(Vegetables, Area) VALUES('#{response}',#{area})"
            
            rescue SQLite3::Exception => e  
            
            puts "Exception occurred"
            puts e
            
            ensure 
            db.close if db
        end

        puts "Would you like to set up another garden box? Press any key to continue or type (Q)uit to exit"
        continue = gets.chomp.downcase
     
        if continue == "q"
            looping = false
            puts "Happy Planting!"
        end
    
end
