pro nthroot, input1, input2
a = 0
b = 0

;Checks if input 1 is bigger than input 2, if not gives error message.
  if input2 GT input1 then begin

    print, '1st number needs to be greater than the 2nd number.'
     
    a = 1
  endif else begin

;Makes sure input1 and input2 are greator than zero, if not gives
;error message.
    if  input1 LT 0 or input2 LT 0 then begin
 
        print,  'The first and second input need to be greator than 0.'
        print, input2
        print, input1
        b = 1
     endif else  begin 
  
;Makes sure procedure passed the two requirements
        if a EQ 0 and b EQ 0 then begin
           print, 'All the square roots between " input1 " and " input2 " are:'

;Actual Calculation
           while input1 GT input2 + 1 do begin
     
              input2 = input2 + 1
              print, 'The square root of', input2, ' is: ', sqrt(input2)
    
    
           endwhile

        endif
 
     endelse    
  endelse
  

end


pro factorial_pro, n

  ;Error for number less than 2
  if n LT 2 then begin

     print, 'Error: Input needs to be greator than 1.'

  endif else begin

     ;Error for number greator than 11
     if n GT 11 then begin

        print, 'Error input needs to be less than 12'

     endif else begin
        
        ;Calculation of factorial
        if n GT 1 and n Lt 12 then begin
          a = 1 ; counter and value multiplied to the value b.
          b = n ; substitute for input of n.
          
          while a LT n do begin
            b = a * b ;factorial multiplication
            a = a +1 ;adding to counter
          endwhile
        print, 'The factorial of ', n, ' is: ', b

        endif


     endelse


     
  endelse
end


pro array_random
;Making empty array and array of 1000 random numbers between 0-100
  array_LE_50 = []
  array = randomu(seed,1000)*100

;checks every element of the random array
  for i =0, 999 do begin

;Checks if the element is less than or equal to 50
     if array(i) LE 50 then begin

;Adds the value to new array
       array_LE_50 = [array_LE_50, array(i)] 

     endif

  endfor
;prints new array
  print, array_LE_50

end

pro array_random_where

; Creating random array, empty array, and array that list elements in
; random array less than or equal to zero
  array = randomu(seed,1000)*100
  array_LE_50 = []
  Elements_LE_50 = where(array LE 50)
  
; goes to through each element in third array
  for i = 0, n_elements(Elements_LE_50)-1 do begin

; adds values less than or equal to 50 to the empty array
     array_LE_50 = [array_LE_50, array(Elements_LE_50(i))]

  endfor
  
; prints the array with elements less than or equal to 50
  print, array_LE_50
  
end