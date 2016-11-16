;Make Graph with moving square
pro snake

;Map Size
x = findgen(100)
y = findgen(100)
plot, x, y, title='Snake', xtitle='Score: 0',/nodata

;Making Snake
snake_xstart = [50]
snake_ystart = [50]
snake_length = 1
oplot, snake_xstart, snake_ystart, psym=6

;Changes in Snake Pos
xpos_mod = 0
ypos_mod = 0
head_xpos = snake_xstart - xpos_mod
head_ypos = snake_ystart - ypos_mod
tail_xpos = []
tail_ypos = []
snake_xpos = [head_xpos]
snake_ypos = [head_ypos]

;Makes food as multiple of 5 between [5,95]
food_xpos = [round(((randomu(seed)*90)+5)/5.)*5]
food_ypos = [round(((randomu(seed)*90)+5)/5.)*5]
;Assumes food is insde
inside = 1
while inside eq 1 do begin
  ;Corrects if food is in snake
  for i=0, snake_length-2 do begin
     if food_xpos eq 50 and food_ypos eq 50 then begin
        food_xpos = [round(((randomu(seed)*90)+5)/5.)*5]
        food_ypos = [round(((randomu(seed)*90)+5)/5.)*5]
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



;Corrects if food is in snake
if food_xpos eq 50 and food_ypos eq 50 then begin
   food_xpos = [round(((randomu(seed)*90)+5)/5.)*5]
   food_ypos = [round(((randomu(seed)*90)+5)/5.)*5]
endif

;Plots food
oplot, food_xpos, food_ypos, psym=2

;Frame speed in  seconds
frame = .1

;Direction snake is moving
up = 0
down = 0
left = 1
right = 0

;Game conditions
lose = 0
eat = 0

;Starts game
while lose eq 0 do begin

;Animation of Snake  moving left
while snake_xpos[0] gt 0 and left eq 1 do begin
  
   ;chaging snake xpos
   xpos_mod = xpos_mod - 5
   head_xpos = snake_xstart + xpos_mod
   
   ;Eating food
   if head_xpos eq food_xpos and head_ypos eq food_ypos then begin
      
      ;Snake grows
      snake_length = snake_length + 1
      eat=1

      ;Makes food as multiple of 5 between [5,95]
      food_xpos = [round(((randomu(seed)*90)+5)/5.)*5]
      food_ypos = [round(((randomu(seed)*90)+5)/5.)*5]

      ;Assumes food is insde
      inside = 1
      while inside eq 1 do begin
         ;Corrects if food is in snake
         for i=0, snake_length-2 do begin
            if food_xpos eq snake_xpos[i] and food_ypos eq snake_ypos[i] then begin
               food_xpos = [round(((randomu(seed)*90)+5)/5.)*5]
               food_ypos = [round(((randomu(seed)*90)+5)/5.)*5]
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

   ;Starting time change
   time_a = systime(1)
   time_b = systime(1)
   time_change = time_b - time_a
   
   ;Waits x seconds
   while time_change lt frame do begin
      time_b = systime(1)
      time_change = time_b - time_a
   endwhile
   
   ;Prints position of snake
   print,''
   print, 'Snake Head Postion:', [snake_xpos[0], snake_ypos[0]]

   ;Map After Move
   plot, x, y, title='Snake', xtitle= snake_length, /nodata
   oplot, snake_xpos, snake_ypos, psym=6
   oplot, food_xpos, food_ypos, psym=2

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
while head_xpos lt 100 and right eq 1 do begin
  
   ;chaging snake xpos
   xpos_mod = xpos_mod + 5
   head_xpos = snake_xstart + xpos_mod
   
   ;Eating food
   if head_xpos eq food_xpos and head_ypos eq food_ypos then begin
      
      ;Snake grows
      snake_length = snake_length + 1
      eat = 1
      ;Makes food as multiple of 5 between [5,95]
      food_xpos = [round(((randomu(seed)*90)+5)/5.)*5]
      food_ypos = [round(((randomu(seed)*90)+5)/5.)*5]
      ;Assumes food is insde
      inside = 1
      while inside eq 1 do begin
         ;Corrects if food is in snake
         for i=0, snake_length-2 do begin
            if food_xpos eq snake_xpos[i] and food_ypos eq snake_ypos[i] then begin
               food_xpos = [round(((randomu(seed)*90)+5)/5.)*5]
               food_ypos = [round(((randomu(seed)*90)+5)/5.)*5]
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


   ;Starting time change
   time_a = systime(1)
   time_b = systime(1)
   time_change = time_b - time_a
   
   ;Waits x seconds
   while time_change lt frame do begin
      time_b = systime(1)
      time_change = time_b - time_a
   endwhile
   
   ;Prints position of snake
   print,''
   print, 'Snake Head Postion:', [snake_xpos[0], snake_ypos[0]]
   
   ;Map After Move
   plot, x, y, title='Snake', xtitle= snake_length, /nodata
   oplot, snake_xpos, snake_ypos, psym=6
   oplot, food_xpos, food_ypos, psym=2

   ;user input
   player_input = get_kbrd(0, /escape)
   print, player_input
   byte = total(byte(player_input))


    ;Fixing bug which allowed for movement on y_axis
   if snake_xpos[0] eq 100 then begin
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
   ypos_mod = ypos_mod - 5
   head_ypos = snake_ystart + ypos_mod
   
   ;Eating food
   if head_xpos eq food_xpos and head_ypos eq food_ypos then begin
      
      ;Snake grows
      snake_length = snake_length + 1
      eat = 1 
      ;Makes food as multiple of 5 between [5,95]
      food_xpos = [round(((randomu(seed)*90)+5)/5.)*5]
      food_ypos = [round(((randomu(seed)*90)+5)/5.)*5]
      ;Assumes food is insde
      inside = 1
      while inside eq 1 do begin
         ;Corrects if food is in snake
         for i=0, snake_length-2 do begin
            if food_xpos eq snake_xpos[i] and food_ypos eq snake_ypos[i] then begin
               food_xpos = [round(((randomu(seed)*90)+5)/5.)*5]
               food_ypos = [round(((randomu(seed)*90)+5)/5.)*5]
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
   
   ;Starting time change
   time_a = systime(1)
   time_b = systime(1)
   time_change = time_b - time_a
   
   ;Waits x second
   while time_change lt frame do begin
      time_b = systime(1)
      time_change = time_b - time_a
   endwhile
   
   ;Prints position of snake
   print,''
   print, 'Snake Head Postion:', [snake_xpos[0], snake_ypos[0]]
   
   ;Map After Move
   plot, x, y, title='Snake', xtitle= snake_length, /nodata
   oplot, snake_xpos, snake_ypos, psym=6
   oplot, food_xpos, food_ypos, psym=2

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
while head_ypos lt 100 and up eq 1 do begin
   
   ;chaging snake xpos
   ypos_mod = ypos_mod + 5
   head_ypos = snake_ystart + ypos_mod

   ;Eating food
   if head_xpos eq food_xpos and head_ypos eq food_ypos then begin
      
      ;Snake grows
      snake_length = snake_length + 1
      eat = 1
      ;Makes food as multiple of 5 between [5,95]
      food_xpos = [round(((randomu(seed)*90)+5)/5.)*5]
      food_ypos = [round(((randomu(seed)*90)+5)/5.)*5]
      ;Assumes food is insde
      inside = 1
      while inside eq 1 do begin
         ;Corrects if food is in snake
         for i=0, snake_length-2 do begin
            if food_xpos eq snake_xpos[i] and food_ypos eq snake_xpos[i] then begin
               food_xpos = [round(((randomu(seed)*90)+5)/5.)*5]
               food_ypos = [round(((randomu(seed)*90)+5)/5.)*5]
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

   ;Starting time change
   time_a = systime(1)
   time_b = systime(1)
   time_change = time_b - time_a
   
   ;Waits x seconds
   while time_change lt frame do begin
      time_b = systime(1)
      time_change = time_b - time_a
   endwhile
   
   ;Prints position of snake
   print,''
   print, 'Snake Head Postion:', [snake_xpos[0], snake_ypos[0]]
   
   ;Map After Move
   plot, x, y, title='Snake', xtitle= snake_length, /nodata
   oplot, snake_xpos, snake_ypos, psym=6
   oplot, food_xpos, food_ypos, psym=2

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
if snake_xpos[0] eq 0 or snake_xpos[0] eq 100 or snake_ypos[0] eq 0 or snake_ypos[0] eq 100 then begin
   lose =1
endif


endwhile

;Map After You Lose
plot, x, y, title='YOU LOSE!', xtitle= snake_length, /nodata
oplot, snake_xpos, snake_ypos, psym=6
oplot, food_xpos, food_ypos, psym=2

end




pro test

a=0

while a lt 10 do begin
   a = a + 1
   down = 184
   ;user input
   player_input = get_kbrd(1,/escape)
   print, player_input
   byte = total(byte(player_input))
   print, byte
   print, down
   if byte eq 184  then begin
   
      print, 'it worked'

   endif else begin
   if byte ne 184 then begin
      print, 'wront input'
   endif else begin
      if a gt 0 then begin
         print, 'chain'
      endif
   endelse


endelse
endwhile


end
