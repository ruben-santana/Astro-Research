;Random number between [5,95] and a multiple of 5
function random_number,max_range

number = [round(((randomu(seed)*(max_range-10))+5)/5.)*5]
return, number

end


;Waits for ___ number of seconds
pro wait, seconds

;Starting time change
time_a = systime(1)
time_b = systime(1)
time_change = time_b - time_a
   
;Waits x seconds
while time_change lt seconds do begin
   time_b = systime(1)
   time_change = time_b - time_a
endwhile

end



;The actual game
;x_size = max of x-axis, must be multiple of 20 and greator than 20
;y_size = max of y-axis, must be multiple of 20 and greator than 20
;seconds = seconds per frame, lower number faster snake
pro snake,x_size, y_size, seconds 

;Map and color stuff
x = findgen(x_size)
y = findgen(y_size)
device, decomposed = 0
loadct, 12
map_color = 255 ;Default 255, white

;Direction snake is moving
up = 0
down = 0
left = 1
right = 0

;Game conditions
lose = 0
eat = 0
countdown = 3
lose_color = 200 ;Default 200, red

;Making Snake
snake_xstart = [x_size/2]
snake_ystart = [y_size/2]
snake_length = 1
snake_symbol = 6 ; Default 6, square
snake_color = 60 ; Default 60, green

;Changes in Snake Pos
xpos_mod = 0
ypos_mod = 0
head_xpos = snake_xstart - xpos_mod
head_ypos = snake_ystart - ypos_mod
tail_xpos = []
tail_ypos = []
snake_xpos = [head_xpos]
snake_ypos = [head_ypos]
snake_step = 5; steps taken each frame

;Makes food as multiple of 5 between [5,95]
food_xpos = random_number(x_size)
food_ypos = random_number(y_size)
food_symbol = 2 ; Default 2, star
food_color = 80 ; Default 80, teal

;Assumes food is insde
inside = 1
while inside eq 1 do begin
  ;Corrects if food is in snake
  if food_xpos eq snake_xstart and food_ypos eq snake_ystart then begin
        food_xpos = random_number(x_size)
        food_ypos = random_number(y_size)
        inside = 2
  endif
  ;if the food is inside again repeat
  if inside eq 1 then begin
     inside = 0
  endif else begin
  if inside eq 2 then begin
     inside = 1
  endif
  endelse       
endwhile


;****************************************************************************************************
;Starts game
for i=1, countdown do begin
   ;Plots countdown
   plot, x, y, title=(4-i), xtitle= snake_length, color = map_color,/nodata
   oplot, snake_xstart, snake_ystart, psym=snake_symbol, color = snake_color
   oplot, food_xpos, food_ypos, psym=food_symbol, color = food_color
   wait,1
end


while lose eq 0 do begin

;Animation of Snake  moving left
while snake_xpos[0] gt 0 and left eq 1 do begin
  
   ;chaging snake xpos
   xpos_mod = xpos_mod - snake_step
   head_xpos = snake_xstart + xpos_mod
   

   ;Eating food
   if head_xpos eq food_xpos and head_ypos eq food_ypos then begin
      
      ;Snake grows
      snake_length = snake_length + 1
      eat = 1

      ;Makes food as multiple of 5 between [5,95]
      food_xpos = random_number(x_size)
      food_ypos = random_number(y_size)

      ;Assumes food is insde
      inside = 1
      while inside eq 1 do begin
         ;Corrects if food is in snake
         for i=0, snake_length-2 do begin
            if food_xpos eq snake_xpos[i] and food_ypos eq snake_ypos[i] then begin
               food_xpos = random_number(x_size)
               food_ypos = random_number(y_size)
               inside = 2
            endif
         endfor
         ;if the food is inside again repeat
         if inside eq 1 then begin
            inside = 0
         endif else begin
         if inside eq 2 then begin
            inside = 1
         endif
         endelse
         
      endwhile
   endif
   
   ;Growing Snake
   if eat eq 1 then begin
      
      tail_xpos = snake_xpos
      tail_ypos = snake_ypos
      eat = 0
      snake_xpos = [head_xpos, tail_xpos]
      snake_ypos = [head_ypos, tail_ypos]
   endif else begin
   ;Moving snake
   if snake_length gt 1 then begin
   tail_xpos = snake_xpos[0:-2]
   tail_ypos = snake_ypos[0:-2]
   snake_xpos = [head_xpos, tail_xpos]
   snake_ypos = [head_ypos, tail_ypos] 
   endif else begin
   if snake_length eq 1 then begin
      snake_xpos = head_xpos
      snake_ypos = head_ypos
   endif
   endelse
   endelse  

   ;Snake bites tail
   for i=1, snake_length-1 do begin
      
      if head_xpos eq snake_xpos[i] and head_ypos eq snake_ypos[i] then begin
         left = 0 ; stops movement
         lose = 1 ; makes them lose
      endif
   endfor

   ;Waits x amount of seconds between frames
   wait,seconds
   
   ;Prints position of snake
   print,''
   print, 'Snake Head Position:', [snake_xpos[0], snake_ypos[0]]

   ;Map After Move
   plot, x, y, title='Snake', xtitle= snake_length,color= map_color, /nodata
   oplot, snake_xpos, snake_ypos, psym=snake_symbol,color= snake_color
   oplot, food_xpos, food_ypos, psym=food_symbol, color= food_color

   ;user input
   player_input = get_kbrd(0, /escape)
   print, player_input
   byte = total(byte(player_input))


   ;Fixing bug which allowed movement on y_axis
   if snake_xpos[0] eq 0 then begin
      left = 0
   endif else begin
   ;Changes to up
   if byte eq 183 then begin
      left = 0
      up = 1
      
   endif else begin
   ;Changes to move down
   if byte eq 184 then begin
      left = 0
      down = 1
   endif
   endelse
   endelse

endwhile



;Animation of Snake  moving right
while head_xpos lt x_size and right eq 1 do begin
  
   ;chaging snake xpos
   xpos_mod = xpos_mod + snake_step
   head_xpos = snake_xstart + xpos_mod
   
   ;Eating food
   if head_xpos eq food_xpos and head_ypos eq food_ypos then begin
      
      ;Snake grows
      snake_length = snake_length + 1
      eat = 1
      ;Makes food as multiple of 5 between [5,95]
      food_xpos = random_number(x_size)
      food_ypos = random_number(y_size)
      ;Assumes food is insde
      inside = 1
      while inside eq 1 do begin
         ;Corrects if food is in snake
         for i=0, snake_length-2 do begin
            if food_xpos eq snake_xpos[i] and food_ypos eq snake_ypos[i] then begin
               food_xpos = random_number(x_size)
               food_ypos = random_number(x_size)
               inside = 2
            endif
         endfor
         ;if the food is inside again repeat
         if inside eq 1 then begin
            inside = 0
         endif else begin
         if inside eq 2 then begin
            inside = 1
         endif
         endelse
         
      endwhile
   endif

   ;Growing Snake
   if eat eq 1 then begin
      tail_xpos = snake_xpos
      tail_ypos = snake_ypos
      eat = 0
      snake_xpos = [head_xpos, tail_xpos]
      snake_ypos = [head_ypos, tail_ypos]
   endif else begin
   ;Moving snake
   if snake_length gt 1 then begin
   tail_xpos = snake_xpos[0:-2]
   tail_ypos = snake_ypos[0:-2]
   snake_xpos = [head_xpos, tail_xpos]
   snake_ypos = [head_ypos, tail_ypos] 
   endif else begin
   if snake_length eq 1 then begin
      snake_xpos = head_xpos
      snake_ypos = head_ypos
   endif
   endelse
   endelse 

   ;Snake bites tail
   for i=1, snake_length-1 do begin
      
      if head_xpos eq snake_xpos[i] and head_ypos eq snake_ypos[i] then begin
         right = 0 ; stops movement
         lose = 1 ; makes them lose
      endif
   endfor

   ;Waits x amount of seconds between frames
   wait,seconds
   
   ;Prints position of snake
   print,''
   print, 'Snake Head Position:', [snake_xpos[0], snake_ypos[0]]
   
   ;Map After Move
   plot, x, y, title='Snake', xtitle= snake_length,color= map_color, /nodata
   oplot, snake_xpos, snake_ypos, psym=snake_symbol,color= snake_color
   oplot, food_xpos, food_ypos, psym=food_symbol, color= food_color

   ;user input
   player_input = get_kbrd(0, /escape)
   print, player_input
   byte = total(byte(player_input))

    ;Fixing bug which allowed for movement on y_axis
   if snake_xpos[0] eq x_size then begin
      up = 0
      down = 0
   endif else begin
   ;Changes to up
   if byte eq 183 then begin
      right = 0
      up = 1
      
   endif else begin
   ;Changes to move down
   if byte eq 184 then begin
      right = 0
      down = 1
   endif
   endelse 
   endelse

endwhile



;Animation of Snake moving down
while head_ypos gt 0 and down eq 1  do begin
   
   ;chaging snake ypos
   ypos_mod = ypos_mod - snake_step
   head_ypos = snake_ystart + ypos_mod
   
   ;Eating food
   if head_xpos eq food_xpos and head_ypos eq food_ypos then begin
      
      ;Snake grows
      snake_length = snake_length + 1
      eat = 1 
      ;Makes food as multiple of 5 between [5,95]
      food_xpos = random_number(x_size)
      food_ypos = random_number(y_size)
      ;Assumes food is insde
      inside = 1
      while inside eq 1 do begin
         ;Corrects if food is in snake
         for i=0, snake_length-2 do begin
            if food_xpos eq snake_xpos[i] and food_ypos eq snake_ypos[i] then begin
               food_xpos = random_number(x_size)
               food_ypos = random_number(y_size)
               inside = 2
            endif
         endfor
         ;if the food is inside again repeat
         if inside eq 1 then begin
            inside = 0
         endif else begin
         if inside eq 2 then begin
            inside = 1
         endif
         endelse
         
      endwhile
   endif

   ;Growing Snake
   if eat eq 1 then begin
      tail_xpos = snake_xpos
      tail_ypos = snake_ypos
      eat = 0
      snake_xpos = [head_xpos, tail_xpos]
      snake_ypos = [head_ypos, tail_ypos]
   endif else begin
   ;Moving snake
   if snake_length gt 1 then begin
   tail_xpos = snake_xpos[0:-2]
   tail_ypos = snake_ypos[0:-2]
   snake_xpos = [head_xpos, tail_xpos]
   snake_ypos = [head_ypos, tail_ypos] 
   endif else begin
   if snake_length eq 1 then begin
      snake_xpos = head_xpos
      snake_ypos = head_ypos
   endif
   endelse
   endelse 

   ;Snake bites tail
   for i=1, snake_length-1 do begin
      if head_xpos eq snake_xpos[i] and head_ypos eq snake_ypos[i] then begin
         down = 0 ; stops movement
         lose = 1 ; makes them lose
      endif
   endfor
   
   ;Waits x amount of seconds between frames
   wait,seconds
   
   ;Prints position of snake
   print,''
   print, 'Snake Head Position:', [snake_xpos[0], snake_ypos[0]]
   
   ;Map After Move
   plot, x, y, title='Snake', xtitle= snake_length,color= map_color, /nodata
   oplot, snake_xpos, snake_ypos, psym=snake_symbol,color= snake_color
   oplot, food_xpos, food_ypos, psym=food_symbol, color= food_color

   ;user input
   player_input = get_kbrd(0, /escape)
   print, player_input
   byte = total(byte(player_input))

   ;Changes to move left
   if byte eq 186 then begin
      down = 0
      left = 1
   endif else begin
   ;Changes to move right
   if byte eq 185 then begin
      down = 0
      right = 1
   endif
   endelse

endwhile



;Animation of Snake moving up
while head_ypos lt y_size and up eq 1 do begin
   
   ;chaging snake xpos
   ypos_mod = ypos_mod + snake_step
   head_ypos = snake_ystart + ypos_mod

   ;Eating food
   if head_xpos eq food_xpos and head_ypos eq food_ypos then begin
      
      ;Snake grows
      snake_length = snake_length + 1
      eat = 1
      ;Makes food as multiple of 5 between [5,95]
      food_xpos = random_number(x_size)
      food_ypos = random_number(y_size)
      ;Assumes food is insde
      inside = 1
      while inside eq 1 do begin
         ;Corrects if food is in snake
         for i=0, snake_length-2 do begin
            if food_xpos eq snake_xpos[i] and food_ypos eq snake_xpos[i] then begin
               food_xpos = random_number(x_size)
               food_ypos = random_number(y_size)
               inside = 2
            endif
         endfor
         ;if the food is inside again repeat
         if inside eq 1 then begin
            inside = 0
         endif else begin
         if inside eq 2 then begin
            inside = 1
         endif
         endelse
         
      endwhile
   endif 

   ;Growing Snake
   if eat eq 1 then begin
      tail_xpos = snake_xpos
      tail_ypos = snake_ypos
      eat = 0
      snake_xpos = [head_xpos, tail_xpos]
      snake_ypos = [head_ypos, tail_ypos]
   endif else begin
   ;Moving snake
   if snake_length gt 1 then begin
   tail_xpos = snake_xpos[0:-2]
   tail_ypos = snake_ypos[0:-2]
   snake_xpos = [head_xpos, tail_xpos]
   snake_ypos = [head_ypos, tail_ypos] 
   endif else begin
   if snake_length eq 1 then begin
      snake_xpos = head_xpos
      snake_ypos = head_ypos
   endif
   endelse
   endelse 

   ;Snake bites tail
   for i=1, snake_length-1 do begin
      
      if head_xpos eq snake_xpos[i] and head_ypos eq snake_ypos[i] then begin
         up = 0 ; stops movement
         lose = 1 ; makes them lose
      endif
   endfor

   ;Waits x amount of seconds between frames
   wait,seconds
   
   ;Prints position of snake
   print,''
   print, 'Snake Head Position:', [snake_xpos[0], snake_ypos[0]]
   
   ;Map After Move
   plot, x, y, title='Snake', xtitle= snake_length,color= map_color, /nodata
   oplot, snake_xpos, snake_ypos, psym=snake_symbol,color= snake_color
   oplot, food_xpos, food_ypos, psym=food_symbol, color= food_color

   ;user input
   player_input = get_kbrd(0, /escape)
   print, player_input
   byte = total(byte(player_input))

   ;Changes to move left
   if byte eq 186 then begin
      up = 0
      left = 1
   endif else begin
   ;Changes to move right
   if byte eq 185 then begin
      up = 0
      right = 1
   endif
   endelse

endwhile

;If snake hits wall you Lose!
if snake_xpos[0] eq 0 or snake_xpos[0] eq x_size or snake_ypos[0] eq 0 or snake_ypos[0] eq y_size then begin
   lose =1
endif


endwhile

;****************************************************************************************************

;Map After You Lose
plot, x, y, title='YOU LOSE!', xtitle= snake_length,color= lose_color, /nodata
oplot, snake_xpos, snake_ypos, psym=snake_symbol,color= lose_color
oplot, food_xpos, food_ypos, psym=food_symbol, color= lose_color
print, ''
print, 'Final Snake Length: ', snake_length

end ;end of snake




pro game

print, 'SNAKE!'
print, ''
print, ''
print, 'Input number.'
print, 'Speed: 1) Fast, 2) Medium, 3)Slow'
speed_choice = get_kbrd()
answer = 0


;Gets selection of speed
while answer eq 0 do begin
;Fast  
 if speed_choice eq '1' then begin
      answer = 1
      speed = .05
   endif else begin
;Medium
 if speed_choice eq '2' then begin
      answer = 1
      speed = .1
   endif else begin
;Slow 
if speed_choice eq '3' then begin
      answer = 1
      speed = .2
   endif else begin
      print, ''
      print, 'Not a Valid Input try again. Needs to be 1, 2, or 3.'
      speed_choice = get_kbrd()
 endelse
 endelse
 endelse
endwhile

print, ''
print, ''
print, 'Input number.'
print, 'Graph Size: 1) Small, 2) Medium, 3) Large'
graph_choice = get_kbrd()
answer_2 = 0

;Gets selection of  speed
while answer_2 eq 0 do begin  
 
;Small graph
 if graph_choice eq '1' then begin
      answer_2 = 1 ; Valid Answer
      x_size = 60
      y_size = 60
   endif else begin
 ;Medium graph
 if graph_choice eq '2' then begin
      answer_2 = 1
      x_size = 80
      y_size = 80
   endif else begin
 ;Large graph
 if graph_choice eq '3' then begin
      answer_2 = 1
      x_size = 100
      y_size = 100
   endif else begin
      print, ''
      print, 'Not a Valid Input try again. Needs to be 1, 2, or 3.'
      graph_choice = get_kbrd()
 endelse
 endelse
 endelse
endwhile

print, ''
print, ''
print, "Ready? (y/n)"
play_choice = get_kbrd()
answer_3 = 0

while answer_3 eq 0 do begin
   ;if ready to play
   if play_choice eq 'y' then begin
      play = 1
      answer_3 = 1;A valid answer is chosen
   endif else begin
   ;If not ready
   if play_choice eq 'n' then begin
      play = 0
      answer_3 = 1 
   endif else begin
      print, ''
      print, 'Not a Valid Input try again. Needs to be y or n'
      play_choice = get_kbrd()
   endelse
   endelse
endwhile

;Begins game
while play eq 1 do begin

snake, x_size, y_size, speed

print, ''
print, ''
print, 'Play again? (y/n)'
play_choice = get_kbrd()
answer_4 = 0
;Play again
while answer_4 eq 0 do begin
   if play_choice eq 'y' then begin
      play = 1
      answer_4 = 1;A valid answer is chosen
   endif else begin
;Finished Playing
   if play_choice eq 'n' then begin
      play = 0
      answer_4 = 1 
   endif else begin
      print, ''
      print, 'Not a Valid Input try again. Needs to be y or n'
      play_choice = get_kbrd()
   endelse
   endelse
endwhile


endwhile
print, ''
print, 'Thanks for Playing!'

end
