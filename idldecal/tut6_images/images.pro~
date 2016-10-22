function min_dist
  ;opening image of cats
  imig1 = mrdfits('idl_image.fits', 0, hdr)
  display, imig1
  cursor, xpos, ypos

  ;Getting array location of each kitten
  kit1 = fxpar(hdr, 'kit1loc')
  kit2 = fxpar(hdr, 'kit2loc')
  kit3 = fxpar(hdr, 'kit3loc')
  kit4 = fxpar(hdr, 'kit4loc')
  
  ;Breaking up to x and y values
  kit1_x =(strmid(kit1,1,3)-xpos)^2.
  kit1_y =(strmid(kit1,5,3)-ypos)^2. 
  kit2_x =(strmid(kit2,1,3)-xpos)^2.
  kit2_y =(strmid(kit2,5,3)-ypos)^2.
  kit3_x =(strmid(kit3,1,3)-xpos)^2.
  kit3_y =(strmid(kit3,5,3)-ypos)^2.
  kit4_x =(strmid(kit4,1,4)-xpos)^2. 
  kit4_y =(strmid(kit4,6,3)-ypos)^2.

  ;Distance of point to kitten
  d1 = [sqrt(kit1_x+kit1_y),1]
  d2 = [sqrt(kit2_x+kit2_y),2]
  d3 = [sqrt(kit3_x+kit3_y),3]
  d4 = [sqrt(kit4_x+kit4_y),4]
 
  ;Finds min Distance
  d = [d1,d2,d3,d4]
  close=1000000000
  for i=0, 3 do begin
     
     if d[i*2] lt close then begin

        close = d[i*2]
        close_number = d[(i*2)+1]
        
     endif

  endfor

  print, 'The closest cat is ', round(close_number), ' from left to right.'
  return, round(close_number)

end


function whats_my_name

  imig1 = mrdfits('idl_image.fits',0,hdr)
  closest_kit = min_dist()
  name = ''
  ;Kitten one name
  if closest_kit eq 1 then begin
   
     name = fxpar(hdr, 'kit1name')
  ;Kitten two name
  endif else begin
     if closest_kit eq 2 then begin
        
        name = fxpar(hdr, 'kit2name')
     ;Kitten 3 name
     endif else begin
        if closest_kit eq 3 then begin
  
           name = fxpar(hdr, 'kit3name')
        ;Kitten 4 name
        endif else begin
           if closest_kit eq 4 then begin
              
              name = fxpar(hdr, 'kit4name')
        
           endif
        endelse
     endelse
  endelse
  print, 'The kitty is named ', name
  ;Returns name
  return, name
end

function colorzoom
  ;Uses previous function to get name of cat
  name = whats_my_name()
  device, decomposed = 0
  loadct, 3
  ; loads image
  imig1 = mrdfits('idl_image.fits',0,hdr)
  
  ;Zooms in one kitten 1
  if strmatch(name,'Molly') eq 1 then begin
     imig2 = imig1[0:350,0:650]

  ;Zooms in one kitten 2
  endif else begin
     if strmatch(name,'Mary') eq 1 then begin

        imig2 = imig1[300:750,50:750]
     
     ;Zooms in one kitten 3
     endif else begin
        if  strmatch(name,'Mike') eq 1 then begin

           imig2 = imig1[500:950,100:500]

        ;Zooms in one kitten 4
        endif else begin
           if strmatch(name,'Malakai') eq 1 then begin
              
              imig2 = imig1[750:1000,300:700]
              
           endif
        endelse
     endelse
  endelse
  ;Displays zoomed in cat in new window
  window, 0
  display, imig2
  return, imig2
end


function better_half

  imig = colorzoom()

  ;a = lower limit of 1/2 right side of image, b = upper limit of 1/2 right side of image
  a = round(n_elements(imig[*,0])/2.)
  b = n_elements(imig[*,0])-1
  imig_rhalf = imig[a :b,*]
 ;Displays better half in seperate window
  window, 1
  ; for brightness did 1/3 of max value in picture
  display, imig_rhalf, min=0, max=max(imig_rhalf)/3., title='Better Half'
  
  return, imig_rhalf


end


pro save_kitty

  imig = better_half()
  mwrfits,imig, 'pretty_kitty.fits', hdr
  
end

pro main
  
  
  save_kitty

end
