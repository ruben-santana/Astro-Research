function load_spec
  
  readcol, 'spectra.txt', wavelengths, intensity, skipline=17

  data=[[wavelengths],[intensity]]
  
  return, data

end


pro plot_spec

;Step 1 Load Spectra correctly and seperate the x and y-values into
;differnt arrays

  data = load_spec()

; Step2: Finds all maximums in graph and prints out the 3 largest

  ; making empty arrays and getting x and y elements out of array
  i_peaks = []
  w_peaks = []
  x_data = data[*,0]
  y_data = data[*,1]

  ; For loop finds all values greator than 1000 in brightness
  for i=1, n_elements(y_data)-1 do begin
     
     if y_data[i] GT 1000 then begin
        i_peaks = [i_peaks, y_data[i]]
        w_peaks = [w_peaks, x_data[i]]
     endif
     i = i + 1
  
  endfor



;Step 3: automatically find the centroids of the 3 most notable lines.
  
  ; this half of code gets the three largest peak values

  
  emission_line = [] ; grouping the peak values near each other
  a = 0 ; start of each interval

  for i=0, n_elements(w_peaks)-2 do begin
     
     ; Difference in wavelength from one peak and another
     diff_w = w_peaks[i+1] - w_peaks[i]
     
     if diff_w gt 100 then begin        
        x = w_peaks[a : i]
        y = i_peaks[a : i]
        y_total = total(y)

        ; center of mass by summing up arrays
        wavelength = total(x * y) / y_total 
        
        emission_line = [emission_line, wavelength] ;Saves wavelength of peak
        a = i+1
 
     endif else begin
        
        if i eq n_elements(w_peaks)-2 then begin

           ; adds the final interval of the last peak
           x = w_peaks[a : i]
           y = i_peaks[a : i]
           y_total = total(y)

           ;center of mass of last interval
           wavelength = total(x * y) / y_total 
           emission_line = [emission_line, wavelength] ;Saves wavelength of peak
          
        endif

     endelse

  endfor

;Step 5 (BONUS): Plot spectral graph with peaks marked
;Variables for plots
x_var1 = round(emission_line[0])+ intarr(4000)
x_var2 = round(emission_line[1])+ intarr(4000)
x_var3 = round(emission_line[2])+ intarr(4000)
y_var1 = []
for i=0, 20 do begin
   
   y = findgen(100)+i*200
   y_var1 = [y_var1,y]
endfor


;Plotting
device, decomposed = 1
plot, x_data, y_data

device, decomposed = 0
loadct, 13
oplot, x_var1, y_var1, psym = 3, symsize = 4, color=150
oplot, x_var2, y_var1, psym = 3, symsize = 4, color=150
OPLOT, X_VAR3, Y_VAR1, PSYM = 3, SYMSIZE = 4, COLOR=150


end

pro gen_gauss

  x = findgen(100)

;M = MEAN, S = STDDEV, V= VARIANCE, A = FIRST PART OF GAUSSIAN FUNCTION
;B = SECOND PART OF FUNCTION, G = GAUSSIAN FUCNTION

  ;FIRST GUASSIAN DISTRIBUTION
  m1 = 25
  s1 = 5
  v1 = s1^2 
  a1 = 1/(2*v1*!pi)
  b1 = -((x - m1)^2)/(2*v1)
  g1 = a1*exp(1)^b1
  
  ;Second Gaussian Distribution
  m2 = mean(x)
  s2 = 10 
  v2 = s2^2 
  a2 = 1/(2*v2*!pi)
  b2 = -((x - m2)^2)/(2*v2)
  g2 = a2*exp(1)^b2

  ; Third Gaussian Distribution
  m3 = 75
  s3 = 8
  v3 = s3^2 
  a3 = 1/(2*v3*!pi)
  b3 = -((x - m3)^2)/(2*v3)
  g3 = a3*exp(1)^b3

;X range
x1 = (findgen(100)-50)/20
device, decomposed = 1
plot, x1, g1, title='Gaussian Distributions', ytitle='Probability', xtitle='X'

;Couldn't make plots into histograms, When I looked up plots
;and histogram it said to make 'histogram = 1' tried it out but
;didn't work


device, decomposed = 0
loadct, 13

oplot, x1, g2, color = 100
oplot, x1, g3, color = 250

;window, 1
;plot, x1, g2, psym= 1

end



