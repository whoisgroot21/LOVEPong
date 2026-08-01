

function love.load()
	windowHeight = love.graphics.getHeight()
	windowWidth = love.graphics.getWidth()

   love.window.setTitle("Pong!")

   init_vel = -3

   BALL_SIZE=10

   PADDLE_ONE_X = 20
	PADDLE_TWO_X = windowWidth-30

   PADDLE_SPEED = 3
	PADDLE_WIDTH = 10
	PADDLE_LENGTH = 40

   score_One = 0
   score_Two = 0

	blip = love.audio.newSource("/sound/blip.mp3", "static")
	--boundary = love.audio.newSource("/sound/boundary.mp3", "static")
	score = love.audio.newSource("/sound/score.mp3", "static")

   font = love.graphics.newFont(25)
   love.graphics.setFont(font)

   start_game()


end


function love.draw()
	love.graphics.setColor(1,1,1)
	love.graphics.rectangle("fill", PADDLE_ONE_X, paddleOne_pos, PADDLE_WIDTH, PADDLE_LENGTH)
	love.graphics.rectangle("fill", PADDLE_TWO_X, paddleTwo_pos, PADDLE_WIDTH, PADDLE_LENGTH)
	love.graphics.rectangle("fill", ballx, bally, BALL_SIZE, BALL_SIZE)
	

   text_pos = windowWidth/6
   love.graphics.print(score_One, text_pos, 100)
   love.graphics.print(score_Two, windowWidth-text_pos, 100)

	--debuging
	--love.graphics.setColor(1,0,0)
	--love.graphics.rectangle("line", ballx, bally, 1, 1)
	 

end

function love.update(dt)

   handle_input()

   ballx=ballx+velocityX
   bally=bally+velocityY

   handle_collision()


end


function start_game()

   paddleOne_pos = windowHeight/2
   paddleTwo_pos = windowHeight/2
   ballx = windowWidth/2
   bally = windowHeight/2
   velocityX = -3
   velocityY = 0

end


function handle_input()

   if love.keyboard.isDown("escape") then
      love.event.quit()
   end


   if love.keyboard.isDown("w") then
      if paddleOne_pos>10 then
         paddleOne_pos=paddleOne_pos-PADDLE_SPEED
      end
   end

   if love.keyboard.isDown("up") then
      if paddleTwo_pos>10 then
         paddleTwo_pos=paddleTwo_pos-PADDLE_SPEED
      end
   end

   if love.keyboard.isDown("s") then
      if paddleOne_pos<windowHeight-50 then
         paddleOne_pos=paddleOne_pos+PADDLE_SPEED
      end
   end

   if love.keyboard.isDown("down") then
      if paddleTwo_pos<windowHeight-50 then
         paddleTwo_pos=paddleTwo_pos+PADDLE_SPEED
      end
   end
end


function handle_collision()

   if ballx<(PADDLE_ONE_X+PADDLE_WIDTH) and ballx>PADDLE_ONE_X and (bally+BALL_SIZE)>paddleOne_pos and bally<(paddleOne_pos+PADDLE_LENGTH) then
      velocityX=velocityX*-1
      blip:play()

      velocityX=velocityX+0.01

      paddle_mid = paddleOne_pos+(PADDLE_LENGTH/2)
      ball_mid = bally+(BALL_SIZE/2)
      deviation = ((paddle_mid-ball_mid)/PADDLE_LENGTH)*2   
      velocityY = init_vel*deviation

   end

   
     
   if (ballx+BALL_SIZE)>PADDLE_TWO_X and (ballx+BALL_SIZE)<(PADDLE_TWO_X+PADDLE_WIDTH) and (bally+BALL_SIZE)>paddleTwo_pos and bally<(paddleTwo_pos+PADDLE_LENGTH) then
      
      velocityX=velocityX*-1
      blip:play()

      velocityX=velocityX-0.01


      paddle_mid = paddleTwo_pos+(PADDLE_LENGTH/2)
      ball_mid = bally+(BALL_SIZE/2)
      deviation = ((paddle_mid-ball_mid)/PADDLE_LENGTH)*2   
      velocityY = init_vel*deviation


   end


   if bally<0 or (bally+BALL_SIZE)>windowHeight then
      velocityY=velocityY*-1
      blip:play()
   end





   if ballx<0 then
      score:play()
      score_Two=score_Two+1
      start_game()
   end

   if ballx>windowWidth then
      score:play()
      score_One=score_One+1
      start_game()

   end





   
end

