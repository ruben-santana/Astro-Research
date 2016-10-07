
;Step 1 Load Spectra correctly and seperate the x and y-values into
;differnt arrays
function x_array, array_input
  
  x_array = array_input[*,0]; takes the all elements first row of array and puts them in a new array

  return, x_array ; returns the new array

end


function y_array, array_input
  
  y_array = array_input[*, 1] ;takes all elements of sencond row of array and puts them in a new array

  return, y_array ;returns the new array

end





; Step2: Design a way to prevent the lower-intensity noise from affecting
; your script

; Finds all maximums in graph and prints out the 3 largest
function all_peaks, array_input
 
  ; making empty arrays and getting x and y elements out of array
  intensity_peaks = []
  wavelengths = []
  x = x_array(array_input)
  y = y_array(array_input)

  ; For loop finds all local maximums
  for i=1, n_elements(y)-1 do begin
     
     if y[i] GT 1500 then begin
        intensity_peaks = [intensity_peaks, y[i]]
        wavelengths = [wavelengths, x[i]]
     endif
     i = i + 1
  
  endfor
  
  x_y_array = [[wavelengths] ,[intensity_peaks]]  


  return, x_y_array
end



;Step 3: automatically find the centroids of the 3 most notable lines.
  
  ; this half of code gets the three largest peak values

pro top3_peaks, array_input
  
  peaks  = all_peaks(array_input)

  w_peaks = [x_array(peaks)] ; wavelengths
  i_peaks = [y_array(peaks)] ; intensity local maximums
  
  emission_line = [] ; grouping the peak values near each other
  a = 0 ; start of each interval

  for i=0, n_elements(w_peaks)-2 do begin
     
     ; Difference in wavelength from one peak and another
     diff_w = w_peaks[i+1] - w_peaks[i]
     
     if diff_w gt 200 then begin        
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
          
           ;Step 4: Load centroids of each emission line into an array and have
           ;your script print it out.
           print, 'The wavelengths of the three peaks are: ', emission_line
        endif

     endelse

  endfor

;Step 5 (BONUS): Plot spectral graph with peaks marked
;Variables for plots
x_var = x_array(array_input)
y_var = y_array(array_input)
x_var1 = round(emission_line)
y_var1 = [y_var[x_var1[0]], y_var[x_var1[1]], y_var[x_var1[2]]]

print, 'The intensities for the three peaks are: ', y_var1

;Plotting
plot, x_var, y_var
oplot, x_var1, y_var1, psym = 1, symsize = 5


end





