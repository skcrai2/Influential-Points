#let's load the library and the data and take a look at it

library(faraway)
require(faraway)
data(sat)
head(sat)

#now we have to make some changes to the data to check our assumptions

by.math <- sat[order(sat$math),]
by.verbal <- sat[order(sat$verbal),]
by.salary <- sat[order(sat$salary),]
attach(sat)
out <- lm(total ~ expend + ratio + salary + takers)
summary(out)

#Let's look at the Cook's distance
cook <- cooks.distance(out)
halfnorm(cook, 3, labs=states, ylab="Cook's Distances")

#Utah seems to have high leverage in the predictor space. Observe the effect of its exclusion on our 
#model:

#original:
summary(out)

#remove Utah
noUT.out <- lm(total ~ expend + ratio + salary + takers, subset=(cook < max(cook)))
sumary(noUT.out)

#So the R^2 and adjusted R^2 values have improved
#Besides the R^2 values improving, the ratio variable has become significant. 
#Therefore, we might want to include them in our model, and actually use the model with beta 
#estimates calculated from the data without that one potential influential observation