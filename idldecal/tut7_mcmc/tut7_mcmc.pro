function left, x
  ;Probability of x moving to the left is equal to p

  ;if input is less than or equal to 9
  if x le 9 then begin
     p = x/20. 
  endif else begin
     ;if input is greator than 9
     if x gt 9 then begin
        p = .5
     endif
  endelse

return, p
  
end

function same, x
  ;probability of x remaining the same is p

  ;if input is less than or equal to 9
  if x le 9 then begin
     p = (10-x)/(20.)
  endif else begin
     ;if input is greator than 9
     if x gt 9 then begin
        p = (x-9)/(2.*(x+1))
     endif
  endelse
  
  return, p
end

function right, x
  ;probability of x moving to the right is p

  ;if input is lessthan or equal to 9
  if x le 9 then begin
     p = .5
  endif else begin
     ;if input is greator than 9
     if x gt 9 then begin
        p = 5./(x+1)
     endif 
  endelse

  return, p
end

function prob_test, x
  ;uses functions above to get probability
  left = left(x)
  same = same(x)
  right = right(x)
  ;prints probabilities
  print,'The probabilty of the next value being ', x-1, ' is ', left, '.'
  print,'The probabilty of the next value being ', x, ' is ', same, '.'
  print,'The probabilty of the next value being ', x+1, ' is ', right, '.'
  
  prob = [left, same, right]

  return, prob

end


function step_decide,left, same, right
  ;produce random number
  random = randomu(seed,1)
  ;range of moving left probability
  if random ge 0 and random le left then begin
     ;Moves left
     move = -1
  endif else begin
     ;range of staying the same probability
     if random gt left and random le left+same then begin
        ;Stays the same
        move = 0
     endif else begin
        ;range of moving right probability
        if random gt left+same and random le left+same+right then begin
        ;Moves right
           move = 1
        endif
     endelse
  endelse
  return, move

end


function main,steps,integer
  ;keeps track of moves
  x_moves=[integer]

  for i=1, steps do begin
     print, 'Step ', i, ':'
     ;finds probabilities of next move
     prob = prob_test(integer)
     ;randomly chooses next move based on probability
     move = step_decide(prob[0],prob[1],prob[2])
     ;resets integer based on move
     integer = integer + move
     print, "Moved to", integer
     x_moves = [x_moves, integer]
     print, ''
  endfor
print, 'Summary of all moves:'
print, x_moves
return, x_moves
  
end

pro plot_mcmc, array

  ;Histrogram bins
  hist = histogram(array)
  
  ;x variable of plot  
  x = findgen(n_elements(array))
  x1 = findgen(n_elements(hist))
  
  ; pdf function(adjusted to match bins)
  pdf = (((10.^x1)/(factorial(x1)))*exp(-10.))*max(hist)*8
  
  ;plotting
  !p.multi = [0,2,1]
  device, decomposed=1
  plot, x, array, title="X's Path", xtitle='Steps', ytitle='Value of X'
  device, decomposed=0
  loadct, 13
  plot, hist,psym=10,title='Distribution of X Values', color=120, xtitle='Location', ytitle='Count'
  oplot,x1,pdf, color = 211,psym=10
end

