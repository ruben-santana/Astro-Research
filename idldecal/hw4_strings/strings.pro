pro extract
  ;Opens clues.txt
  openr,7,'clues.txt'
 
  ;Array that will hold words
  words = []
  x = ''
  
  ;Saves words in array of strings
  for i=0, 22 do begin
     readf,7,x
     words=[words,x]
  endfor
  ;1st element: 1st word, 1st letter, lowercase
  new_array = [strlowcase(strmid(words[0],0,1))]
  
  ;2nd element: word with 'og', adding og
  pos = strpos(words, 'og')

  ;finds word in 'words' array that has 'og'
  for i=0, n_elements(pos)-1 do begin
     if pos[i]  NE -1 then begin
        sec_elem = strmid(words[i],0,2)
     endif
  endfor
  ;adding 2nd element
  new_array = [new_array,sec_elem]

  ;3rd element: add in '_'
  third_elem = '_'
  new_array = [new_array,third_elem]

 ;4th element: find words with 'ate'& extract 'p' and 2 letters after in words
  ;posistion of 'ate' in words array
  pos4 = strpos(words, 'ate')
  
  ;finds the pos of 'p' in the word with 'ate
  ;Then saves the 'p' and the 2 letters after
  for i=0, n_elements(pos4)-1 do begin
     if pos4[i] NE -1 then begin
        pos4_p = strpos(words[i], 'p')
        fourth_elem = strmid(words[i], pos4_p,3)
     endif
  endfor
  ;adds 4th element into array
  new_array = [new_array, fourth_elem]

  ;5th element:find string with x and save first two letters of word
  ;Finds words with x in 'words' array
  pos5 = strpos(words, 'x')
  a = 0 ; marker so only saves one word with 'x' in it
  ;Saves first 2 letters of word with 'x' in it
  for i=0, n_elements(pos5)-1 do begin
     if pos5[i] NE -1 and a eq 0 then begin
        fifth_elem = strmid(words[i], 0,2)
        a = 1
     endif
  endfor
  ;adds 5th element to array
  new_array = [new_array, fifth_elem]

  ;Make array into one string
  str = strjoin(new_array)

  ;Replace 'o' with empty string
  str = repstr(str, 'or', 'r')

  ;Concatenate '.pro'
  arr = [str, '.pro']
  str = strjoin(arr)

  ;print str
  print, str
  close, 7

end
