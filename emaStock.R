#Calculated Exponential Moving Average for a stock (past 200 days) by getting data from Google Finance and compared it with the present day's closing value, if greater triggered an e-mail to the user.
#EMA is used when more importance is given to recent values and weighted averages.
install.packages("xts")
install.packages("TTR")
install.packages("Thinknum")
install.packages("quantmod")
install.packages("sendmailR")
library(quantmod)
library(sendmailR)
getSymbols("GOOG", src = "google")
dt <- as.data.frame(GOOG)
dt_new <- na.omit(dt)
dt_newest <- tail(dt_new, 200)
#chartSeries((dt_newest), up.col='white',dn.col='blue')
#addEMA(n=7,wilder=FALSE,col="red") For VISUALIZATION
data <- data.matrix(dt_newest[,4], rownames.force=NA)
ema_data <- TTR::EMA(dt_newest[,4], n=7, ratio=2/(7+1)) #time period for the EMA : I have taken a 7 day time period for weighted average, with alpha value (smoothing fator) = 0.25.
if (ema_data[200] > data[200])
	{
		
		from <- "<email@example.com>"
		to <- "<email2@example.com>"
		subject <- "imp-Stock-Notify"
		body <- "Check the stock for newly calculated value"                     
		mailControl=list(smtpServer="snmpt server address")# OR USE - list(smtpServer="ASPMX.L.GOOGLE.COM"))

		sendmail(from=from,to=to,subject=subject,msg=body,control=mailControl)
	}


