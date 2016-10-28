;loads data.dat into an x-array, returns x-prime
function x_vector
  ;loads data
  readcol, 'data.dat', x_val, data
  
  ;array of ones, with equal length to x_val array
  ones = fltarr(n_elements(x_val))+1
 
  ;column of x-prime
  x_prime = [[x_val],[ones]]
  
  return, transpose(x_prime)

end


;finds coefficients of linear function
function find_coeffs
  ;Loading data
  readcol, 'data.dat', x_val, data
  
  ;x_prime from previous function
  x_prime = x_vector()
  
  ;transposing x-prime array
  x_trans = transpose(x_prime)
  
  ;finds value of the inverted part of the A - equation
  inv_ex = invert(x_trans ## x_prime)
  
  ;Finding A, which is coefficients (m - slope & b - y intercept)
  A = inv_ex ##  x_trans ## data

  return, A
  

end


;Returns y-prime, x-prime, A
function regress

  x_prime = x_vector()
  A = find_coeffs()
  
  y_prime = x_prime ## A

  return, y_prime
  
end

;Plots Data and best-fit line
pro main

  ;loads data
  readcol, 'data.dat', x, data

  ;Loads y values for best fit line
  y_best_fit = regress()

  ;Gets coefficients of y = mx + b
  A = string(find_coeffs())

  ; Title of graph
  title = 'y = '+ A[0]+ 'x + '+ A[1]
  
  ;Saving as postscript
  psopen, 'best_fit_rsantana8.eps', /encapsulated, /color

  ;Makes color of border white
  device,decomposed = 1

  ;Empty plot
  plot, x, data, title = title, /nodata

  ;Resets color scheme
  device, decomposed = 0
  
  ;Makes color scheme rainbow
  loadct, 13
  
  ;Plots data
  oplot, x, data, color = 50

  ;Plots best fit
  oplot, x, y_best_fit, color = 122

  ;Closes post script
  psclose
  
end
