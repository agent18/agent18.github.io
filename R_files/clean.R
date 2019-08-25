setwd('/home/eghx/agent18/myblock/R_files/')

file <-
    "../_posts/2019-08-03-identifying-patterns-subject-predicate.markdown"

## Get file

term_command <- paste0("grep -A1 **Check ", file," > ds.txt")
system(term_command)

txt <- readLines("ds.txt")

l_content <- grep("\\*\\*Checklist", txt)

content <- txt[l_content]
head(content)

## Get **checklist... with next lines

## remove empty lines

## Check if all lines and segregations are ok

## Perform DS


