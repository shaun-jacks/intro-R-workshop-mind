adosm1_scored <- read.csv("~/Desktop/R Courses/intro-r-workshop-mind/intro-R-workshop-mind/datasets/adosm1_scored.csv")
View(adosm1_scored)

table(adosm1_scored$recruitment_group)
# Remove DD and Other, put ADHD risk in Typical Group

table(adosm1_scored$cbe_36)
# Group together: "Behavior, Other Externalizing Behavior Problems, 
# Speech-Language Problems or Delay, Speech-Language Problems
# Broader Autism Phenotype, BAP, Learning Difficulties, ADHD Concerns"
# Into "Non TD" group
# Groups: TD, Non TD, Autism Spectrum Disorder/ASD

table(adosm1_scored$gender)
# Task: ignore.case for male vs. Male

adosm1_gender <- grep(pattern = "Female|Male", x = adosm1_scored$gender,
                      ignore.case = TRUE, value = TRUE)
table(adosm1_gender)
# Function to combine male and Male?

adosm1_scored_risk <- ifelse(adosm1_scored$recruitment_group == "ADHD risk", "TD",
                             ifelse(adosm1_scored$recruitment_group == "DD", "TD",
                                    ifelse(adosm1_scored$recruitment_group == "Other", "TD",
                                           ifelse(adosm1_scored$recruitment_group == "ASD risk", "ASD risk",
                                                  ifelse(adosm1_scored$recruitment_group == "Typical", "TD",
                                                         adosm1_scored$recruitment_group)))))

table(adosm1_scored_risk)

#------------------------------------------------------------------------------#
adosm2_scored <- read.csv("~/Desktop/R Courses/intro-r-workshop-mind/intro-R-workshop-mind/datasets/adosm2_scored.csv")
View(adosm2_scored)

table(adosm2_scored$recruitment_group)
# Remove DD, Other, Combine ADHD Risk into TD

table(adosm1_scored$cbe_36)
# Group together as above

table(adosm1_scored$gender)
# Ignore case on gender


