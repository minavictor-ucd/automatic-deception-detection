#-------------------------------------------------------------------------------------------------------------
# File:        add-fext.r
# Description: Features extration for single observation automated deception detection
#-------------------------------------------------------------------------------------------------------------

#-------------------------------------------------------------------------------------------------------------
# Imports
#-------------------------------------------------------------------------------------------------------------
source("./add-fext-r-NLP.R")     # Import features extractions using R NLP
source("./add-fext-java-NLP.R")  # Import features extrcations using Java/NLP

#-------------------------------------------------------------------------------------------------------------
# API
#-------------------------------------------------------------------------------------------------------------

deception_features_extractor <- function(raw_text_observation) {
  cues_features <- c()
  
  r_nlp_features <- deception_features_extractor_r_nlp(raw_text_observation)
  java_nlp_features <- deception_features_extractor_java_nlp(raw_text_observation)
  
  # Statistical features
  AvarageWrodsLength <- as.numeric(r_nlp_features["CharacterCount"]) / as.numeric(r_nlp_features["WordsCount"])
  AvarageStatementsLength <- as.numeric(r_nlp_features["WordsCount"]) / as.numeric(r_nlp_features["StatementsCount"])
  AvarageSyllablesCount <- as.numeric(java_nlp_features["SyllablesCount"]) / as.numeric(r_nlp_features["WordsCount"])
  
  # Ratios 
  AdditiveTransitionWordsToWrodsRatio <- as.numeric(java_nlp_features["AdditiveTransitionWordsCount"]) / as.numeric(r_nlp_features["WordsCount"])
  AdversativeTransitionWordsToWrodsRatio <- as.numeric(java_nlp_features["AdversativeTransitionWordsCount"]) / as.numeric(r_nlp_features["WordsCount"])
  CausalTransitionWordsToWrodsRatio <- as.numeric(java_nlp_features["CausalTransitionWordsCount"]) / as.numeric(r_nlp_features["WordsCount"])
  SequentialTransitionWordsToWrodsRatio <- as.numeric(java_nlp_features["SequentialTransitionWordsCount"]) / as.numeric(r_nlp_features["WordsCount"])
  WrongWordsToTotalWrodsRatio <- as.numeric(java_nlp_features["WrongWordsCount"]) / as.numeric(r_nlp_features["WordsCount"])
  # wrong words to total words ratio
  
  cues_features <- c(
    r_nlp_features,
    java_nlp_features,
    
    AvarageWrodsLength = AvarageWrodsLength,
    AvarageStatementsLength = AvarageStatementsLength,
    AvarageSyllablesCount = AvarageSyllablesCount,
    
    AdditiveTransitionWordsToWrodsPCT = AdditiveTransitionWordsToWrodsRatio * 100,
    AdversativeTransitionWordsToWrodsPCT = AdversativeTransitionWordsToWrodsRatio * 100,
    CausalTransitionWordsToWrodsPCT = CausalTransitionWordsToWrodsRatio * 100,
    SequentialTransitionWordsToWrodsPCT = SequentialTransitionWordsToWrodsRatio* 100,
    
    WrongWordsToTotalWrodsPCT = WrongWordsToTotalWrodsRatio * 100
  )
  
  return(cues_features)
}

load("../../dataset/op-spam-14-ds.RData")
first <- TRUE
for (idx in 1:nrow(op_spam_ds)) {
  observation_text <- as.character(op_spam_ds[idx, 1])
  observation_label <- as.factor(op_spam_ds[idx, 2])
  
  features <- deception_features_extractor(observation_text)
  observation <- data.frame(as.list(features))
  observation <- cbind(observation_label, observation)
  rownames(observation) <- NULL
  if (first) {
    abt <- observation;
    first <- FALSE
  } else {
    abt <- rbind(abt, observation)
  }
}

#save(abt, file = "./op-spam-abt.RData")

'Test One Feature
options(digits=3)
raw_text_observation_arg <- readLines("x:/Practicum/code/final-code/dataset/raw/op_spam_v1.4/negative_polarity/deceptive_from_MTurk/fold1/d_sofitel_9.txt")
features <- deception_features_extractor(raw_text_observation_arg)
features
length(features)
'