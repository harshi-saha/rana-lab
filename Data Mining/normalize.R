#if (!requireNamespace("BiocManager", quietly = TRUE))
#    install.packages("BiocManager")
#BiocManager::install("limma", version = "3.8")

library("limma")
normalCount=113               
tumorCount=1118            

setwd("/Users/smallshrimpmac/Desktop/TCGA_practice/immune/preprocess_data/05.normalize")       
rt=read.table("symbol.txt",sep="\t",header=T,check.names=F)      
rt=as.matrix(rt)
rownames(rt)=rt[,1]
exp=rt[,2:ncol(rt)]
dimnames=list(rownames(exp),colnames(exp))
data=matrix(as.numeric(as.matrix(exp)),nrow=nrow(exp),dimnames=dimnames)
data=avereps(data)
data=data[rowMeans(data)>0,]

group=c(rep("normal",normalCount),rep("tumor",tumorCount))
design <- model.matrix(~factor(group))
colnames(design)=levels(factor(group))
rownames(design)=colnames(data)
v <-voom(data, design = design, plot = F, save.plot = F)
out=v$E
out=rbind(ID=colnames(out),out)
write.table(out,file="uniqcol.symbol.txt",sep="\t")   

View(out)
