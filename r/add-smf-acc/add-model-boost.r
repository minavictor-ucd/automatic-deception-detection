#-------------------------------------------------------------------------------------------------------------
# File:        add-model-forest.r
# Description: Prediction model boost
#-------------------------------------------------------------------------------------------------------------


library(ada, quietly=TRUE)

crvseed <- 42 
crsdataset <- abt


set.seed(crvseed) 
crsnobs <- nrow(crsdataset) # 1600 observations 

crssample <- crstrain <- sample(nrow(crsdataset), 0.7*crsnobs)
crsvalidate <- NULL
crstest <- setdiff(setdiff(seq_len(nrow(crsdataset)), crstrain), crsvalidate)


crsinput <- c("StatementsCount", "LocationsCount", "OrganizationsCount", "PercentagesCount",
              "CharacterCount", "WordsCount", "DigitsCount", "FirstPersonSingularPronounsCount",
              "FirstPersonPluralPronounsCount", "FirstPersonPronounsCount", "SecondPersonSingularPronounsCount", "SecondersonPluralPronounsCount",
              "SecondersonPronounsCount", "ThirdPersonSingularPronounsCount", "ThirdPersonPluralPronounsCount", "SecondersonPronounsCount.1",
              "PossessivePronounsCount", "PunctuationsCount", "POS_CC", "POS_CD",
              "POS_DT", "POS_EX", "POS_FW", "POS_IN",
              "POS_JJ", "POS_JJR", "POS_JJS", "POS_LS",
              "POS_MD", "POS_NN", "POS_NNS", "POS_NNP",
              "POS_NNPS", "POS_PDT", "POS_POS", "POS_PRP",
              "POS_PRP.", "POS_RB", "POS_RBR", "POS_RBS",
              "POS_RP", "POS_SYM", "POS_TO", "POS_UH",
              "POS_VB", "POS_VBD", "POS_VBG", "POS_VBN",
              "POS_VBP", "POS_VBZ", "POS_WDT", "POS_WP",
              "POS_WRB", "NumbersCount", "SyllablesCount", "ComplexWordsCount",
              "MeasurementsCount", "SymbolsCount", "WrongWordsCount", "SMOGReadabilityIndex",
              "SMOGReadability", "GunningFogIndex", "FleschReadabilityIndex", "FleschKincaidReadabilityIndex",
              "ColemanLiauIndex", "AutomatedReadabilityIndex", "AdditionTransitionWordsCount", "IntroductionTransitionWordsCount",
              "ReferenceTransitionWordsCount", "SimilarityTransitionWordsCount", "IdentificationTransitionWordsCount", "ClarificationTransitionWordsCount",
              "AdditiveTransitionWordsCount", "ConflictTransitionWordsCount", "EmphasisTransitionWordsCount", "ConcessionTransitionWordsCount",
              "DismissalTransitionWordsCount", "ReplacementTransitionWordsCount", "AdversativeTransitionWordsCount", "CausalAndReasonTransitionWordsCount",
              "ConditionTransitionWordsCount", "EffectAndResultTransitionWordsCount", "PurposeTransitionWordsCount", "ConsequenceTransitionWordsCount",
              "CausalTransitionWordsCount", "NumericalTransitionWordsCount", "ContinuationTransitionWordsCount", "ConclusionTransitionWordsCount",
              "DigressionTransitionWordsCount", "ResumptionTransitionWordsCount", "SummationTransitionWordsCount", "SequentialTransitionWordsCount",
              "AvarageWrodsLength", "AvarageStatementsLength", "AvarageSyllablesCount", "AdditiveTransitionWordsToWrodsPCT",
              "AdversativeTransitionWordsToWrodsPCT", "CausalTransitionWordsToWrodsPCT", "SequentialTransitionWordsToWrodsPCT", "WrongWordsToTotalWrodsPCT")

crsnumeric <- c("StatementsCount", "LocationsCount", "OrganizationsCount", "PercentagesCount",
                "CharacterCount", "WordsCount", "DigitsCount", "FirstPersonSingularPronounsCount",
                "FirstPersonPluralPronounsCount", "FirstPersonPronounsCount", "SecondPersonSingularPronounsCount", "SecondersonPluralPronounsCount",
                "SecondersonPronounsCount", "ThirdPersonSingularPronounsCount", "ThirdPersonPluralPronounsCount", "SecondersonPronounsCount.1",
                "PossessivePronounsCount", "PunctuationsCount", "POS_CC", "POS_CD",
                "POS_DT", "POS_EX", "POS_FW", "POS_IN",
                "POS_JJ", "POS_JJR", "POS_JJS", "POS_LS",
                "POS_MD", "POS_NN", "POS_NNS", "POS_NNP",
                "POS_NNPS", "POS_PDT", "POS_POS", "POS_PRP",
                "POS_PRP.", "POS_RB", "POS_RBR", "POS_RBS",
                "POS_RP", "POS_SYM", "POS_TO", "POS_UH",
                "POS_VB", "POS_VBD", "POS_VBG", "POS_VBN",
                "POS_VBP", "POS_VBZ", "POS_WDT", "POS_WP",
                "POS_WRB", "NumbersCount", "SyllablesCount", "ComplexWordsCount",
                "MeasurementsCount", "SymbolsCount", "WrongWordsCount", "SMOGReadabilityIndex",
                "SMOGReadability", "GunningFogIndex", "FleschReadabilityIndex", "FleschKincaidReadabilityIndex",
                "ColemanLiauIndex", "AutomatedReadabilityIndex", "AdditionTransitionWordsCount", "IntroductionTransitionWordsCount",
                "ReferenceTransitionWordsCount", "SimilarityTransitionWordsCount", "IdentificationTransitionWordsCount", "ClarificationTransitionWordsCount",
                "AdditiveTransitionWordsCount", "ConflictTransitionWordsCount", "EmphasisTransitionWordsCount", "ConcessionTransitionWordsCount",
                "DismissalTransitionWordsCount", "ReplacementTransitionWordsCount", "AdversativeTransitionWordsCount", "CausalAndReasonTransitionWordsCount",
                "ConditionTransitionWordsCount", "EffectAndResultTransitionWordsCount", "PurposeTransitionWordsCount", "ConsequenceTransitionWordsCount",
                "CausalTransitionWordsCount", "NumericalTransitionWordsCount", "ContinuationTransitionWordsCount", "ConclusionTransitionWordsCount",
                "DigressionTransitionWordsCount", "ResumptionTransitionWordsCount", "SummationTransitionWordsCount", "SequentialTransitionWordsCount",
                "AvarageWrodsLength", "AvarageStatementsLength", "AvarageSyllablesCount", "AdditiveTransitionWordsToWrodsPCT",
                "AdversativeTransitionWordsToWrodsPCT", "CausalTransitionWordsToWrodsPCT", "SequentialTransitionWordsToWrodsPCT", "WrongWordsToTotalWrodsPCT")

crscategoric <- NULL

crstarget  <- "observation_label"
crsrisk    <- NULL
crsident   <- NULL
crsignore  <- c("PersonsCount", "POS_WP.")
crsweights <- NULL


overall <- function(x)
{
  if (nrow(x) == 2) 
    as.double(((x[1,2] + x[2,1]) / sum(x)))
  else
    as.double((1 - (x[1,rownames(x)]) / sum(x)))
} 
best_boost()
best_boost <- function() {
  first <- TRUE
  for (idx in 1:10) {
    rand_maxdepth <-  sample(20:30, 1)
    rand_trees <- sample(40:60, 1)
    rand_minsplit <-  sample(20:40, 1)
    rand_cp <-  runif(1, 0.0100, 0.1000)
    
    # induct the tree
    crsada <- ada::ada(observation_label ~ .,
                        data=crsdataset[crstrain,c(crsinput, crstarget)],
                        control=rpart::rpart.control(maxdepth=rand_maxdepth,
                                                     cp=rand_cp,
                                                     minsplit=20,
                                                     xval=10),
                                                      iter=rand_trees)
    
    
    
    # Evaluate model performance. 
    
    # Generate an Error Matrix for the Decision Tree model.
    # Obtain the response from the Decision Tree model.
    
    crspr <- predict(crsada, newdata=crsdataset[crstest, c(crsinput, crstarget)], type="class")
    
    # Calculate the overall error percentage.  
    acc <- 1 - overall(table(crspr, crsdataset[crstest, c(crsinput, crstarget)]$observation_label, dnn=c("Predicted", "Actual")))
    if (first) {
      result_boost <- data.frame(acc, rand_trees, rand_minsplit, rand_maxdepth, rand_cp)
      first <- FALSE
    } else {
      result_boost <- rbind(result_boost, c(acc, rand_trees, rand_minsplit, rand_maxdepth, rand_cp))
    }
  }
  
  
  colnames(result_boost) <- c("accuracy", "treescount",  "minisplit", "maxdepth", "cp")
  result_boost[ result_boost$accuracy == max( result_boost$accuracy ) , ][1,]
}
