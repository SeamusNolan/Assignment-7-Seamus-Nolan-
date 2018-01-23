--------------------------------------------------------------------------------------------
-- Title: Numeric Textfield
-- Name: Seamus Nolan
-- Course: ICS2O/3C
-- This program alows you to add 2 readom. 
---------------------------------------------------------------------------------------------

-- hide the status bar
display.setStatusBar(display.HiddenStatusBar)

-- sets the background colour
display.setDefault("background", 60/255, 198/255, 208/255)

-----------------------------------------------------------------------------------------
-- LOCAL VARIABLES
-----------------------------------------------------------------------------------------

-- create local variables
local questionObject
local correctObject
local numericField
local randomNumber1
local randomNumber2
local userAnswer
local correctAnswer
local rodingObject 
local backgroundSound = audio.loadSound("Sounds/background.mp3")


-- variables for the timer
local totalSeconds = 5
local secondsLeft = 5
local clockText
local countDownTimer

local lives = 3
local heart1
local heart2

local sound = audio.play(backgroundSound)
--*** ADD LOCAL VARIABLE FOR: INCORRECT OBJECT, POINTS OBJECT, POINTS



-----------------------------------------------------------------------------------------
-- LOCAL FUNCTIONS
-----------------------------------------------------------------------------------------

local function AskQuestion()
	--*** ADD A COMMENT FOR THE TWO LINES BELOW
    --***CHANGE THE CODE TO USE NUMBERS BETWEEN 0 AND 10
	randomOperators = math.random(1, 5)
    --*** ADD CODE SO THAT THE OPERATION VARIES RANDOMLY BETWEEN ADDITION, SUBTRACTION 
    --*** AND MULTIPLICATION
    correctObject.isVisible= false
    wrongObject.isVisible= false
  if ( randomOperators == 1 ) then
  	randomNumber1 = math.random  (1, 20)
  	randomNumber2 = math.random  (1, 20)
    --sates the create answer
    correctAnswer = randomNumber1 + randomNumber2

   	-- create question in text object
	questionObject.text = randomNumber1 .. " + " .. randomNumber2 .. " = " 
	questionObject.size= 60

    rodingObject.text = ""

  	end

  	  if ( randomOperators == 2 ) then
  	randomNumber1 = math.random  (1, 20)
  	randomNumber2 = math.random  (1, 20)
    --sates the create answer
    correctAnswer = randomNumber1 - randomNumber2

   	-- create question in text object
	questionObject.text = randomNumber1 .. " - " .. randomNumber2 .. " = " 
	questionObject.size= 60

    rodingObject.text = ""


  	end


  	  if ( randomOperators == 3 ) then
  	randomNumber1 = math.random  (1, 10)
  	randomNumber2 = math.random  (1, 10)
    --sates the create answer
    correctAnswer = randomNumber1 * randomNumber2

   	-- create question in text object
	questionObject.text = randomNumber1 .. " * " .. randomNumber2 .. " = " 
	questionObject.size= 60

	    rodingObject.text = ""

  	end

  	  if ( randomOperators == 4 ) then
  	randomNumber1 = math.random  (1, 100)
  	randomNumber2 = math.random  (1, 100)
    --sates the create answer
    correctAnswer = math.round (randomNumber1 / randomNumber2)


   	-- create question in text object
	questionObject.text = randomNumber1 .. " / " .. randomNumber2 .. " = " 
	questionObject.size= 60
   
    rodingObject.text = "For default round to the nearest number  "

  	end
    if ( randomOperators == 2 ) then
    randomNumber1 = math.random  (1, 5)
    randomNumber2 = math.random  (1, 5)
    --sates the create answer
    correctAnswer = randomNumber1 ^
   randomNumber2

    -- create question in text object
  questionObject.text = randomNumber1 .. " ^ " .. randomNumber2 .. " = " 
  questionObject.size= 60

    rodingObject.text = ""
    end


end

local function HideCorrect()
    --*** CHANGE THE CORRECT OBJECT TO BE INVISIBLE
	correctObject.isVisible = true


    -- call the function that asks the question
	AskQuestion()
end

local function HideWrong()
    --*** CHANGE THE CORRECT OBJECT TO BE INVISIBLE
	wrongObject.isVisible = true


    -- call the function that asks the question
	AskQuestion()
end


-- function that calls the timer
local function StartTimer()
    -- create a countdown timer that loops infinitely
    countDownTimer = timer.performWithDelay( 1000, UpdateTime, 0)
end


local function UpdateTime()

    -- decrement the number of seconds
    secondsLeft = secondsLeft - 1  
    
    -- display the number of seconds left in the clock object
    clockText.text = secondsLeft .. ""

    if (secondsLeft == 0 ) then
        -- reset the number of seconds left
        secondsLeft = totalSeconds 
        lives = lives - 1

        -- *** IF THERE ARE NO LIVES LEFT, PLAY A LOSE SOUND, SHOW A YOU LOSE IMAGE 
        -- AND CANCEL THE TIMER REMOVE THE THIRD HEART BY MAKING IT INVISIBLE
        if (lives == 2) then
            heart2.isVisible = false
        elseif (lives ==  1) then
            heart1.isVisible = false
        end

        -- *** CALL THE FUNCTION TO ASK A NEW QUESTION
        
    end
end

local function NumericFieldListener( event )

    -- User begins editing "numericField"
    newtimer = timer.performWithDelay(1000, updateTime, 0)
    if (event.phase == "began") then
        
        --clear text field
        event.target.text = ""

    elseif (event.phase == "submitted") then

        -- when the answer is submitted (enter key is pressed) set user input to user's answer
        userAnswer = tonumber(event.target.text)  

        -- if the users answer and the correct answer are the same:
        if (userAnswer == correctAnswer) then
        	correctObject.isVisible = true

            --*** ADD CODE THAT KEEPS TRACK OF THE NUMBER OF POINTS CORRECT AND DISPLAYS THIS IN 
            --*** A TEXT OBJECT

            -- call the HideCorrect function after 2 seconds
        	timer.performWithDelay(1000, HideCorrect)       	               
        else
        	wrongObject.isVisible = true

            --*** ADD CODE THAT KEEPS TRACK OF THE NUMBER OF POINTS CORRECT AND DISPLAYS THIS IN 
            --*** A TEXT OBJECT

            -- call the HideCorrect function after 2 seconds
        	timer.performWithDelay(1000, HideWrong) 	
        end 
    end
end

-----------------------------------------------------------------------------------------
-- OBJECT CREATION
-----------------------------------------------------------------------------------------

-- displays a question and sets the colour
questionObject = display.newText( "", display.contentWidth/3, display.contentHeight/2, nil, 50 )
rodingObject = display.newText( "", display.contentWidth/2, display.contentHeight/4*2/2, nil, 50 )
--*** INSERT CODE TO CHANGE THE COLOUR OF THE TEXT OBJECT TO A DIFFERENT COLOUR


-- create the correct text object and make it invisible
correctObject = display.newText( "Correct!", display.contentWidth/2, display.contentHeight*2/3, nil, 50 )
correctObject:setFillColor(0/255, 255/255, 0/255)

wrongObject = display.newText( "Incorrect!", display.contentWidth/2, display.contentHeight*2/3, nil, 50 )
wrongObject:setFillColor(255/255, 0/255, 0/255)

--*** INSERT CODE TO CHANGE THE COLOUR OF THE TEXT OBJECT TO A DIFFERENT COLOUR

--*** MAKE THE CORRECT OBJECT INVISIBLE
correctObject.isVisible = true

-- Create numeric field
numericField = native.newTextField( display.contentWidth/3*2.7, display.contentHeight/2, 200, 80 )
numericField.inputType = "decimal"

-----------------------------------------------------------------------------------------
-- EVENT LISTENERS
-----------------------------------------------------------------------------------------

-- add the event listener for the numeric field
numericField:addEventListener( "userInput", NumericFieldListener )

-----------------------------------------------------------------------------------------
-- FUNCTION CALLS
-----------------------------------------------------------------------------------------

-- call the function to ask the question
AskQuestion()-----------------------------------------------------------------------------------------

StartTimer()