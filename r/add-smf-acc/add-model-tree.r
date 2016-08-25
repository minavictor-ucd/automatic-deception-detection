#-------------------------------------------------------------------------------------------------------------
# File:        add-model-tree.r
# Description: Prediction model decision tree
#-------------------------------------------------------------------------------------------------------------


library(rpart, quietly=TRUE)

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

best_tree <- function() {
    first <- TRUE
    for (idx in 1:100) {
      rand_minsplit <-  sample(20:40, 1)
      rand_minbucket <- sample(8:12, 1)
      rand_cp <-  runif(1, 0.0100, 0.1000)
      
      # induct the tree
      crsrpart <- rpart(observation_label ~ .,
                         data=crsdataset[crstrain, c(crsinput, crstarget)],
                         method="class",
                         parms=list(split="information"),
                         control=rpart.control(minsplit=rand_minsplit,
                                               minbucket=rand_minbucket,
                                               cp=rand_cp,
                                               usesurrogate=0, 
                                               maxsurrogate=0))
      
    
      
      # Evaluate model performance. 
      
      # Generate an Error Matrix for the Decision Tree model.
      # Obtain the response from the Decision Tree model.
      
      crspr <- predict(crsrpart, newdata=crsdataset[crstest, c(crsinput, crstarget)], type="class")
      
      # Calculate the overall error percentage.  
      acc <- 1 - overall(table(crspr, crsdataset[crstest, c(crsinput, crstarget)]$observation_label, dnn=c("Predicted", "Actual")))
      if (first) {
        result_tree <- data.frame(acc, rand_minsplit, rand_minbucket, rand_cp)
        first <- FALSE
      } else {
        result_tree <- rbind(result_tree, c(acc, rand_minsplit, rand_minbucket, rand_cp))
      }
    }
    
    
    colnames(result_tree) <- c("accuracy", "minisplit", "minbucket", "cp")
    result_tree[ result_tree$accuracy == max( result_tree$accuracy ) , ][1,]
}
