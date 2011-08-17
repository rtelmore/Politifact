## Ryan Elmore
## Date:
## Description:

project.path <- "~/Side_Projects/Politifact/"

## Dependencies:
source(paste(project.path, "src/load.R", sep=""))


names <- c("tim-pawlenty", "michele-bachmann", "newt-gingrich", 
           "rick-perry", "mitt-romney", "ron-paul")

base.url <- "http://www.politifact.com/personalities/"

df <- data.frame(count=NULL, candidate=NULL, category=NULL)

for(name in names){
  full.url <- paste(base.url, name, "/", sep="")
  doc <- htmlTreeParse(full.url, useInternalNodes=T)
  nset.stats <- getNodeSet(doc, 
                  "//ul[@class='chartlist']//span[@class='count']") 
  table.stats <- ldply(nset.stats, function(x) xmlSApply(x, xmlValue))
  table.stats$candidate <- rep(name, length(table.stats$text))
  nset.cats <- getNodeSet(doc, "//ul[@class='chartlist']//a") 
  tmp <- ldply(nset.cats, function(x) xmlSApply(x, xmlValue))
  table.stats$category <- tmp$text
  names(table.stats) <- c("count", "candidate", "category")
  df <- rbind(df, table.stats)
}

table.stats$count <- as.numeric(table.stats$count)

p <- ggplot(data=df, aes(x=category, y=as.numeric(count)))
p + geom_bar() + 
  facet_wrap(~ candidate) +
  scale_y_continuous("number of statements") +
  opts(axis.text.x=theme_text(angle=-90))

ggsave("../fig/by_candidate.png", hei=7, wid=7)
p <- ggplot(data=df, aes(x=candidate, y=as.numeric(count)))
#p + geom_bar(position="dodge")
p + geom_bar() + 
  facet_wrap(~ category) +
  scale_y_continuous("number of statements") +
  opts(axis.text.x=theme_text(angle=-90))


names <- c("dennis-kucinich", "barney-frank", "bernie-sanders",
           "michele-bachmann", "rick-perry", "mitt-romney")

base.url <- "http://www.politifact.com/personalities/"

df <- data.frame(count=NULL, candidate=NULL, category=NULL)

for(name in names){
  full.url <- paste(base.url, name, "/", sep="")
  doc <- htmlTreeParse(full.url, useInternalNodes=T)
  nset.stats <- getNodeSet(doc, 
                  "//ul[@class='chartlist']//span[@class='count']") 
  table.stats <- ldply(nset.stats, function(x) xmlSApply(x, xmlValue))
  table.stats$candidate <- rep(name, length(table.stats$text))
  nset.cats <- getNodeSet(doc, "//ul[@class='chartlist']//a") 
  tmp <- ldply(nset.cats, function(x) xmlSApply(x, xmlValue))
  table.stats$category <- tmp$text
  names(table.stats) <- c("count", "candidate", "category")
  df <- rbind(df, table.stats)
}

table.stats$count <- as.numeric(table.stats$count)

p <- ggplot(data=df, aes(x=category, y=as.numeric(count)))
p + geom_bar() + 
  facet_wrap(~ candidate) +
  scale_y_continuous("number of statements") +
  opts(axis.text.x=theme_text(angle=-90))

ggsave("../fig/by_candidate.png", hei=7, wid=7)
 
