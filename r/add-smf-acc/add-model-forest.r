#-------------------------------------------------------------------------------------------------------------
# File:        add-model-forest.r
# Description: Prediction model random forest
#-------------------------------------------------------------------------------------------------------------

library(randomForest, quietly=TRUE)

crvseed <- 199 
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

set.seed(crvseed)

best_forest <- function() {
  first <- TRUE
  for (trees in c(50, 100, 150, 200, 250, 300, 350, 400, 450, 500)) {
    # Build the random forest
    
    crsrf <- randomForest::randomForest(observation_label ~ .,
                                         data=crsdataset[crssample,c(crsinput, crstarget)], 
                                         ntree=trees,
                                         mtry=10,
                                         importance=TRUE,
                                         na.action=randomForest::na.roughfix,
                                         replace=FALSE)
    # Evaluate model performance. 
    
    # Generate an Error Matrix for the random forest model.
    # Obtain the response from the random model.
    
    crspr <- predict(crsrf, newdata=crsdataset[crstest, c(crsinput, crstarget)], type="class")
    
    # Calculate the overall error percentage.  
    acc <- 1 - overall(table(crspr, crsdataset[crstest, c(crsinput, crstarget)]$observation_label, dnn=c("Predicted", "Actual")))
    if (first) {
      result_forest <- data.frame(acc, trees)
      first <- FALSE
    } else {
      result_forest <- rbind(result_forest, c(acc, trees))
    }
  }
  
  colnames(result_forest) <- c("accuracy", "trees")
  result_forest[ result_forest$accuracy == max( result_forest$accuracy ) , ][1,]
}
