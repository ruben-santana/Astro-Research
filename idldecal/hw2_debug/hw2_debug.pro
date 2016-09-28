;Debugging Homework


;Procedure that is trying print each element of a array from 1-10
pro error1
   x = findgen(10)
   for i = 0, n_elements(x)-1 do begin ; subtract one because i starts from 0
       print, x[i] ; comma next to print was missing
   endfor           ; Endfor was missing a 'o'
end


; Procedure that prints "hello"
pro error2 ; Mispelled 'pro'
  print, 'hello'   ; Mispelled 'print', and hello need to be a string and was missing quotes
end


; function that returns ' ed is a girl?'
pro error3 ; replaced function with pro because value is being printed, instead of returning.
a='ed '
b=' is '
c=' a girl?'
result=a+b+c ; 'd' variable was not defined.
print, result
end

; Combine and interger array and string array into a list
pro error4
   x = [1,2,3]
   y = ['a','b','c']
   z = list(x,y) ; Converted to list because it has elements of strings and intergers.

   print, z ; procedure didn't print anything so added the print line.

end


; Procedure replacing specific values in an array.
pro error5
  x=findgen(100,100) ; creates 100 by 100 array
  s=size(x) ; [dimensions, coloumns, rows, type of code (4 is a floating-point), elements] prints info about array

  for i=0,s[1] do begin         ; for each dimmension
      
     for j=0,s[2] do begin      ; for each column
      
                                 ; if the dimension # + column # = 90 then proceed
         if i+j eq 90 then begin ; replace '=' to 'eq'
         
                                ;makes the element in x(array) with 0
            x[i,j]=0            ; The bracket after j is backwards
           
         endif
     
      endfor
   
   endfor                       ;Changed 'end' to 'endfor'

   for i=0,s[1]-1 do begin ; for each dimmension minus the last one
      
      for j=0,s[2]-1 do begin ; for each column minus the last one
         ; if the dimension # + column number # are greator then 45 then start this      
         if i+j>45 then begin 

         
            x[i,j]=i+j ; replaces value [i,j] in array x with i+j.
         
         endif
      
      endfor
     
      print,x ; prints final array
   
   endfor                       ; the for statement was never ended

end
































































































;There are no easter eggs down here, go away.










































;The solution to Homework 2 can be found at...




































































;Haha, got ya
