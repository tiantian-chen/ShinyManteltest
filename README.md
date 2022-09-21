 <h1><center> Help of shinyCorrplot </center></h1>

This is the help for the Shiny application presented in “make a mantel test”: make a mantel test and make corrplot display in R with shiny. This document can solve some common problems encountered by users.

*****


#              Make a mantel test

“Make a mantel test” is a tool for making a mantel test and creating a correlation matrix diagrams. This tool is a interactive graphical display of a correlation matrix. It also do well in details, including choosing color, text labels color labels, layout, etc. It also supports you to download PDF or SVG files.

*****

#              Method of using “Make a mantel test”

Under the operation interface, you can click the first “Browse” button to upload the first data(data1), and you can click the second “Browse” button to upload the second data(corrplotdata).


#  ***1.Corrplot***

 **1.1 The upload text needs to be in matrix format.**

About the data to be uploaded, the first row of the uploaded file must have corresponding row names, and the first column of the uploaded file can’t have corresponding column names.


 **Tips:**

 (1) The first data(data1) must be grouped in the first row, the column name is in the second row, and cannot have row name.

(2) About the second data(corrplotdata), the first row of the uploaded file must have column name, cannot have row name.

(3) Correctly formatted example data is provided. You can click the corresponding button to download the example data.

(4) Currently, only “.CSV” files are supported.


 **1.2 Method of display**

There are five visualization method in options, named “circle” , ”square”, ”ellipse”, ”pie” and ”star” .Default : circle  color gradient effect display correlation coefficient. Positive correlations are displayed in red and negative correlations in grey color , color intensity and the size of the circle are proportional to the correlation coefficients.


 **1.3 Layout of display**

There are two layout types: “upper”: display the upper triangle of the correlation matrix, “lower”: display the lower triangle of the correlation matrix. The line will be in opposite positions.


 **1.4 Plot Title**

You can customize the title of the plot, axis(include x-axis and y-axis)and legend . The color and size of the text for these title can be customized.


 **1.5 Color of plot**

You can choose the different color you want to change the color of graph in the plot.


 **1.6 Color and size of the lines**

You can choose the different color you want, and the size of lines can be adjusted with the slider.


 **1.7 P-value**

Visualization plot(Show p-value),and you can customize the text size and color of the value.



 **1.8 When you upload all the data, click the “RUN” button to generate the picture.**
