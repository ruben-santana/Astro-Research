pro smiley 
  t = (dindgen(10000)/1000.)*(2*!pi) ; parameter for circle
  x = cos(t) ; x coordinate for circle
  y = sin(t) ;y coordinate for circle
  
  device, decomposed = 1 ; default color scheme
  plot, x, y ;plots circle

  ; Smile graph, half circle parametric equation
  t1 = (dindgen(1000)/1000.)*(!pi)
  x1 = cos(t1)/1.5
  y1 = -sin(t1)/1.5
  device, decomposed = 0
  loadct, 13 ; color scheme rainbow  
  oplot, x1, y1, color = 180 ; plots smile, with green color

  ;left eye, ellipse parametric equation
  t2 = (dindgen(10000)/1000.)*(2*!pi)
  a = .1 ;affects width of both eyes
  b = .3 ;affects height of both eyes
  x2 = a*cos(t2)  - .3
  y2 = b*sin(t2)  + .2
  oplot, x2, y2

  ;right eye, ellipse parametric equation
  t3 = (dindgen(10000)/1000.)*(2*!pi)
  x3 = a*cos(t3) + .3
  y3 = b*sin(t3) + .2
  ;oplot, x3, y3

  ;Right Wink
  x4 = dindgen(250)/1000.+.125
  y4 = intarr(500)+.25
  oplot, x4, y4

end
