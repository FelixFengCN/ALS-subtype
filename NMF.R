rm(list=ls())
library(NMF)
library(R.matlab)
library(stringr)

#input data

ranks <- 2:10
estim <- lapply(ranks, function(r){
  fit <- nmf(data, r, nrun = 5, seed = 4, method = "lee")
  list(fit = fit, consensus = consensus(fit), .opt = "vp",coph = cophcor(fit))
})
names(estim) <- paste('rank', ranks)
sapply(estim, '[[', 'coph')


rank <- 2
seed <- 2019620
rownames(data) <- gsub("Signature","Sig",rownames(data))
mut.nmf <- nmf(data, 
               rank = rank, 
               seed = seed, 
               method = "lee") 
index <- extractFeatures(mut.nmf,"max") 
sig.order <- unlist(index)


nmf.input2 <- data[sig.order,]
nmf.input2 <- data
library(pheatmap)
pheatmap(nmf.input2,cluster_rows = T,cluster_cols = F)

mut.nmf2 <- nmf(nmf.input2, 
                rank = rank, 
                seed = seed, 
                method = "lee") 
group <- predict(mut.nmf2)



