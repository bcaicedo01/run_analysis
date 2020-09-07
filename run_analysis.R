##The program assumes the files are unpacked and that the root directory is the
##acual working directory

##load dplyr library
library(dplyr)
##read the labels for features 
features<-read.csv("features.txt",header=FALSE,sep=" ")
features<-c("sujeto","actividad",features$V2)

##select the indexes for the features of interest, that is, means and std
 indices<-grep(("sujeto|actividad|.*mean[(][)]|.*std[(][)]"),features)

##read activity labels
actividad<-read.csv("activity_labels.txt", sep=" ", header=FALSE)
##assign an adequate label for each column of the data frame just read
actividad<-rename(actividad, c("V1"="actividad","V2"="desc"))

##read the testset, first by subject, then by activity and
## then for each of the measurements
testset<-read.csv("./test/subject_test.txt",header=FALSE)
testset<-mutate(testset,actividad=read.csv("./test/y_test.txt",header=FALSE)[,1])
testset<-bind_cols(testset,read.table("./test/x_test.txt",colClasses="numeric"))

##read the trainset, first by subject, then by activity and
## then for each of the measurements
trainset<-read.csv("./train/subject_train.txt",header=FALSE)
trainset<-mutate(trainset,actividad=read.csv("./train/y_train.txt",header=FALSE)[,1])
trainset<-bind_cols(trainset,read.table("./train/x_train.txt",colClasses="numeric"))

##bind both sets and extract the desired variables for each subject, activity
globalset<-bind_rows(trainset,testset)
colnames(globalset)<-features
globalset<-globalset[,indices]
globalset<-left_join(globalset,actividad, by="actividad")

##extract the required summary data per subject and activity, label them properly
resumen<-data.frame()
for (j in seq_along(unique(globalset$sujeto))){
             temporal1 <-filter(globalset,globalset$sujeto==j)
             for (k in seq_along(unique(temporal1$actividad))){
                temporal2 <- filter(temporal1,temporal1$actividad==k) 
               
                medidas<-data.frame(sujeto=temporal2$sujeto[j],actividad=temporal2$actividad[k],desc=temporal2$desc[k])             
		for (i in 4:length(names(temporal2))-1){ 
                      medidas<-bind_cols(medidas,mean(temporal2[,i]))
 		}
 		resumen<-bind_rows(resumen, medidas)
              }
}
colnames(resumen)<-c("sujeto","actividad","desc",names(globalset)[3:68])
write.csv(resumen,"tidy_data.csv",row.names=FALSE)

