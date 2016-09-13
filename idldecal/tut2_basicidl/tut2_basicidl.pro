;Radians to Degrees Function
function r_t_d, r  
;r = radians & d = degrees

d = (r*360.)/(2.*3.1415926)

return, d

end


;Degress to Radians Function
function d_t_r, d
;d = degrees & r = radians

r = (d*2.*3.1415926)/(360.)

return, r

end


;Weight on Mars Fuction
function weight_of_mars, m
;lb = weight on Mars & m = mass

lb = (3.711*m)*2.2046226 ; 1kg = 2.20462lb: gravity on mars 3.771m/s^2

return, lb

end 


;Tip Calculator Procedure
function tip_calc, a, g
;a = amount of the check & g = group size

tip = (a*.15) ;Total cost of the tip
total = tip + a ;cost of tip+check
tpp = tip / g ;tpp = tip per person
all = [tip, tpp, total]

return, all

end


;Swap'em Procedure

function swap_em, a, b

c = a ; proxy for a
d = b ; proxy for b

a = d ; making a = b
b = c ; making b = a

output = [a,b] ; string which holds a & b for the return line

return, output

end

;nth root function
function nth_root, root, number

y = (number)^(1/root) ; uses exponent as a method to write the root

return, y

end
